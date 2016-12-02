package com.fstm.fsinstaller.activity;

import android.content.res.ColorStateList;
import android.os.Build;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.app.Constant;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.helper.Helper;
import com.fstm.fsinstaller.helper.HttpHelper;
import com.fstm.fsinstaller.model.User;
import com.hqs.utils.Log;
import com.hqs.utils.SharedPreferenceUtil;
import com.hqs.utils.StatusBarUtil;
import com.hqs.utils.ValidateUtil;
import com.umeng.analytics.MobclickAgent;

import java.util.HashMap;
import java.util.Map;

/**
 * 登录界面
 */
public class LoginActivity extends BaseActivity {

    private Button btnLogin;
    private Button btnForgetPwd;
    private EditText etPhone;
    private EditText etPassword;
    private CheckBox cbRememberPwd;
    private boolean pwdTextChanged = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        initView(findViewById(R.id.activity_login));
        StatusBarUtil.setWindowStatusBarColor(this, R.color.loginBackgroundColor);
    }

    @Override
    public void initView(View rootView) {
        super.initView(rootView);
        setHideKeyboardWhenClickBlankSpace();
        navigationBar.setVisibility(View.GONE);

        etPhone = (EditText) findViewById(R.id.et_name);
        etPassword = (EditText) findViewById(R.id.et_password);

        cbRememberPwd = (CheckBox) findViewById(R.id.cb_remember_pwd);
        btnLogin = (Button) findViewById(R.id.btn_login);

        cbRememberPwd.setChecked(SharedPreferenceUtil.get("rememberPwd", true));

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            int color = getResources().getColor(R.color.colorPrimary);
            ColorStateList colorStateList = Helper.createColorList(color);
            cbRememberPwd.setButtonTintList(colorStateList);
        }
        else{
            cbRememberPwd.setButtonDrawable(R.drawable.selector_check_box);
        }

        etPhone.setText(SharedPreferenceUtil.get("phone",""));
        if (cbRememberPwd.isChecked()){
            etPassword.setText(SharedPreferenceUtil.get("pwd",""));
        }
        cbRememberPwd.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                SharedPreferenceUtil.set("rememberPwd", isChecked);
            }
        });


        btnForgetPwd = (Button) findViewById(R.id.btn_forget_pwd);
        btnForgetPwd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ActivityHelper.startActivity(ForgetPassword1Activity.class);
            }
        });

        etPassword.addTextChangedListener(new TextWatcher() {
            private String oldText = "";
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                pwdTextChanged = true;
            }

            @Override
            public void afterTextChanged(Editable s) {
                if (etPassword.getText().toString().length() < oldText.length()){
                    oldText = "";
                    etPassword.setText("");
                }
                else{
                    oldText = etPassword.getText().toString();
                }
            }
        });

        ActivityHelper.setViewBackgroundColorWithRoundCorner(btnLogin, R.color.yellowColor, R.color.appBackgroundColor);
    }

    public void loginAction(View view){
        hideKeyboard();

        if (ValidateUtil.isEmpty(etPhone.getText().toString())){
            makeToast("请输入手机号");
            return;
        }

        if (ValidateUtil.isEmpty(etPassword.getText().toString())){
            makeToast("请输入密码");
            return;
        }

        Helper.showProgress();

        String pwd = pwdTextChanged ? Helper.encryptPassword(etPassword.getText().toString()) : etPassword.getText().toString();
        SharedPreferenceUtil.set("phone", etPhone.getText().toString());
        SharedPreferenceUtil.set("pwd", pwd);

        Map<String, Object> params = new HashMap<>();
        params.put("phone", etPhone.getText().toString());
        params.put("pwd", pwd);
//        HttpHelper.doPost(Constant.uLogin, params, new HttpHelper.HttpCallBack() {
//            @Override
//            public void onHttpResult(boolean success, String message, JSON data) {
//                Helper.dismissProgress();
//                if (success){
//                    //{"jobNature":"全职","token":"S0hn3d","remark"
//                    // :"测试","realName":"陆星","dailyCapacity":0,"phone":"18730609386",
//                    // "locaDesc":"","gender":"男","groupRelations":[],
//                    // "roleRelations":[],"status":"在职","birthDate":"1992-06-06","userName":"
//                    // lusir","jobCity":"001","address":"经海二路","longitude":0.0,"email":"lusir@126.com",
//                    // "pwd":"6A739D16295F86A8080269D45F42CB8D","hireDate":"2016-10-12","teamId":0,"jobStatus":1,"
//                    // empno":"00102040079","active":1,"depart":"04","latitude":0.0,"uid":"7O","openIdWx":
//                    // "ogRLkvjvk2olBDbLGhk9mTTsVjUE","idNumber":"135223199206063366"}
//                    makeToast("登录成功");
//                    if (data != null){
//                        JSONObject jsonObject = (JSONObject) data;
//                        SharedPreferenceUtil.set("userId", jsonObject.getString("uid"));
//                        SharedPreferenceUtil.set("uid", jsonObject.getString("uid"));
//                        SharedPreferenceUtil.set("phone", jsonObject.getString("phone"));
//                        SharedPreferenceUtil.set("empno", jsonObject.getString("empno"));
//                        SharedPreferenceUtil.set("realName", jsonObject.getString("realName"));
//                        SharedPreferenceUtil.set("userName", jsonObject.getString("userName"));
//                        SharedPreferenceUtil.set("token", jsonObject.getString("token"));
//                        User.getInstance().update();
//                    }
//                    MobclickAgent.onProfileSignIn(User.getInstance().uid);
//                    LoginActivity.this.finish();
//                }
//                else{
//                    makeToast(message);
//                }
//            }
//        });
    }

    @Override
    protected void onStop() {
        super.onStop();

        Log.print("login on stop");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();

        Log.print("login destroy  ....");
    }
}
