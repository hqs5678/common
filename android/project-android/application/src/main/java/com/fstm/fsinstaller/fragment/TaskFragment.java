package com.fstm.fsinstaller.fragment;

import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.SearchTaskActivity;
import com.fstm.fsinstaller.adapter.TaskFragmentListViewAdapter;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.helper.Helper;
import com.fstm.fsinstaller.model.MenuListItemModel;
import com.fstm.fsinstaller.veiw.SearchView;

import java.util.ArrayList;

/**
 * Created by apple on 16/9/26.
 */

public class TaskFragment extends BaseFragment implements SwipeRefreshLayout.OnRefreshListener{

    private ListView lvMenu;
    private TaskFragmentListViewAdapter adapter;
    private ArrayList<MenuListItemModel> menuModels;
    private SearchView searchView;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        rootView = inflater.inflate(R.layout.fragment_task, container, false);
        initView();
        return rootView;
    }


    @Override
    public void initView() {
        super.initView();

        lvContainer.setOnRefreshListener(this);
        lvMenu = (ListView) rootView.findViewById(R.id.lv_menu);
        setupMenu();

        adapter = new TaskFragmentListViewAdapter(context, menuModels, lvMenu);
        lvMenu.setAdapter(adapter);

        lvMenu.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                MenuListItemModel model = menuModels.get(position);

                if (model.activityClass != null){
                    if (model.extraBundle == null){
                        model.extraBundle = new Bundle();
                    }
                    model.extraBundle.putString("title", model.title);
                    ActivityHelper.startActivity(model.activityClass, model.extraBundle);
                }

            }
        });

        Helper.doInMainThreadDelayed(new Runnable() {
            @Override
            public void run() {
                searchView = adapter.searchView;
                searchView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        ActivityHelper.startActivity(SearchTaskActivity.class);
                    }
                });
                searchView.setSearchHintText("搜索任务");
            }
        }, 500);
    }




    private void setupMenu(){
        menuModels = new ArrayList<>();

        // 搜索
        MenuListItemModel model = new MenuListItemModel();
        menuModels.add(model);

        model = new MenuListItemModel();
        model.iconRes = R.mipmap.about;
        model.title = "待上门";
        model.showIndicator = true;
        model.tail = "1";
        menuModels.add(model);

        model = new MenuListItemModel();
        model.iconRes = R.mipmap.about;
        model.title = "进行中";
        model.showIndicator = true;
        model.tail = "11";
        menuModels.add(model);

        model = new MenuListItemModel();
        model.iconRes = R.mipmap.about;
        model.title = "审核中";
        model.showIndicator = true;
        model.tail = "22";
        menuModels.add(model);

        model = new MenuListItemModel();
        model.iconRes = R.mipmap.about;
        model.title = "审核失败";
        model.tail = "22";
        model.showIndicator = true;
        menuModels.add(model);

        model = new MenuListItemModel();
        model.iconRes = R.mipmap.about;
        model.title = "已完成";
        model.tail = "new";
        model.showIndicator = true;
        menuModels.add(model);

        model = new MenuListItemModel();
        model.iconRes = R.mipmap.about;
        model.title = "超时";
        model.showIndicator = true;
        menuModels.add(model);

    }

    @Override
    public void onRefresh() {
        loadState();
    }

    @Override
    public void updateStat() {


    }
}
