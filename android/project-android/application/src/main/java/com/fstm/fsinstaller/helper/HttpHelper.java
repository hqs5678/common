package com.fstm.fsinstaller.helper;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fstm.fsinstaller.app.ActivityManager;
import com.hqs.utils.Log;
import com.hqs.utils.NetUtils;
import com.hqs.utils.SharedPreferenceUtil;

import org.xutils.HttpManager;
import org.xutils.common.Callback;
import org.xutils.http.RequestParams;
import org.xutils.x;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

/**
 * Created by apple on 16/9/27.
 */

public class HttpHelper {

    private static String sessionId = SharedPreferenceUtil.get("sessionId", null);
    private static ArrayList<String> loadingUrls = new ArrayList<>();

    public static void uploadFile(final String url, final Map<String, Object> params, String fileKey, ArrayList<String> filePaths, final HttpProgressCallBack httpProgressCallBack) {

        RequestParams requestParams = new RequestParams(url);
        requestParams.setConnectTimeout(1000 * 30);

        if (filePaths != null && filePaths.size() > 0){

            Log.print("upload file path:");
            for (String filePath: filePaths){
                Log.print(filePath);
                File file = new File(filePath);
                if (file.exists()){
                    try {
                        String fileName = UUID.randomUUID().toString() + ".png";
                        requestParams.addBodyParameter(fileKey, new FileInputStream(file), "multipart/form-data", fileName);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                else{
                    if (httpProgressCallBack != null){
                        httpProgressCallBack.onHttpResult(false, "文件为空, 请检查文件路径是否正确: " + filePath, null);
                    }
                    return;
                }
            }
        }
        else{
            if (httpProgressCallBack != null){
                httpProgressCallBack.onHttpResult(true, "文件为空", null);
            }
            return;
        }

        // 添加其他参数
        Set<String> keys = params.keySet();
        for(String key: keys){
            requestParams.addBodyParameter(key, params.get(key).toString());
        }
        requestParams.addHeader("header", genHeader());
        requestParams.addHeader("cookie", sessionId);

        HttpManager http = x.http();
        http.post(requestParams, new Callback.ProgressCallback<String>() {
            @Override
            public void onSuccess(String result) {

                Log.print("onSuccess");
                Log.print(url);
                Log.print(params);
                Log.print(result);
                if (httpProgressCallBack != null){
                    JSONObject jsonObject = JSON.parseObject(result);
                    if (jsonObject != null){
                        try {
                            httpProgressCallBack.onHttpResult(jsonObject.getBoolean("state"), jsonObject.getString("msg"), (JSON) jsonObject.get("data"));
                        } catch (Exception e) {
                            httpProgressCallBack.onHttpResult(jsonObject.getBoolean("state"), jsonObject.getString("msg"), null);
                        }
                    }
                    else{
                        httpProgressCallBack.onHttpResult(false, result, null);
                    }
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

                Log.print("onError");
                Log.print(ex.getMessage());
                if (httpProgressCallBack != null){
                    httpProgressCallBack.onHttpResult(false, "request error:" + ex.getMessage(), null);
                }
            }

            @Override
            public void onCancelled(CancelledException cex) {

                Log.print("onCancelled");
                Log.print(cex.getMessage());
                if (httpProgressCallBack != null){
                    httpProgressCallBack.onHttpResult(false, "request canceled: " + cex.getMessage(), null);
                }
            }

            @Override
            public void onFinished() {
            }

            @Override
            public void onWaiting() {
            }

            @Override
            public void onStarted() {
            }

            @Override
            public void onLoading(long total, long current, boolean isDownloading) {
                if (httpProgressCallBack != null){
                    httpProgressCallBack.onLoading(total, current, isDownloading);
                }
            }
        });
    }


    //     Map<String, Object> params

    public static void doPost(final String url, final Map<String, Object> params, final HttpCallBack callBack){

        if (NetUtils.isConnected(ActivityManager.getInstance().getCurrentActivity()) == false){
            Log.print("网络连接错误");
            callBack.onHttpResult(false, "请检测您的网络是否畅通", null);
            return;
        }

        String pString = map2JsonString(params);
        final String key = url + pString;
        if (loadingUrls.contains(key)){
            return;
        }
        else{
            loadingUrls.add(key);
        }
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    final JSONObject result = httpRequest(url, "POST", params);
                    if (result != null){
                        Helper.doInMainThread(new Runnable() {
                            @Override
                            public void run() {

                                try {
                                    callBack.onHttpResult(result.getBoolean("state"), result.getString("msg"), (JSON) result.get("data"));
                                } catch (Exception e) {
                                    callBack.onHttpResult(result.getBoolean("state"), result.getString("msg"), null);
                                }

                                if (result.getString("msg").contains("登录超时")){
                                    // 跳转到登录界面
                                    sessionId = null;
                                    ActivityHelper.gotoLoginActivity();
                                }

                            }
                        });
                    }
                    Log.print(url);
                    Log.print(result.toString());
                    Log.print(".");
                    Log.print(".");
                    Log.print(".");
                    Log.print(".");
                    Log.print(".");

                } catch (final Exception e) {
                    e.printStackTrace();
                    Helper.doInMainThread(new Runnable() {
                        @Override
                        public void run() {
                            String msg = e.getMessage();
                            if (msg == null){
                                msg = "网络连接错误";
                            }
                            if(msg.contains("EHOSTUNREACH") || msg.contains("Unable to resolve host")
                                    || msg.contains("ECONNREFUSED")) {
                                msg = "不能连接到服务器, 请检测您的网络是否畅通";
                            }
                            else if (msg.contains("Unable to resolve host")){
                                msg = "请检测您的网络是否畅通";
                            }
                            callBack.onHttpResult(false, msg, null);
                        }
                    });
                } finally {
                    loadingUrls.remove(key);
                }
            }
        }).start();
    }

    private static JSONObject httpRequest(String urlString,String method, Map<String, Object> params) throws Exception {
        StringBuffer sb = new StringBuffer();

        URL url = new URL(urlString);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        setupConnection(conn);
        conn.setRequestMethod(method);  //使用get请求

        if (params != null){
            conn.setDoOutput(true);
            String paramString = map2JsonString(params);

            Log.print(paramString);

            OutputStream os = conn.getOutputStream();
            os.write(paramString.getBytes());
            os.flush();
        }

        // 取得sessionid.
        String cookieval = conn.getHeaderField("set-cookie");
        if(cookieval != null) {
            sessionId = cookieval.substring(0, cookieval.indexOf(";"));
            SharedPreferenceUtil.set("sessionId", sessionId);
        }

        Log.print("sessionId: " + sessionId);

        InputStream is = conn.getInputStream();
        InputStreamReader isr = new InputStreamReader(is);
        BufferedReader bufferReader = new BufferedReader(isr);
        String inputLine  = "";
        while((inputLine = bufferReader.readLine()) != null){
            sb.append(inputLine);
        }
        bufferReader.close();
        is.close();

        JSONObject jsonObject = JSONObject.parseObject(sb.toString());
        return jsonObject;
    }

    private static void setupConnection(HttpURLConnection conn){
        conn.setDoInput(true);          //允许输入流，即允许下载
        conn.setRequestProperty("Content-type", "application/json");
        conn.setRequestProperty("Accept-Charset", "utf-8");
        conn.setRequestProperty("header",genHeader());
        if(sessionId != null) {
            conn.setRequestProperty("cookie", sessionId);
        }
    }

    private static String map2JsonString(Map<String, Object> map){

        JSONObject jsonObject = new JSONObject(map);
        return jsonObject.toJSONString();
    }

    private static String genHeader(){
        JSONObject jsonObject = new JSONObject();
        String userId = SharedPreferenceUtil.get("userId", "this_is_inital_userId");
        jsonObject.put("userId",userId);
        jsonObject.put("appSecret","fdsafdsaffdsa");
        jsonObject.put("requestTime",System.currentTimeMillis() + "");
        jsonObject.put("token","this_is_inital_token");
        jsonObject.put("append", UUID.randomUUID().toString());
        jsonObject.put("device","2");
        jsonObject.put("apiCode","0");
        jsonObject.put("sign","fdsafdsafs");

        Log.print("header: " + jsonObject.toString());
        return jsonObject.toJSONString();
    }

    public interface HttpCallBack{
        void onHttpResult(boolean success, String message, JSON data);
    }

    public interface HttpProgressCallBack extends HttpCallBack{
        void onLoading(long total, long current, boolean isDownloading);
    }

}



