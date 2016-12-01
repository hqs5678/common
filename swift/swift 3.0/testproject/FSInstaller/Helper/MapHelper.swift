//
//  MapHelper.swift
//  baidumap
//
//  Created by 火星人 on 16/8/6.
//  Copyright © 2016年 火星人. All rights reserved.
//

import MapKit

private let _sharedInstanceMapHelper = MapHelper()


class MapHelper: NSObject, BMKGeoCodeSearchDelegate, BMKLocationServiceDelegate, BMKMapViewDelegate {

    var mapView: BMKMapView!
    var reverseGeoCodeOption: BMKReverseGeoCodeOption!
    var geocodeSearchOption: BMKGeoCodeSearchOption!
    var geocodeSearch: BMKGeoCodeSearch!
    
    fileprivate var geoCodeHandle = {
        (location: CLLocationCoordinate2D, address: String) -> Void in
        return
    }
    
    fileprivate var reverseGeoCodeHandle = {
        (location: CLLocationCoordinate2D, address: String) -> Void in
        return
    }
    
    fileprivate var annotationViewForBubbleHandle = {
        (mapView: BMKMapView!, annotationViewForBubble: BMKAnnotationView!) -> Void in
        return
    }
    
    // 选中某个annotation
    var selectAnnotationViewHandle = {
        (mapView: BMKMapView!, annotationView: BMKAnnotationView!) -> Void in
        return
    }
    
    var mapViewDidFinishLoadingHandle = {
        (mapView: BMKMapView!) -> Void in
        return
    }
    
    fileprivate var locationService: BMKLocationService!
    
    fileprivate var startUserLocation = false   // 获取当前位置
    
    // 最简单的单例模式
    public static let shared: MapHelper = {
        return MapHelper()
    }()
    
    // 获取用户当前位置  闭包处理获取到地理 坐标 和 名称
    func startUserLocation(_ userLocationResultHandle: @escaping (_ location: CLLocationCoordinate2D, _ address: String) -> Void){
        
        if locationService == nil {
            locationService = BMKLocationService()
        }
        locationService.delegate = self
        locationService.startUserLocationService()
        reverseGeoCodeHandle = userLocationResultHandle
        
        startUserLocation = true
    }
    
    func didUpdate(_ userLocation: BMKUserLocation!) {
//        appPrint("didUpdateBMKUserLocation")
 
        
        let location = userLocation.location
        
        if startUserLocation {
            reverseGeoCode((location?.coordinate)!, reverseGeoCodeHandle: reverseGeoCodeHandle)
            startUserLocation = false
        }
        
        
        if self.mapView != nil {
            self.mapView.updateLocationData(userLocation)
        }
        
    }
    
    func stopUserLocation(){
        locationService.stopUserLocationService()
        locationService.delegate = nil
        locationService = nil
    }
    
    // coordinate -> string
    func reverseGeoCode(_ coordinate: CLLocationCoordinate2D, reverseGeoCodeHandle:@escaping (_ location: CLLocationCoordinate2D, _ address: String) -> Void){
        
        if reverseGeoCodeOption == nil {
            reverseGeoCodeOption = BMKReverseGeoCodeOption()
        }
        reverseGeoCodeOption.reverseGeoPoint = coordinate
        
        if geocodeSearch == nil {
            geocodeSearch = BMKGeoCodeSearch()
            geocodeSearch.delegate = self
        }
        
        
        let flag = geocodeSearch.reverseGeoCode(reverseGeoCodeOption)
        if flag {
            //            appPrint("反geo 检索发送成功")
        } else {
            appPrint("反geo 检索发送失败")
        }
        
        self.reverseGeoCodeHandle = reverseGeoCodeHandle
    }
    
    func geoCode(_ city: String, address: String, geoCodeHandle:@escaping (_ location: CLLocationCoordinate2D, _ address: String) -> Void){
        
        if geocodeSearchOption == nil {
            geocodeSearchOption = BMKGeoCodeSearchOption()
        }
        geocodeSearchOption.city = city
        geocodeSearchOption.address = address
        
        if geocodeSearch == nil {
            geocodeSearch = BMKGeoCodeSearch()
            geocodeSearch.delegate = self
        }
        
        
        let flag = geocodeSearch.geoCode(geocodeSearchOption)
        if flag {
//            appPrint("geo 检索发送成功")
        } else {
            appPrint("geo 检索发送失败")
        }
        
        self.geoCodeHandle = geoCodeHandle
    }
    
    func onGetGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        
        guard result != nil else {
            appPrint(error)
            return
        }
        
