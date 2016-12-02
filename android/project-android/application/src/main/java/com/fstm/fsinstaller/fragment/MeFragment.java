package com.fstm.fsinstaller.fragment;

import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListView;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.AboutActivity;
import com.fstm.fsinstaller.activity.SettingActivity;
import com.fstm.fsinstaller.activity.takephoto.SimpleTakePhotoActivity;
import com.fstm.fsinstaller.adapter.MeFragmentListViewAdapter;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.helper.Helper;
import com.fstm.fsinstaller.model.MenuListItemModel;
import com.fstm.fsinstaller.model.MyHeadViewModel;
import com.fstm.fsinstaller.model.TaskStat;
import com.fstm.fsinstaller.utils.FileUtil;
import com.fstm.fsinstaller.veiw.MeComponent;
import com.fstm.fsinstaller.veiw.SingleSelectDialog;
import com.hqs.utils.SharedPreferenceUtil;
import com.jph.takephoto.model.TImage;

import java.util.ArrayList;

/**
 * Created by apple on 16/9/26.
 */

public class MeFragment extends BaseFragment implements SwipeRefreshLayout.OnRefreshListener{

    private ListView lvMenu;
    private MeFragmentListViewAdapter adapter;
    private ArrayList<MenuListItemModel> menuModels;
    private MeComponent meComponent;
    private MyHeadViewModel headViewModel;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        rootView = inflater.inflate(R.layout.fragment_me, container, false);
        initView();
        return rootView;
    }

    @Override
    public void onResume() {
        super.onResume();
        headViewModel.setNumber(SharedPreferenceUtil.get("userName", ""));
        if (headViewModel.getNumber().length() == 0){
            headViewModel.setNumber(SharedPreferenceUtil.get("phone", ""));
        }
        adapter.notifyDataSetChanged();

        Helper.doInMainThreadDelayed(new Runnable() {
            @Override
            public void run() {
                meComponent = adapter.getMeComponent();
                meComponent.ivHeader.setCornerRadius(meComponent.ivHeader.getWidth() * 0.5f);
                if (meComponent != null){
                    meComponent.ivHeader.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            selectPhoto(111);
                        }
                    });
                }
            }
        }, 200);

    }

    protected void selectPhoto(final int code){

        ArrayList<String> items = new ArrayList<>();
        items.add("相册");
        items.add("拍照");
        items.add("取消");
        new SingleSelectDialog(items, new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {

                if (position == 0){
                    Bundle bundle = new Bundle();
                    bundle.putString(SimpleTakePhotoActivity.TYPE, SimpleTakePhotoActivity.TYPE_SINGLE);
                    bundle.putBoolean(SimpleTakePhotoActivity.CROP, true);
                    Intent intent = new Intent(getActivity(), SimpleTakePhotoActivity.class);
                    intent.putExtras(bundle);
                    startActivityForResult(intent, code);
                }
                else if (position == 1){
                    // 拍照
                    Bundle bundle = new Bundle();
                    bundle.putString(SimpleTakePhotoActivity.TYPE, SimpleTakePhotoActivity.TYPE_CAMERA);
                    bundle.putBoolean(SimpleTakePhotoActivity.CROP, true);
                    bundle.putString(SimpleTakePhotoActivity.PATH, FileUtil.tmpImgPath());
                    Intent intent = new Intent(getActivity(), SimpleTakePhotoActivity.class);
                    intent.putExtras(bundle);
                    startActivityForResult(intent, code);
                }
            }
        }).show();

    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (resultCode == Activity.RESULT_OK) {
            if (requestCode == 111){
                Bundle bundle = data.getExtras();
                if (bundle != null){
                    Object object = bundle.get("result");
                    if (object instanceof ArrayList){
                        ArrayList list = (ArrayList) object;
                        if (list != null && list.size() == 1){
                            TImage image = (TImage) list.get(0);
                            meComponent.ivHeader.setImageDrawable(Drawable.createFromPath(image.getPath()));
                            SharedPreferenceUtil.set("headerFilePath", image.getPath());
                        }
                    }
                }
            }
        }
    }

    @Override
    public void initView() {
        super.initView();

        lvContainer.setOnRefreshListener(this);
        lvMenu = (ListView) rootView.findViewById(R.id.lv_menu);
        setupMenu();

        adapter = new MeFragmentListViewAdapter(context, menuModels, lvMenu);
        lvMenu.setAdapter(adapter);


        lvMenu.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                try {
                    MenuListItemModel model = menuModels.get(position);

                    if (model.extraBundle == null){
                        model.extraBundle = new Bundle();
                    }
                    model.extraBundle.putString("title", model.title);
                    if (model.activityClass != null){
                        ActivityHelper.startActivity(model.activityClass, model.extraBundle, model.isStartFromBottom);
                    }


                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        });
    }

    private void setupMenu(){
        menuModels = new ArrayList<>();
        // 头像部分
        MenuListItemModel model = new MyHeadViewModel();
        headViewModel = (MyHeadViewModel) model;
        headViewModel.setPraise("33");
        headViewModel.setComments("12");
        headViewModel.setIconPath(SharedPreferenceUtil.get("headerFilePath", ""));
        menuModels.add(headViewModel);

        model = new MenuListItemModel();
        model.iconRes = R.mipmap.about;
        model.title = "新任务";
        model.showIndicator = true;
        menuModels.add(model);

        model = new MenuListItemModel();
        model.iconRes = R.mipmap.about;
        model.title = "累计任务";
        model.showIndicator = true;
        menuModels.add(model);

        model = new MenuListItemModel();
        model.iconRes = R.mipmap.about;
        model.title = "关于";
        model.activityClass = AboutActivity.class;
        model.showIndicator = true;
        menuModels.add(model);

        model = new MenuListItemModel();
        model.iconRes = R.mipmap.about;
        model.title = "设置";
        model.activityClass = SettingActivity.class;
        model.showIndicator = true;
        menuModels.add(model);

    }

    @Override
    public void onRefresh() {
        loadState();
    }

    @Override
    public void updateStat() {
        if (menuModels != null){
            menuModels.get(1).tail = TaskStat.getInstance().newTaskNum;
            menuModels.get(2).tail = TaskStat.getInstance().countTaskNum;
            adapter.notifyDataSetChanged();
        }
    }
}
