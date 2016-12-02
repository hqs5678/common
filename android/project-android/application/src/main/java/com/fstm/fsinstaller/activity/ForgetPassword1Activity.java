package com.fstm.fsinstaller.activity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.app.Constant;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.helper.HttpHelper;
import com.hqs.utils.SharedPreferenceUtil;
import com.hqs.utils.ValidateUtil;
import com.hqs.view.TimerButton;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ForgetPassword1Activity extends BaseActivity {

    private Button btnNext;
    private TimerButton btnCapcha;
    private EditText etPhone;
    private EditText etCaptcha;

    private ArrayList<String> codes = new ArrayList<>();
    private long invalidTime = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_forget_password1);

        initView(findViewById(R.id.activity_forget_password1));
    }

    @Override
    public void initView(View rootView) {
        super.initView(rootView);
        setHideKeyboardWhenClickBlankSpace();

        btnNext = (Button) findViewById(R.id.btn_next);
        btnCapcha = (TimerButton) findViewById(R.id.btn_captcha);
        etPhone = (EditText) findViewById(R.id.et_phone);
        etCaptcha = (EditText) findViewById(R.id.et_captcha);

        btnCapcha.setBackgroundColorNormalRes(R.color.colorPrimary);
        btnCapcha.setBackgroundColorDisableRes(R.color.colorPrimaryDark);
        btnCapcha.totalTime = 120;
        btnCapcha.handler = handler;
        btnCapcha.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (ForgetPassword1Activity.this.getCaptcha()){
                    btnCapcha.startTimer();
                }
            }
        });
        etPhone.setText(SharedPreferenceUtil.get("phone",""));

        ActivityHelper.setViewBackgroundColorWithRoundCorner(btnNext, R.color.lightGreenColor);
        ActivityHelper.setViewBackgroundColorWithRoundCorner(btnCapcha, R.color.yellowColor, R.color.appBackgroundColor);

        btnNext.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                hideKeyboard();

                String captcha = etCaptcha.getText().toString();
                if (captcha == null || captcha.length() == 0 || codes.contains(captcha) == false){
                    makeToast("验证码错误");
                }
                else{
                    if (System.currentTimeMillis() > invalidTime){
                        makeToast("验证码失效");
                        return;
                    }

                    String phone = etPhone.getText().toString();
                    SharedPreferenceUtil.set("phone", phone);
                    Bundle bundle = new Bundle();
                    bundle.putString("phone", phone);
                    ActivityHelper.startActivity(ForgetPassword2Activity.class, bundle);
                    ForgetPassword1Activity.this.finish();
                }

            }
        });
    }

    private boolean getCaptcha(){
        String phone = etPhone.getText().toString();
        if (ValidateUtil.isPhoneNumber(phone)){

//            Map<String, Object> params = new HashMap<>();
//            params.put("phone", phone);
//            HttpHelper.doPost(Constant.uGetCaptcha, params, new HttpHelper.HttpCallBack() {
//                @Override
//                public void onHttpResult(boolean success, String message, JSON data) {
////                    {"msg":"请求验证码成功！","data":{"timestamp":1477992885376,"code":"417511"},"state":true}
//                    if (success){
//                        if (data != null){
//                            JSONObject jsonObject = (JSONObject) data;
//                            if (jsonObject != null){
//                                String code = jsonObject.getString("code");
//                                invalidTime = jsonObject.getLong("timestamp");
//                                codes.add(code);
//                            }
//                        }
//                    }
//                }
//            });

            return true;
        }
        else{
            makeToast("请输入正确的手机号");
        }
        return false;
    }
}