        geoCodeHandle(result.location, result.address)
    }
    
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        
        guard result != nil else {
            appPrint(error)
            return
        }
        
        if result.address != nil && result.address.length() > 0 {
            reverseGeoCodeHandle(result.location, result.address)
            startUserLocation = false
        }
        
    }
    
    
    // 为mapView 添加标注
    func addAnnotation(_ city: String, address: String, withTitle title: String, forMapView mapView: BMKMapView, clickBubbleHandle: @escaping (_ mapView: BMKMapView?, _ annotationViewForBubble: BMKAnnotationView?) -> Void) {
        
        geoCode(city, address: address) { (location, address) in
            
            let ann = BMKPointAnnotation()
            ann.coordinate = location
            ann.title = title
            mapView.delegate = self
            
            let anns = mapView.annotations
            for an in anns! {
                if ann.title == (an as AnyObject).title {
                    return
                }
            }
            
            mapView.addAnnotation(ann)
            
            
            
            self.annotationViewForBubbleHandle = clickBubbleHandle
        }

    }
    
    func addAnnotation(_ annotation: BMKPointAnnotation, forMapView mapView: BMKMapView, clickBubbleHandle: @escaping (_ mapView: BMKMapView?, _ annotationViewForBubble: BMKAnnotationView?) -> Void) {
        
        let anns = mapView.annotations
        for an in anns! {
            if an as! NSObject === annotation {
                return
            }
        }
        mapView.delegate = self
        mapView.addAnnotation(annotation)
        
        self.annotationViewForBubbleHandle = clickBubbleHandle
    }
    
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        
        if annotation.isKind(of: BMKPointAnnotation.self) {
            let newAnnotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "BMKPinAnnotationView")
            newAnnotationView?.pinColor = UInt(BMKPinAnnotationColorPurple)
            newAnnotationView?.animatesDrop = true
            
            newAnnotationView?.image = UIImage(named: "location")
            
            newAnnotationView?.leftCalloutAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 10))
            newAnnotationView?.rightCalloutAccessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 10))
            
            return newAnnotationView
            
        }
        return nil
    }
    
    // 选中某个annotation的bubble 时触发的事件
    func mapView(_ mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        self.annotationViewForBubbleHandle(mapView, view)
        
        // 隐藏bubble
        mapView.deselectAnnotation(view.annotation, animated: true)
    }
    
    // 选中某个annotation
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        self.selectAnnotationViewHandle(mapView, view)
    }
    
    
    // 地图导航
    // 地图导航注意事项
    // 需要在info.plist 文件中配置内容:
    // 添加 LSApplicationQueriesSchemes: array , 在里面添加 baidumap: string
    // 添加 NSLocationAlwaysUsageDescription: string
    // 添加 Bundle display name: string
    
    // 调用系统地图导航
    // 需要在info.plist 文件中配置设置  详见本文件 地图导航注意事项
    func startNavigateWithBaiduMap(_ city: String, address: String){
        
        self.geoCode(city, address: address) { [weak self](location, address) in
            
            // 初始化终点节点
            let end = BMKPlanNode()
            // 指定终点经纬度
            end.pt = location
            // 指定终点名称
            end.name = address
            
            self?.startNavigateWithBaiduMap(end)
        }
        
    }
    
    // 调用系统地图导航
    func startNavigateWithBaiduMap(_ end: BMKPlanNode){
        
        // 初始化调启导航的参数管理类
        let parameter = BMKNaviPara()
        
        parameter.endPoint = end
        
        // 指定返回自定义 scheme
        parameter.appScheme = "baidumapsdk://mapsdk.baidu.com"
        
        // 调启百度地图客户端导航
        BMKNavigation.openBaiduMapNavigation(parameter)
    }
    
    // 调用本地的地图导航  经测试  不准  不推荐使用
    func startNavigateWithLocalMap(_ endPlace: String?){
        
        guard endPlace != nil else {
            return
        }
        
        let geo = CLGeocoder()
        
        geo.geocodeAddressString(endPlace!, completionHandler: { (placemarks, error) in
            
            let endPlace = MKPlacemark(placemark: placemarks!.first!)
            let endMapItem = MKMapItem(placemark: endPlace)
            
            let items = [endMapItem]
            let dict = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: NSNumber(value: 0 as Int)] as [String : Any]
            MKMapItem.openMaps(with: items, launchOptions: dict)
        })
    }
    
    
    // 检测本地是否已经安装了百度地图
    // 需要在info.plist 文件中配置设置 详见本文件 地图导航注意事项
    func installedBaiduMap() -> Bool{
        let install = UIApplication.shared.canOpenURL(URL(string: "baidumap://")!)
        return install
    }
    
    func addMapView(_ inView: UIView, mapViewFrame: CGRect, complete: @escaping (_ mapView: BMKMapView?) -> Void) -> BMKMapView{
        
        if self.mapView == nil {
            self.mapView = BMKMapView(frame: mapViewFrame)
            mapView.delegate = self
        }
        
        inView.addSubview(mapView)
        self.mapViewDidFinishLoadingHandle = complete
        
        return mapView
    }
    
    func mapViewDidFinishLoading(_ mapView: BMKMapView!) {
        
        self.mapViewDidFinishLoadingHandle(mapView)
    }
    
    func showUserLocationAnnotation(_ mapView: BMKMapView){
        self.mapView = mapView
        self.mapView.delegate = self
        
        if locationService == nil {
            locationService = BMKLocationService()
            locationService.delegate = self
        }
        locationService.startUserLocationService()
        
        mapView.showsUserLocation = false
        mapView.userTrackingMode = BMKUserTrackingModeNone
        mapView.showsUserLocation = true
    }

}
