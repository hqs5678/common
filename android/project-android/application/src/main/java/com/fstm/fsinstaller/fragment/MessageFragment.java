package com.fstm.fsinstaller.fragment;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.TextView;

import com.fstm.fsinstaller.R;

import it.neokree.materialtabs.MaterialTab;
import it.neokree.materialtabs.MaterialTabHost;
import it.neokree.materialtabs.MaterialTabListener;

/**
 * Created by apple on 16/9/26.
 */

public class MessageFragment extends BaseFragment implements SwipeRefreshLayout.OnRefreshListener, MaterialTabListener {

    private ListView lvMessage;


    private MaterialTabHost tabHost;
    private ViewPager pager;
    private ViewPagerAdapter adapter;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        rootView = inflater.inflate(R.layout.fragment_message, container, false);
        initView();
        return rootView;
    }

    @Override
    public void initView() {
//        super.initView();
//
//        lvContainer.setOnRefreshListener(this);
//        lvMessage = (ListView) rootView.findViewById(R.id.lv_message);


        Toolbar toolbar = (android.support.v7.widget.Toolbar) rootView.findViewById(R.id.toolbar);
        ((AppCompatActivity)this.getActivity()).setSupportActionBar(toolbar);

        tabHost = (MaterialTabHost) rootView.findViewById(R.id.tabHost);
        pager = (ViewPager) rootView.findViewById(R.id.pager );

        // init view pager
        adapter = new ViewPagerAdapter(getActivity().getSupportFragmentManager());
        pager.setAdapter(adapter);
        pager.setOnPageChangeListener(new ViewPager.SimpleOnPageChangeListener() {
            @Override
            public void onPageSelected(int position) {
                // when user do a swipe the selected tab change
                tabHost.setSelectedNavigationItem(position);

            }
        });

        // insert all tabs from pagerAdapter data
        for (int i = 0; i < adapter.getCount(); i++) {
            tabHost.addTab(
                    tabHost.newTab()
                            .setText(adapter.getPageTitle(i))
                            .setTabListener(this)
            );

        }

    }

    @Override
    public void onTabSelected(MaterialTab tab) {
        pager.setCurrentItem(tab.getPosition());
    }

    @Override
    public void onTabReselected(MaterialTab tab) {

    }

    @Override
    public void onTabUnselected(MaterialTab tab) {

    }

    private class ViewPagerAdapter extends FragmentStatePagerAdapter {

        public ViewPagerAdapter(FragmentManager fm) {
            super(fm);

        }

        public Fragment getItem(int num) {
            return new FragmentText();
        }

        @Override
        public int getCount() {
            return 16;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            return "Section " + position;
        }

    }


    public static class FragmentText extends Fragment{
        @Override
        public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
            TextView text = new TextView(container.getContext());
            text.setText("Fragment content");
            text.setGravity(Gravity.CENTER);

            return text;
        }
    }



    @Override
    public void onRefresh() {
        lvContainer.setRefreshing(false);
    }
}


