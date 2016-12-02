package com.fstm.fsinstaller.activity;

import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.adapter.MenuListViewAdapter;
import com.fstm.fsinstaller.model.MenuListItemModel;
import com.fstm.fsinstaller.receiver.AppCallBackHandler;
import com.hqs.utils.Log;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class SingleSelectActivity extends BaseActivity {

    private MenuListViewAdapter adapter;
    private ArrayList<MenuListItemModel> models;
    private ListView listView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_single_select);

        initView(R.id.activity_single_select);
    }

    @Override
    public void initView(int res) {
        super.initView(res);

        models = new ArrayList<>();
        Bundle bundle = getIntent().getExtras();
        if (bundle != null){
            String modelsString = bundle.getString("models");
            String name = bundle.getString("name");
            Log.print(modelsString);
            Log.print(name);

            try {
                JSONArray jsonArray = JSONArray.parseArray(modelsString);
                if (jsonArray != null && jsonArray.size() > 0){
                    JSONObject json;
                    MenuListItemModel model;
                    for (int i = 0; i < jsonArray.size(); i++) {
                        model = new MenuListItemModel();

                        json = jsonArray.getJSONObject(i);
                        model.id = json.getString("id");
                        model.title = json.getString(name);

                        models.add(model);
                    }
                }



            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        this.navigationBar.backImageView.setVisibility(View.GONE);
        this.setRightItem("关闭");

        listView = (ListView) findViewById(R.id.lv_select);
        adapter = new MenuListViewAdapter(this, models, listView);
        listView.setAdapter(adapter);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                String name = models.get(position).title;
                String sId = models.get(position).id;
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("selectTitle", name);
                map.put("selectId", sId);

                AppCallBackHandler.call(map);
                finish();
            }
        });
    }

    @Override
    public void clickRightItemView() {
        AppCallBackHandler.setCallBack(null);
        this.finish();
    }

}
