package com.fushuntiamu.web.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

public class HttpUtil {

	
	public static void doGet(String url, HttpResultCallback callback){
		
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				// TODO Auto-generated method stub
				try {
					HttpGet get = new HttpGet(url);
					HttpClient client = new DefaultHttpClient();
					HttpResponse response = client.execute(get);
					
					String content = null;
					
					if(callback != null){
						BufferedReader in = new BufferedReader(new InputStreamReader(response.getEntity()  
			                    .getContent()));  
			            StringBuffer sb = new StringBuffer("");  
			            String line = "";  
			            String NL = System.getProperty("line.separator");  
			            while ((line = in.readLine()) != null) {  
			                sb.append(line + NL);  
			            }  
			            in.close();  
			            content = sb.toString();  
			            if(response.getStatusLine().getStatusCode() == 200){
			            	callback.onHttpResult(HttpResultCode.Success, content);
						}
						else {
							callback.onHttpResult(HttpResultCode.Fail, content);
						} 
					}
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					
					if(callback != null){
						callback.onHttpResult(HttpResultCode.Fail, e.getMessage());
					}
				}
			}
		}).start(); 
	}
	
	
	public static void doPost(String url, HashMap<String, String> params, HttpResultCallback callback){
new Thread(new Runnable() {
			
			@Override
			public void run() {
				// TODO Auto-generated method stub
				try {
					HttpPost post = new HttpPost(url);
					ArrayList<NameValuePair> ps = new ArrayList<>();
					Set<String> keys = params.keySet();
					for(String k : keys){
						ps.add(new BasicNameValuePair(k, params.get(k)));
					}
					post.setEntity(new UrlEncodedFormEntity(ps));
					
					HttpClient client = new DefaultHttpClient();
					HttpResponse response = client.execute(post);
					
					String content = null;
					
					if(callback != null){
						BufferedReader in = new BufferedReader(new InputStreamReader(response.getEntity()  
			                    .getContent()));  
			            StringBuffer sb = new StringBuffer("");  
			            String line = "";  
			            String NL = System.getProperty("line.separator");  
			            while ((line = in.readLine()) != null) {  
			                sb.append(line + NL);  
			            }  
			            in.close();  
			            content = sb.toString();  
			            if(response.getStatusLine().getStatusCode() == 200){
			            	callback.onHttpResult(HttpResultCode.Success, content);
						}
						else {
							callback.onHttpResult(HttpResultCode.Fail, content);
						} 
					}
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					
					if(callback != null){
						callback.onHttpResult(HttpResultCode.Fail, e.getMessage());
					}
				}
			}
		}).start(); 
	}
	
	public enum HttpResultCode{
		Success, Fail
	}

	public interface HttpResultCallback{
		public void onHttpResult(HttpResultCode code, String result);
	}
}


