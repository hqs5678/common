package com.fstm.fsinstaller.activity;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.adapter.MenuListViewAdapter;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.helper.Helper;
import com.fstm.fsinstaller.model.MenuListItemModel;
import com.fstm.fsinstaller.model.User;

import java.util.ArrayList;

public class SettingActivity extends BaseActivity {

    private ListView lvMenu;
    private ArrayList<MenuListItemModel> models;
    private MenuListViewAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_setting);

        initView(findViewById(R.id.activity_setting));
    }

    @Override
    public void initView(View rootView) {
        super.initView(rootView);

        lvMenu = (ListView) findViewById(R.id.lv_menu);
        setupModels();

        adapter = new MenuListViewAdapter(this, models, lvMenu);
        lvMenu.setAdapter(adapter);

        lvMenu.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                MenuListItemModel model = models.get(position);

                if (model.activityClass != null){
                    ActivityHelper.startActivity(model.activityClass, model.extraBundle);
                }

                if ("退出登录".equals(model.title)){
                    User.getInstance().reset();
                    finish();
                    Helper.doInMainThreadDelayed(new Runnable() {
                        @Override
                        public void run() {
                            ActivityHelper.gotoLoginActivity();
                        }
                    }, 200);
                }
            }
        });

    }

    private void setupModels(){
        models = new ArrayList<>();

        MenuListItemModel model = new MenuListItemModel();
        model.isSection = true;
        model.clickable = false;
        model.rowHeight = (int) getResources().getDimension(R.dimen.dividerHeightSection);
        model.bgColorRes = R.color.appBackgroundColor;
        models.add(model);

        model = new MenuListItemModel();
        model.title = "消息提醒";
        model.showIndicator = true;
        model.activityClass = MessageSettingActivity.class;
        models.add(model);

        model = new MenuListItemModel();
        model.title = "修改密码";
        model.activityClass = ModifyPasswordActivity.class;
        model.showIndicator = true;
        models.add(model);

        model = new MenuListItemModel();
        model.isSection = true;
        model.bgColorRes = R.color.appBackgroundColor;
        model.clickable = false;
        model.rowHeight = (int) getResources().getDimension(R.dimen.dividerHeightSection);
        models.add(model);

        model = new MenuListItemModel();
        model.title = "退出登录";
        model.centerTitle = true;
        model.showIndicator = false;
        model.titleColorRes = R.color.lightRed;
        models.add(model);

    }
}
