package com.fstm.fsinstaller.utils;


import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.geocode.GeoCodeOption;
import com.baidu.mapapi.search.geocode.GeoCoder;
import com.baidu.mapapi.search.geocode.OnGetGeoCoderResultListener;
import com.baidu.mapapi.search.geocode.ReverseGeoCodeOption;

/**
 * Created by apple on 2016/11/21.
 */

public class MapUtil {

    public static void geoCode(String city, String address, OnGetGeoCoderResultListener listener){

        GeoCoder geoCoder = GeoCoder.newInstance();
        GeoCodeOption option = new GeoCodeOption();
        option.city(city);
        option.address(address);

        geoCoder.setOnGetGeoCodeResultListener(listener);
        geoCoder.geocode(option);
    }

    public static void reverseGeoCode(double latitude, double longitude, OnGetGeoCoderResultListener listener){

        GeoCoder geoCoder = GeoCoder.newInstance();
        ReverseGeoCodeOption option = new ReverseGeoCodeOption();
        LatLng latLng = new LatLng(latitude, longitude);
        option.location(latLng);

        geoCoder.setOnGetGeoCodeResultListener(listener);
        geoCoder.reverseGeoCode(option);
    }
}
