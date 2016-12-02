package com.fstm.fsinstaller.activity;

import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.adapter.ToggleListViewAdapter;
import com.fstm.fsinstaller.model.ToggleListItemModel;
import com.fstm.fsinstaller.veiw.ToggleListItemView;
import com.hqs.utils.SharedPreferenceUtil;
import com.zcw.togglebutton.ToggleButton;

import java.util.ArrayList;

public class MessageSettingActivity extends BaseActivity {

    private ListView listView;
    private ToggleListViewAdapter adapter;
    private ArrayList<ToggleListItemModel> models;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_message_setting);

        initView(findViewById(R.id.activity_message_setting));
    }

    @Override
    public void initView(View rootView) {
        super.initView(rootView);

        listView = (ListView) findViewById(R.id.lv_menu);
        setupMenu();
        adapter = new ToggleListViewAdapter(this, models, listView);
        listView.setAdapter(adapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                if (view instanceof ToggleListItemView){
                    ViewGroup viewGroup =  (ViewGroup)view;
                    ToggleButton button = (ToggleButton) viewGroup.findViewById(R.id.btn_toggle);
                    button.setAnimate(true);
                    button.toggle();

                }
            }
        });
    }

    private void setupMenu(){
        models = new ArrayList<>();

        ToggleListItemModel model = new ToggleListItemModel();
        model.isSection = true;
        models.add(model);

        model = new ToggleListItemModel();
        model.title = "消息提醒";
        model.clickable = true;
        model.isOn = SharedPreferenceUtil.get("isOn1", false);
        models.add(model);

        model = new ToggleListItemModel();
        model.isSection = true;
        models.add(model);

        model = new ToggleListItemModel();
        model.title = "声音";
        model.isOn = SharedPreferenceUtil.get("isOn3", false);
        models.add(model);

        model = new ToggleListItemModel();
        model.isOn = SharedPreferenceUtil.get("isOn4", false);
        model.title = "震动";
        models.add(model);
    }

    @Override
    protected void onStop() {
        super.onStop();

        // 保存数据
        SharedPreferenceUtil.set("isOn1", models.get(1).isOn);
        SharedPreferenceUtil.set("isOn3", models.get(3).isOn);
        SharedPreferenceUtil.set("isOn4", models.get(4).isOn);
    }
}
