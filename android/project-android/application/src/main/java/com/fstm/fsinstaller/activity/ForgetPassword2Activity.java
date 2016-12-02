package com.fstm.fsinstaller.activity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.alibaba.fastjson.JSON;
import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.app.Constant;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.helper.Helper;
import com.fstm.fsinstaller.helper.HttpHelper;

import java.util.HashMap;
import java.util.Map;

public class ForgetPassword2Activity extends BaseActivity {

    private Button btnSubmit;
    private String phone;
    private EditText etPwd;
    private EditText etRepwd;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_forget_password2);

        initView(findViewById(R.id.activity_forget_password2));
    }

    @Override
    public void initView(View rootView) {
        super.initView(rootView);
        setHideKeyboardWhenClickBlankSpace();

        btnSubmit = (Button) findViewById(R.id.btn_submit);
        etPwd = (EditText) findViewById(R.id.et_pwd);
        etRepwd = (EditText) findViewById(R.id.et_repwd);

        btnSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String pwd = etPwd.getText().toString();
                String repwd = etRepwd.getText().toString();

                if (pwd != null && pwd.equals(repwd)){


                    makeToast("密码修改成功");
                    ForgetPassword2Activity.this.finish();
                }
                else{
                    makeToast("两次输入的密码不一致");
                }
            }
        });

        Bundle bundle = getBundle();
        if (bundle != null){
            phone = getBundle().getString("phone");
        }

        ActivityHelper.setViewBackgroundColorWithRoundCorner(btnSubmit, R.color.lightGreenColor);
    }
}
