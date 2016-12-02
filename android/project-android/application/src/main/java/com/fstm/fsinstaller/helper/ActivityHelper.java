package com.fstm.fsinstaller.helper;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.LoginActivity;
import com.fstm.fsinstaller.activity.MainActivity;
import com.fstm.fsinstaller.app.ActivityManager;
import com.hqs.utils.ViewUtil;

/**
 * Created by apple on 16/9/27.
 */

public class ActivityHelper {

    public static void startActivity(Class klass){
        startActivity(klass, null);
    }
    private static Class curActivityClass;

    public static void startActivity(Class klass, Bundle extras){
        startActivity(klass, extras, false);
    }

    public static void startActivity(Class klass, Bundle extras, boolean isStartFromBottom){

        if (curActivityClass != null && klass.getName().equals(curActivityClass.getName())) {
            return;
        }

        final Activity curActivity = ActivityManager.getInstance().getCurrentActivity();
        Intent intent = new Intent(curActivity, klass);
        if (extras == null){
            extras = new Bundle();
        }
        extras.putBoolean("isStartFromBottom", isStartFromBottom);
        intent.putExtras(extras);
        curActivity.startActivity(intent);
        curActivityClass = klass;

        if(isStartFromBottom){
            curActivity.overridePendingTransition(R.anim.slide_in_bottom, 0);
        }

        // 同一个activity 在一秒内只允许start 一次
        Helper.doInMainThreadDelayed(new Runnable() {
            @Override
            public void run() {
                curActivityClass = null;
            }
        }, 1000);
    }

    public static void setSoftInputHidden(Activity activity){
        activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);
    }

    public static void setViewBackgroundColorWithRoundCorner(View view, int colorRes, int rippleColorRes){
        Context context = ActivityManager.getInstance().getCurrentActivity();

        ViewUtil.setRoundCornerToView(view, context.getResources().getDimension(R.dimen.cornerRadius),
                context.getResources().getColor(rippleColorRes),
                context.getResources().getColor(colorRes));
    }

    public static void setViewBackgroundColorWithRoundCorner(View view, int colorRes){
        setViewBackgroundColorWithRoundCorner(view, colorRes, R.color.colorControlHighlight);
    }


    public static void gotoLoginActivity(){

       // startActivity(LoginActivity.class, null, true);
    }

    public static void popMainActivity(){
        startActivity(MainActivity.class, null);
    }
}
