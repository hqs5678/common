package com.fstm.fsinstaller.fragment;


import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.View;

import com.fstm.fsinstaller.R;

/**
 * Created by apple on 16/9/29.
 */

public class BaseFragment extends Fragment{
    protected Context context;
    protected SwipeRefreshLayout lvContainer;
    protected View rootView;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        context = getActivity();
    }

    public void initView(){
        lvContainer = (SwipeRefreshLayout) rootView.findViewById(R.id.lv_container);
        lvContainer.setColorSchemeResources(R.color.titleColor);
        lvContainer.setProgressBackgroundColorSchemeResource(R.color.colorPrimary);
    }

    public void loadState(){
        updateStat();
        lvContainer.setRefreshing(false);
    }

    public void updateStat(){

    }

}
