package com.fstm.fsinstaller.activity;

import android.Manifest;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.view.KeyEvent;
import android.widget.Toast;

import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.fragment.BaseFragment;
import com.fstm.fsinstaller.fragment.MeFragment;
import com.fstm.fsinstaller.fragment.MessageFragment;
import com.fstm.fsinstaller.fragment.TaskFragment;
import com.fstm.fsinstaller.helper.ActivityHelper;
import com.fstm.fsinstaller.helper.Helper;
import com.hqs.utils.ScreenUtils;
import com.hqs.view.NavigationBar;
import com.hqs.view.QSViewPager;
import com.hqs.view.tabbar.TabBarItem;
import com.hqs.view.tabbar.TabBarView;
import com.umeng.analytics.MobclickAgent;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    private MainActivity.SectionsPagerAdapter mSectionsPagerAdapter;
    private TabBarView tabBarView;
    private QSViewPager mViewPager;
    private NavigationBar navigationBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        ScreenUtils.setScreenOrientationPortrait(this);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ActivityCompat.requestPermissions(this, new String[]{
                Manifest.permission.SYSTEM_ALERT_WINDOW,
                Manifest.permission.READ_PHONE_STATE,
                Manifest.permission.WAKE_LOCK,
                Manifest.permission.GET_TASKS,
                Manifest.permission.VIBRATE,
                Manifest.permission.ACCESS_COARSE_LOCATION,
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.BLUETOOTH_ADMIN,
                Manifest.permission.BLUETOOTH
        }, 0);


        navigationBar = (NavigationBar) findViewById(R.id.title_view);
        mSectionsPagerAdapter = new MainActivity.SectionsPagerAdapter(getSupportFragmentManager());

        mViewPager = (QSViewPager) findViewById(R.id.container);
        mViewPager.setHorizontalScrollEnabel(false);
        mViewPager.setAdapter(mSectionsPagerAdapter);

        mViewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                tabBarView.setCurrentSelectedIndex(position);
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });












        // tab bar
        tabBarView = (TabBarView) findViewById(R.id.tabBarView);
        tabBarView.setBarTintColor(getResources().getColor(R.color.tabBgColor));
        tabBarView.setRippleColor(getResources().getColor(R.color.colorAccent));
        // 设置tab
        ArrayList<TabBarItem> items = new ArrayList<>();

        // 暂时屏蔽
        TabBarItem item = new TabBarItem();
        item.title = "消息";
        item.iconRes = R.mipmap.message;
        item.selectedIconRes = R.mipmap.message_p;
        items.add(item);

        item = new TabBarItem();
        item.title = "任务";
        item.iconRes = R.mipmap.task;
        item.selectedIconRes = R.mipmap.task_p;
        item.badgeValue = "99";
        items.add(item);

        item = new TabBarItem();
        item.title = "我";
        item.iconRes = R.mipmap.my;
        item.selectedIconRes = R.mipmap.my_p;
        item.badgeValue = "new";
        items.add(item);

        tabBarView.setTabBarItems(items);

        tabBarView.setTitleColor(this.getResources().getColor(R.color.tabTitleColor));
        tabBarView.setSelectedTitleColor(this.getResources().getColor(R.color.tabSelectedTitleColor));
        tabBarView.setTitleSize(14);


        // 设置回调
        tabBarView.setOnSelectedTabBarItemListener(new TabBarView.OnSelectedTabBarItemListener() {
            @Override
            public void onSelectedTabBarItem(int oldIndex, int newIndex) {

                mViewPager.setCurrentItem(newIndex, false);
                navigationBar.titleView.setText(tabBarView.getTabBarItems().get(newIndex).title);

            }
        });



        tabBarView.setOnClickTabBarItemListener(new TabBarView.OnClickTabBarItemListener() {
            @Override
            public void onClickTabBarItem(TabBarItem item, TabBarView.ItemView itemView, int index) {
                // Log.e("=======", item.title + "   " + index);
                itemView.setBadgeValue(null);

                navigationBar.setTitle(item.title);

//                if (index == 0){
//                    itemView.setBadgeValue("99+");
//
//
//
//
//
//
//                    Helper.showProgress(MainActivity.this);
//                    Helper.doInMainThreadDelayed(new Runnable() {
//                        @Override
//                        public void run() {
//                            Helper.dismissProgress();
//                        }
//                    }, 2000);
//                }
            }
        });


        tabBarView.setCurrentSelectedIndex(1);




        // 判断是否第一次使用本系统
        if (Helper.isFirstLaunch()){
            ActivityHelper.startActivity(WelcomeActivity.class, null, true);
        }
        else{
            // 判断用户是否已经登录
//            if (Helper.isLoginOk() == false){
//                ActivityHelper.startActivity(LoginActivity.class, null, true);
//            }
//            else{
//                MobclickAgent.onProfileSignIn(User.getInstance().uid);
//            }
        }


    }



    @Override
    public void onResume() {
        super.onResume();

    }


    /**
     * A {@link FragmentPagerAdapter} that returns a fragment corresponding to
     * one of the sections/tabs/pages.
     */
    public class SectionsPagerAdapter extends FragmentPagerAdapter {

        private ArrayList<BaseFragment> fragments = new ArrayList<>();

        public SectionsPagerAdapter(FragmentManager fm) {
            super(fm);

            // 暂时屏蔽
            MessageFragment messageFragment = new MessageFragment();
            fragments.add(messageFragment);

            TaskFragment taskFragment = new TaskFragment();
            fragments.add(taskFragment);

            MeFragment meFragment = new MeFragment();
            fragments.add(meFragment);
        }


        @Override
        public Fragment getItem(int position) {
            return fragments.get(position);
        }

        @Override
        public int getCount() {
            return fragments.size();
        }

        @Override
        public void notifyDataSetChanged() {
            super.notifyDataSetChanged();
        }
    }


    private long preTime = 0;
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK){

            long curTime = System.currentTimeMillis();
            if((curTime - preTime) / 2000 < 1 ){
                MobclickAgent.onKillProcess(this);
                System.exit(0);
            }
            else{
                preTime = curTime;
                Toast.makeText(this, "再按一次退出", Toast.LENGTH_SHORT).show();
            }
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }
}
