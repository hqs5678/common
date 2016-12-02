package com.fstm.fsinstaller.receiver;

import com.hqs.utils.Log;

import java.util.Map;

/**
 * Created by apple on 2016/11/17.
 */

public class AppCallBackHandler {

    private static CallBack callBack = null;

    public static void call(Map<String, Object> params) {
        if (callBack != null){
            callBack.callBack(params);
            callBack = null;
            Log.print(params);
        }
    }

    public static void setCallBack(CallBack callBack) {
        AppCallBackHandler.callBack = callBack;
    }

    public interface CallBack {
        void callBack(Map<String, Object> params);
    }
}

