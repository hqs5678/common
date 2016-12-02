package com.fstm.fsinstaller.activity;

import android.os.Bundle;
import android.widget.EditText;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.receiver.AppCallBackHandler;

import java.util.HashMap;
import java.util.Map;

public class GetUserInputActivity extends BaseActivity {

    private EditText etInput;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_get_user_input);

        initView(R.id.activity_get_user_input);
    }

    @Override
    public void initView(int res) {
        super.initView(res);

        etInput = (EditText) findViewById(R.id.et_input);

        Bundle bundle = getIntent().getExtras();
        if (bundle != null){
            String hint = bundle.getString("hint");
            etInput.setHint(hint);
        }

        setRightItem("提交");
    }

    @Override
    public void clickRightItemView() {
        Map<String, Object> params = new HashMap<>();
        params.put("title", etInput.getText());
        AppCallBackHandler.call(params);

        finish();
    }
}
