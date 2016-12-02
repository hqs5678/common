package com.fstm.fsinstaller.activity;

import android.os.Bundle;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;

import com.alibaba.fastjson.JSON;
import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.app.Constant;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.helper.Helper;
import com.fstm.fsinstaller.helper.HttpHelper;
import com.hqs.utils.SharedPreferenceUtil;
import com.hqs.utils.ValidateUtil;

import java.util.HashMap;
import java.util.Map;

public class ModifyPasswordActivity extends BaseActivity {

    private Button btnSubmit;
    private EditText etOldPwd;
    private EditText etPwd;
    private EditText etRePwd;
    private CheckBox cbOldPwd;
    private CheckBox cbPwd;
    private CheckBox cbRePwd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_modify_password);

        initView(findViewById(R.id.activity_modify_password));
    }

    @Override
    public void initView(View rootView) {
        super.initView(rootView);

        setHideKeyboardWhenClickBlankSpace();
        btnSubmit = (Button) findViewById(R.id.btn_submit);
        ActivityHelper.setViewBackgroundColorWithRoundCorner(btnSubmit, R.color.lightGreenColor);

        etOldPwd = (EditText) findViewById(R.id.et_old_pwd);
        etPwd = (EditText) findViewById(R.id.et_pwd);
        etRePwd = (EditText) findViewById(R.id.et_repwd);
        cbOldPwd = (CheckBox) findViewById(R.id.cb_old_pwd);
        cbPwd = (CheckBox) findViewById(R.id.cb_new_pwd);
        cbRePwd = (CheckBox) findViewById(R.id.cb_re_pwd);

        setCheckbox(cbOldPwd, etOldPwd);
        setCheckbox(cbPwd, etPwd);
        setCheckbox(cbRePwd, etRePwd);

        setTextWatcher(etOldPwd);
        setTextWatcher(etPwd);
        setTextWatcher(etRePwd);

        btnSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                hideKeyboard();

                String oldPwd =  etOldPwd.getText().toString();
                String pwd = etPwd.getText().toString();
                String rePwd = etRePwd.getText().toString();
                if (pwd != null && pwd.equals(rePwd)){

                    if (ValidateUtil.isEmpty(pwd)){
                        makeToast("请输入新密码");
                        return;
                    }
                    else{
                        if (ValidateUtil.isEmpty(oldPwd)){
                            makeToast("请输入原密码");
                            return;
                        }
                    }

//                    Helper.showProgress();
//                    Map<String, Object> params = new HashMap<String, Object>();
//                    params.put("phone", SharedPreferenceUtil.get("phone", ""));
//                    params.put("pwd", Helper.encryptPassword(oldPwd));
//                    params.put("newPwd", Helper.encryptPassword(pwd));
//                    HttpHelper.doPost(Constant.uModifyPwd, params, new HttpHelper.HttpCallBack() {
//                        @Override
//                        public void onHttpResult(boolean success, String message, JSON data) {
//                            if (success){
//                                makeToast("密码修改成功");
//                                finish();
//                            }
//                            else{
//                                makeToast("密码修改失败");
//                                Helper.dismissProgress();
//                            }
//                        }
//                    });
                }
                else{
                    makeToast("两次输入的新密码不一致");
                }
            }
        });
    }

    private void setCheckbox(CheckBox cb, final EditText et){
        final int passwordType = InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD;
        final int textType = InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_NORMAL;
        cb.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                if (b){
                    setInputType(et, textType);
                }
                else{
                    setInputType(et, passwordType);
                }
            }
        });
    }

    private void setInputType(EditText et, int type){
        et.setInputType(type);
        et.setSelection(et.getText().length());
    }

    private void setTextWatcher(final EditText et){
        et.addTextChangedListener(new TextWatcher() {
            private String oldText = "";
            final int passwordType = InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD;
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                if (et.getText().toString().length() < oldText.length() && et.getInputType() == passwordType){
                    oldText = "";
                    et.setText("");
                }
                else{
                    oldText = et.getText().toString();
                }
            }
        });
    }
}
