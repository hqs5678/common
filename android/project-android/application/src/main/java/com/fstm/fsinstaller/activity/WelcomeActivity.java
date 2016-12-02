package com.fstm.fsinstaller.activity;

import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.hqs.utils.StatusBarUtil;
import com.hqs.view.WelcomeView;

import java.util.ArrayList;

public class WelcomeActivity extends BaseActivity {

    private WelcomeView welcomeView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome);

        initView(R.id.activity_welcome);
    }

    @Override
    public void initView(View rootView) {
        super.initView(rootView);

        welcomeView = (WelcomeView) findViewById(R.id.welcome_view);
        ArrayList<Integer> imagesRes = new ArrayList<>();
        imagesRes.add(R.mipmap.guide1);
        imagesRes.add(R.mipmap.guide2);
        imagesRes.add(R.mipmap.guide3);
        welcomeView.setImagesRes(imagesRes);
        welcomeView.setSelectTintColor(getResources().getColor(R.color.colorAccent));
        navigationBar.setVisibility(View.GONE);

        WelcomeView.RoundButton bottomButton = welcomeView.getButton();
        bottomButton.setNormalColor(getResources().getColor(R.color.titleColor));
        bottomButton.setHighlightColor(getResources().getColor(R.color.titleColorLight));
        welcomeView.setButtonClickHandle(new WelcomeView.ButtonClickHandle() {
            @Override
            public void onClickButton(WelcomeView.RoundButton button) {
                WelcomeActivity.this.finish();
            }
        });

        ActivityHelper.setViewBackgroundColorWithRoundCorner(bottomButton, R.color.yellowColor, R.color.whiteColor);
        StatusBarUtil.setWindowStatusBarColor(this, R.color.loginBackgroundColor);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        // 返回按钮无效
        if (keyCode == KeyEvent.KEYCODE_BACK){
            return true;
        }
        else{
            return super.onKeyDown(keyCode, event);
        }
    }
}
