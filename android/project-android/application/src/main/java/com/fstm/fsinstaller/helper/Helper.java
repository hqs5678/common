package com.fstm.fsinstaller.helper;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.Toast;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.app.ActivityManager;
import com.github.lzyzsd.circleprogress.CircleProgress;
import com.hqs.utils.Log;
import com.hqs.utils.MD5Util;
import com.hqs.utils.SharedPreferenceUtil;
import com.hqs.utils.ValidateUtil;
import com.hqs.utils.ViewUtil;
import com.hqs.view.DialogView;
import com.pnikosis.materialishprogress.ProgressWheel;

/**
 * Created by apple on 16/9/27.
 */

public class Helper {

    private static Handler handler;
    private static Dialog dialog;
    private static ProgressWheel wheel;
    private static CircleProgress circleProgress;


    public static void showProgress() {
        Context context = ActivityManager.getInstance().getCurrentActivity();
        dialog = new AlertDialog.Builder(context, R.style.ProgressDialogTheme).create();
        // 设置背景透明  延时灰色显示时间
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            dialog.getWindow().setTransitionBackgroundFadeDuration(Long.MAX_VALUE);
        }
        dialog.show();
        dialog.getWindow().setContentView(R.layout.progress_layout);
        dialog.getWindow().setBackgroundDrawableResource(R.mipmap.transparent);
        wheel = (ProgressWheel) dialog.findViewById(R.id.progress_wheel);
        wheel.setBarColor(context.getResources().getColor(R.color.progressColor));

        dialog.show();
        doInMainThreadDelayed(new Runnable() {
            @Override
            public void run() {
                wheel.spin();
            }
        }, 200);
    }

    public static void showProgress(int progress) {

        if (dialog != null && dialog.isShowing() && circleProgress != null) {
            circleProgress.setProgress(progress);
        } else {
            Context context = ActivityManager.getInstance().getCurrentActivity();
            dialog = new AlertDialog.Builder(context, R.style.ProgressDialogTheme).create();
            // 设置背景透明  延时灰色显示时间
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                dialog.getWindow().setTransitionBackgroundFadeDuration(Long.MAX_VALUE);
            }
            dialog.show();
            dialog.getWindow().setContentView(R.layout.progress_circle_layout);
            dialog.getWindow().setBackgroundDrawableResource(R.mipmap.transparent);
            circleProgress = (CircleProgress) dialog.findViewById(R.id.circle_progress);
            circleProgress.setProgress(progress);
            dialog.show();
        }
    }

    public static void showProgress(int progress, String preText) {
        showProgress(progress);
        circleProgress.setPrefixText(preText);
    }


    public static void dismissProgress() {
        if (dialog != null && dialog.isShowing()) {
            doInMainThreadDelayed(new Runnable() {
                @Override
                public void run() {
                    if (wheel != null) {
                        wheel.stopSpinning();
                    }
                    if (dialog != null){
                        dialog.dismiss();
                        dialog = null;
                    }

                }
            }, 200);
        }

    }

    public static void showDialog(String message, final DialogView.OnDialogClickListener dialogClickListener) {
        Context context = ActivityManager.getInstance().getCurrentActivity();
        DialogView dialogView = new DialogView(context);

        ViewUtil.setRoundCornerToView(dialogView.leftButton, 0, context.getResources().getColor(R.color.colorControlHighlight), Color.WHITE);
        ViewUtil.setRoundCornerToView(dialogView.rightButton, 0, context.getResources().getColor(R.color.colorControlHighlight), Color.WHITE);

        dialogView.show(message, dialogClickListener);
    }

    public static void showDialog(String message) {
        Context context = ActivityManager.getInstance().getCurrentActivity();
        DialogView dialogView = new DialogView(context);

        ViewUtil.setRoundCornerToView(dialogView.rightButton, 0, context.getResources().getColor(R.color.colorControlHighlight), Color.WHITE);
        dialogView.setSingleButtonMode();

        dialogView.show(message, null);
    }


    public static void doInBackground(Runnable r) {
        new Thread(r).start();
    }

    public static void doInMainThread(Runnable r) {
        doInMainThreadDelayed(r, 0);
    }

    public static void doInMainThreadDelayed(Runnable r, long timeInterval) {
        if (handler == null) {
            Log.print("请先初始化 handler !!!");
        } else {
            handler.postDelayed(r, timeInterval);
        }
    }

    public static void setHandler(Handler handler) {
        Helper.handler = handler;
    }

    public static void hideSoftInputFromWindow(Context context, ViewGroup view) {

        InputMethodManager imm = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
        if (view != null) {
            int count = view.getChildCount();
            for (int i = 0; i < count; i++) {
                View child = view.getChildAt(i);
                if (child instanceof EditText) {
                    imm.hideSoftInputFromWindow(child.getWindowToken(), 0);
                } else {
                    if (child instanceof ViewGroup) {
                        hideSoftInputFromWindow(context, (ViewGroup) child);
                    }
                }
            }
        }
    }

    public static String encryptPassword(String pwd) {
        return MD5Util.MD5(MD5Util.MD5(pwd));
    }

    // 是否用户第一次使用
    public static boolean isFirstLaunch() {
        boolean isFirst = SharedPreferenceUtil.get("isFirstLaunch", true);
        if (isFirst) {
            SharedPreferenceUtil.set("isFirstLaunch", false);
        }
        return isFirst;
    }

    public static boolean isLoginOk() {
        return SharedPreferenceUtil.get("token", null) != null;
    }

    // 发起打电话
    public static void call(String phone){
        if (ValidateUtil.isPhoneNumber(phone)){
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phone));
            ActivityManager.getInstance().getCurrentActivity().startActivity(intent);
        }
        else{
            Toast.makeText(ActivityManager.getInstance().getCurrentActivity(), "手机号格式错误", Toast.LENGTH_SHORT).show();
        }
    }

    public static ColorStateList createColorList(int normal) {
        return createColorList(normal, normal);
    }

    public static ColorStateList createColorList(int normal, int pressed) {
        return createColorList(normal, pressed, pressed, pressed);
    }

    public static ColorStateList createColorList(int normal, int pressed, int focused, int unable) {
        int[] colors = new int[]{pressed, focused, normal, focused, unable, focused};
        int[][] states = new int[6][];
        states[0] = new int[]{android.R.attr.state_pressed, android.R.attr.state_enabled};
        states[1] = new int[]{android.R.attr.state_enabled, android.R.attr.state_focused};
        states[2] = new int[]{android.R.attr.state_enabled};
        states[3] = new int[]{android.R.attr.state_focused};
        states[4] = new int[]{android.R.attr.state_window_focused};
        states[5] = new int[]{android.R.attr.state_selected};
        ColorStateList colorList = new ColorStateList(states, colors);
        return colorList;
    }

}
