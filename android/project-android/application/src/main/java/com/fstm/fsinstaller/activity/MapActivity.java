package com.fstm.fsinstaller.activity;

import android.Manifest;
import android.content.Context;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;
import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.BitmapDescriptor;
import com.baidu.mapapi.map.BitmapDescriptorFactory;
import com.baidu.mapapi.map.MapStatus;
import com.baidu.mapapi.map.MapStatusUpdateFactory;
import com.baidu.mapapi.map.MapView;
import com.baidu.mapapi.map.Marker;
import com.baidu.mapapi.map.MarkerOptions;
import com.baidu.mapapi.map.MyLocationConfiguration;
import com.baidu.mapapi.map.MyLocationData;
import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.geocode.GeoCodeResult;
import com.baidu.mapapi.search.geocode.OnGetGeoCoderResultListener;
import com.baidu.mapapi.search.geocode.ReverseGeoCodeResult;
import com.baidu.mapapi.utils.route.BaiduMapRoutePlan;
import com.baidu.mapapi.utils.route.RouteParaOption;
import com.fstm.fsinstaller.R;
import com.fstm.fsinstaller.activity.base.BaseActivity;
import com.fstm.fsinstaller.helper.Helper;
import com.fstm.fsinstaller.utils.MapUtil;
import com.hqs.utils.AppUtils;
import com.hqs.utils.Log;
import com.hqs.view.DialogView;

public class MapActivity extends BaseActivity {


    private String city;
    private String address;

    private MapView mapView;
    private LocationClient mLocClient;
    private boolean isFirstLoc = true;
    private LatLng myPosition;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_map);

        initView(R.id.activity_map);
    }

    @Override
    public void initView(int res) {
        super.initView(res);

        // 请求定位权限
        ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION}, 0);


        LocationManager locManager = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
        if(!locManager.isProviderEnabled(LocationManager.GPS_PROVIDER))
        {
            // 未打开位置开关，可能导致定位失败或定位不准，提示用户或做相应处理
            Helper.showDialog("为了能够更精确的定位, 为您提供更好的服务, 请打开GPS!!!");
        }

        mapView = (MapView) findViewById(R.id.bMap);
        mapView.getMap().setMyLocationEnabled(true);

        mapView.getMap().setMyLocationConfigeration(new MyLocationConfiguration(
                        MyLocationConfiguration.LocationMode.NORMAL, true, null));

        LocationClientOption option = new LocationClientOption();
        option.setOpenGps(true); // 打开gps
        option.setIsNeedAddress(true);
        option.setCoorType("bd09ll"); // 设置坐标类型
        option.setScanSpan(4000);
        option.setAddrType("all");

        mLocClient = new LocationClient(this);  //   * 定位SDK的核心类
        //实例化定位服务，LocationClient类必须在主线程中声明
        mLocClient.registerLocationListener(new BDLocationListenerImpl());//注册定位监听接口
        mLocClient.setLocOption(option);
        mLocClient.start();  // 调用此方法开始定位



        Bundle bundle = getIntent().getExtras();
        if(bundle != null){
            city = bundle.getString("city");
            address = bundle.getString("address");
        }

        // 显示目标位置
        showTarget();

    }

    private void showTarget(){

        MapUtil.geoCode(city, address, new OnGetGeoCoderResultListener() {
            @Override
            public void onGetGeoCodeResult(GeoCodeResult geoCodeResult) {

                if (geoCodeResult == null || geoCodeResult.getLocation() == null){
                    return;
                }


                //定义Maker坐标点
                LatLng point = geoCodeResult.getLocation();
                //构建Marker图标
                BitmapDescriptor bitmap = BitmapDescriptorFactory.fromResource(R.mipmap.locate);

                MarkerOptions option = new MarkerOptions()
                        .position(point)
                        .icon(bitmap);

                mapView.getMap().addOverlay(option);
                mapView.getMap().setOnMarkerClickListener(new BaiduMap.OnMarkerClickListener() {
                    @Override
                    public boolean onMarkerClick(final Marker marker) {

                        if (marker == null || marker.getPosition() == null){
                            return false;
                        }

                        Helper.showDialog("导航到这里?", new DialogView.OnDialogClickListener() {
                            @Override
                            public void onClickOKButton() {

                                if (AppUtils.isAppInstalled(MapActivity.this, "com.baidu.BaiduMap")){
                                    Helper.showProgress();

                                    Helper.doInMainThreadDelayed(new Runnable() {
                                        @Override
                                        public void run() {
                                            LatLng to = marker.getPosition();
                                            navigate(myPosition, to);
                                        }
                                    }, 40);
                                }
                                else{
                                    makeToast("未找到百度地图!!!");
                                }
                            }

                            @Override
                            public void onClickCancelButton() {

                            }
                        });

                        return false;
                    }
                });
            }

            @Override
            public void onGetReverseGeoCodeResult(ReverseGeoCodeResult reverseGeoCodeResult) {

                Log.print(reverseGeoCodeResult.getAddressDetail());
                Log.print(reverseGeoCodeResult.getLocation().toString());
            }
        });
    }

    private void navigate(LatLng from, LatLng to){

        // 构建 route搜索参数以及策略，起终点也可以用name构造
        RouteParaOption para = new RouteParaOption()
                .startPoint(from)
                .endPoint(to);
        try {
            BaiduMapRoutePlan.openBaiduMapDrivingRoute(para, this);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //结束调启功能时调用finish方法以释放相关资源
        BaiduMapRoutePlan.finish(this);
    }

    public class BDLocationListenerImpl implements BDLocationListener {
        //  * 接收异步返回的定位结果，参数是BDLocation类型参数
        @Override
        public void onReceiveLocation(BDLocation location) {
            if (location == null) {
                return;
            }

            String notPermission = "62, 63, 67, 162, 167";
            String locType = location.getLocType() + "";
            if (notPermission.contains(locType)) {
                Log.print("locType = " + locType);
                Helper.showDialog("定位失败, 请检查是否打开定位权限!!!");
                mLocClient.unRegisterLocationListener(this);
                mLocClient.stop();
                return;
            }

            MyLocationData locData = new MyLocationData.Builder()
                    .accuracy(location.getRadius())
                    .direction(location.getDirection())
                    .latitude(location.getLatitude())
                    .longitude(location.getLongitude()).build();
            mapView.getMap().setMyLocationData(locData);

            // 保存我的位置
            myPosition = new LatLng(location.getLatitude(), location.getLongitude());

            if (isFirstLoc) {
                isFirstLoc = false;
                LatLng ll = new LatLng(location.getLatitude(),
                        location.getLongitude());
                MapStatus.Builder builder = new MapStatus.Builder();
                builder.target(ll).zoom(12.0f);
                mapView.getMap().animateMapStatus(MapStatusUpdateFactory.newMapStatus(builder.build()));


            }
        }
    }

    @Override
    protected void onStop() {
        super.onStop();

        Helper.dismissProgress();
    }

    @Override
    protected void onDestroy() {
        // 退出时销毁定位
        mLocClient.stop();
        // 关闭定位图层
        mapView.getMap().setMyLocationEnabled(false);
        mapView.onDestroy();
        mapView = null;
        super.onDestroy();
    }
}
