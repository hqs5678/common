package com.fstm.fsinstaller.activity;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.adapter.MenuListViewAdapter;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.model.MenuListItemModel;
import com.fstm.fsinstaller.receiver.AppCallBackHandler;

import java.util.ArrayList;
import java.util.Map;

public class AboutActivity extends BaseActivity {

    private ListView lvMenu;
    private MenuListViewAdapter adapter;
    private ArrayList<MenuListItemModel> menuModels;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about);

        initView(findViewById(R.id.activity_about));
    }

    @Override
    public void initView(View rootView) {
        super.initView(rootView);

        lvMenu = (ListView) rootView.findViewById(R.id.lv_menu);
        setupMenu();

        adapter = new MenuListViewAdapter(this, menuModels, lvMenu);
        lvMenu.setAdapter(adapter);


        lvMenu.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                MenuListItemModel model = menuModels.get(position);

                if (position == 4){
                    AppCallBackHandler.setCallBack(new AppCallBackHandler.CallBack() {
                        @Override
                        public void callBack(Map<String, Object> params) {
                            makeToast("提交成功");
                        }
                    });
                }

                if (model.activityClass != null){
                    if (model.extraBundle == null){
                        model.extraBundle = new Bundle();
                    }
                    model.extraBundle.putString("title", model.title);
                    ActivityHelper.startActivity(model.activityClass, model.extraBundle);
                }
                else{
                    if (position == 1){
                        makeToast("已是最新版本");
                    }
                }

            }
        });
    }

    private void setupMenu(){
        menuModels = new ArrayList<>();
        MenuListItemModel model = new MenuListItemModel();
        model.isSection = true;
        model.rowHeight = (int) getResources().getDimension(R.dimen.dividerHeightSection);
        model.bgColorRes = R.color.appBackgroundColor;
        menuModels.add(model);

        model = new MenuListItemModel();
        model.title = "版本更新";
        model.tail = "已是最新版";
        model.showIndicator = false;
        menuModels.add(model);

        model = new MenuListItemModel();
        model.title = "功能介绍";
        model.showIndicator = true;
        model.activityClass = WebViewActivity.class;
        menuModels.add(model);

        model = new MenuListItemModel();
        model.title = "帮助";
        model.showIndicator = true;
        model.activityClass = WebViewActivity.class;
        menuModels.add(model);

        model = new MenuListItemModel();
        model.title = "反馈";
        model.activityClass = GetUserInputActivity.class;
        model.showIndicator = true;
        Bundle bundle = new Bundle();
        bundle.putString("hint", "请输入对本app的意见及建议");
        model.extraBundle = bundle;

        menuModels.add(model);
    }
}
