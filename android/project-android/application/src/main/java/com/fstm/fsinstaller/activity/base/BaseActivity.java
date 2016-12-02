package com.fstm.fsinstaller.activity.base;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.MainActivity;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.helper.Helper;
import com.hqs.utils.ScreenUtils;
import com.hqs.view.NavigationBar;
import com.hqs.view.NavigationBarLinearLayout;

/**
 * Created by apple on 16/9/29.
 */

public class BaseActivity extends Activity {

    public boolean isStartFromBottom = false;
    protected NavigationBar navigationBar;
    protected NavigationBarLinearLayout rootView;
    protected Handler handler = new Handler();
    protected String title;

    // 返回时直接跳转到主页
    protected boolean onFinishedToMainActivity = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // 设置竖屏
        ScreenUtils.setScreenOrientationPortrait(this);
        super.onCreate(savedInstanceState);
    }

    public void initView(int res){
        initView(findViewById(res));
    }

    public void initView(final View rootView){
        this.rootView  = (NavigationBarLinearLayout) rootView;

        Bundle bundle = getIntent().getExtras();
        if (bundle != null){
            isStartFromBottom = bundle.getBoolean("isStartFromBottom");
            title = bundle.getString("title");
            onFinishedToMainActivity = bundle.getBoolean("onFinishedToMainActivity");
        }

        View bgView = findViewById(R.id.v_background);
        if (bgView != null){
            bgView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    onClickBackgroundView();
                }
            });
        }

        navigationBar = this.rootView.navigationBar; //(NavigationBar) findViewById(R.id.title_view);
        navigationBar.setOnLeftItemClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(navigationBar.backImageView.getVisibility() == View.VISIBLE){
                    clickBackButton();
                }
                else{
                    clickLeftItemView();
                }
            }
        });

        navigationBar.setOnRightItemClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                clickRightItemView();
            }
        });

        navigationBar.showBackButton();
        if (title != null){
            setTitle(title);
        }
    }



    public void clickBackButton(){
        onFinish();
    }

    private void onFinish(){
        if (onFinishedToMainActivity) {
            ActivityHelper.startActivity(MainActivity.class);
        }
        finish();
    }

    @Override
    public void finish() {
        super.finish();

        if (isStartFromBottom){
            this.overridePendingTransition(0, R.anim.slide_out_top);
        }
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK){

            onFinish();
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    public Bundle getBundle(){
        Bundle bundle = getIntent().getExtras();
        return bundle;
    }

    public void clickLeftItemView(){

    }

    public void clickRightItemView(){

    }

    public void setTitle(String title){
        if(navigationBar != null){
            navigationBar.setTitle(title);
        }
    }

    public void setLeftItem(String item){
        if(navigationBar != null){
            navigationBar.setLeftItem(item);
        }
    }

    public void setRightItem(String item){
        if(navigationBar != null){
            navigationBar.setRightItem(item);
        }
    }

    public void makeToast(String msg){
        Toast.makeText(this, msg, Toast.LENGTH_SHORT).show();
    }

    public void makeErrorToast(){
        makeToast("操作失败,请重试!");
    }

    public void makeSuccessToast(){
        makeToast("操作成功!");
    }

    public void makeDataErrorToast(){
        makeToast("数据格式错误");
    }

    protected void onClickBackgroundView(){
        ViewGroup viewGroup = (ViewGroup) rootView;
        Helper.hideSoftInputFromWindow(this, viewGroup);
    }

    public void hideKeyboard(){
        onClickBackgroundView();
    }

    public void setHideKeyboardWhenClickBlankSpace() {
        rootView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onClickBackgroundView();
            }
        });
    }
}
