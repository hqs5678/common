package com.fstm.fsinstaller.app;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.text.TextUtils;

import com.baidu.mapapi.SDKInitializer;
import com.fstm.fsinstaller.helper.DBHelper;
import com.fstm.fsinstaller.helper.Helper;
import com.fstm.fsinstaller.utils.FileUtil;
import com.hqs.utils.Log;
import com.hqs.utils.SharedPreferenceUtil;
import com.umeng.analytics.MobclickAgent;
import com.wenming.library.LogReport;
import com.wenming.library.save.imp.CrashWriter;
import com.wenming.library.upload.http.HttpReporter;

import org.xutils.BuildConfig;
import org.xutils.x;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.ArrayList;

/**
 * Created by apple on 16/9/27.
 */

public class Application extends android.app.Application {

    private static Application instance;

    public static Application getInstance() {
        return instance;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        instance = this;

        // 百度地图
        SDKInitializer.initialize(this);

        Helper.setHandler(new Handler());
        SharedPreferenceUtil.initSharedPreference(this);

        // 监听activity
        registerActivityCallback();

        // xutils初始化
        x.Ext.init(this);
        x.Ext.setDebug(BuildConfig.DEBUG);

        // 初始化 db helper
        DBHelper.init();

        // 初始化日志框架
        initCrashReport();

        // 友盟
        MobclickAgent.UMAnalyticsConfig config = new MobclickAgent.UMAnalyticsConfig(this, "5839208ce88bad6d12001746", "beijing");
        config.mIsCrashEnable = true;
        MobclickAgent.startWithConfigure(config);
        MobclickAgent.setCheckDevice(true);
        MobclickAgent.setScenarioType(this, MobclickAgent.EScenarioType.E_UM_NORMAL);

//        MobclickAgent.setDebugMode(true);
//        Log.print(getDeviceInfo(this));

        // 发送闪退日志
        sendLog();
        Log.enable = true;

//        PushManager manager = PushManager.getInstance();
//        manager.initialize(getApplicationContext());
//        manager.turnOnPush(getApplicationContext());
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        Log.print("...onConfigurationChanged");
    }

    @Override
    public void onTerminate() {
        super.onTerminate();
        Log.print("...onTerminate");
    }

    private void sendLog(){
        Helper.doInBackground(new Runnable() {
            @Override
            public void run() {
                String logFile = FileUtil.userDocumentPath() + "/log/";
                ArrayList<File> files = FileUtil.findFiles(logFile);
                if (files != null && files.size() > 0){
                    for (File file: files){
                        String log = FileUtil.fileToString(file);
                        MobclickAgent.reportError(getApplicationContext(), log);
                    }
                }
                FileUtil.removeDir(new File(logFile));
            }
        });
    }


    private void initCrashReport() {

        HttpReporter logUpload = new HttpReporter(getApplicationContext());
        logUpload.setUrl("");
        logUpload.setBodyParam("");

        String logFile = FileUtil.userDocumentPath() + "/log/";

        LogReport.getInstance()
                .setCacheSize(30 * 1024 * 1024)//支持设置缓存大小，超出后清空
                .setLogDir(getApplicationContext(), logFile)
                .setWifiOnly(true)//设置只在Wifi状态下上传，设置为false为Wifi和移动网络都上传
                .setLogSaver(new CrashWriter(getApplicationContext()))//支持自定义保存崩溃信息的样式
                .setUploadType(logUpload)
                //.setEncryption(new AESEncode()) //支持日志到AES加密或者DES加密，默认不开启
                .init(getApplicationContext());
//        initEmailReporter();
    }

//    /**
//     * 使用EMAIL发送日志
//     */
//    private void initEmailReporter() {
//        EmailReporter email = new EmailReporter(this);
//        email.setReceiver("wenmingvs@gmail.com");//收件人
//        email.setSender("wenmingvs@163.com");//发送人邮箱
//        email.setSendPassword("apptest1234");//邮箱的客户端授权码，注意不是邮箱密码
//        email.setSMTPHost("smtp.163.com");//SMTP地址
//        email.setPort("465");//SMTP 端口
//        LogReport.getInstance().setUploadType(email);
//    }

    public static boolean checkPermission(Context context, String permission) {
        boolean result = false;
        if (Build.VERSION.SDK_INT >= 23) {
            try {
                Class<?> clazz = Class.forName("android.content.Context");
                Method method = clazz.getMethod("checkSelfPermission", String.class);
                int rest = (Integer) method.invoke(context, permission);
                if (rest == PackageManager.PERMISSION_GRANTED) {
                    result = true;
                } else {
                    result = false;
                }
            } catch (Exception e) {
                result = false;
            }
        } else {
            PackageManager pm = context.getPackageManager();
            if (pm.checkPermission(permission, context.getPackageName()) == PackageManager.PERMISSION_GRANTED) {
                result = true;
            }
        }
        return result;
    }
    public static String getDeviceInfo(Context context) {
        try {
            org.json.JSONObject json = new org.json.JSONObject();
            android.telephony.TelephonyManager tm = (android.telephony.TelephonyManager) context
                    .getSystemService(Context.TELEPHONY_SERVICE);
            String device_id = null;
            if (checkPermission(context, Manifest.permission.READ_PHONE_STATE)) {
                device_id = tm.getDeviceId();
            }
            String mac = null;
            FileReader fstream = null;
            try {
                fstream = new FileReader("/sys/class/net/wlan0/address");
            } catch (FileNotFoundException e) {
                fstream = new FileReader("/sys/class/net/eth0/address");
            }
            BufferedReader in = null;
            if (fstream != null) {
                try {
                    in = new BufferedReader(fstream, 1024);
                    mac = in.readLine();
                } catch (IOException e) {
                } finally {
                    if (fstream != null) {
                        try {
                            fstream.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                    if (in != null) {
                        try {
                            in.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
            json.put("mac", mac);
            if (TextUtils.isEmpty(device_id)) {
                device_id = mac;
            }
            if (TextUtils.isEmpty(device_id)) {
                device_id = android.provider.Settings.Secure.getString(context.getContentResolver(),
                        android.provider.Settings.Secure.ANDROID_ID);
            }
            json.put("device_id", device_id);
            return json.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void registerActivityCallback() {
        registerActivityLifecycleCallbacks(new ActivityLifecycleCallbacks() {
            @Override
            public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
                ActivityManager.getInstance().pushActivity(activity);
            }

            @Override
            public void onActivityStarted(Activity activity) {

            }

            @Override
            public void onActivityResumed(Activity activity) {

            }

            @Override
            public void onActivityPaused(Activity activity) {

            }

            @Override
            public void onActivityStopped(Activity activity) {

            }

            @Override
            public void onActivitySaveInstanceState(Activity activity, Bundle outState) {

            }

            @Override
            public void onActivityDestroyed(Activity activity) {
                ActivityManager.getInstance().popActivity(activity);
            }
        });
    }


}
