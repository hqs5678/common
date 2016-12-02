package com.fstm.fsinstaller.fragment;

import android.os.Bundle;
import android.support.v4.widget.SwipeRefreshLayout;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.fstm.fsinstaller.R;

/**
 * Created by apple on 16/9/26.
 */

public class MessageFragment extends BaseFragment implements SwipeRefreshLayout.OnRefreshListener{

    private ListView lvMessage;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        rootView = inflater.inflate(R.layout.fragment_message, container, false);
        initView();
        return rootView;
    }

    @Override
    public void initView() {
        super.initView();

        lvContainer.setOnRefreshListener(this);
        lvMessage = (ListView) rootView.findViewById(R.id.lv_message);
    }

    @Override
    public void onRefresh() {
        lvContainer.setRefreshing(false);
    }
}
