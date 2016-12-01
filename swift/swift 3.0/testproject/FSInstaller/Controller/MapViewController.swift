//
//  MapViewController.swift
//  FSInstaller
//
//  Created by Apple on 16/8/8.
//  Copyright © 2016年 huangqingsong. All rights reserved.
//


class MapViewController: BaseViewController {
    
    var mapView: BMKMapView!
    var city = ""
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "位置"
        
 
        mapView = MapHelper.shared.addMapView(self.view, mapViewFrame: self.view.bounds, complete: { (mapView) in
            
        })
        
        MapHelper.shared.addAnnotation(city, address: address, withTitle: "到这里", forMapView: mapView) { [weak self] (mapView, annotationViewForBubble) in
            
            if MapHelper.shared.installedBaiduMap() {
                
                
                let node = BMKPlanNode()
                if let coordinate = annotationViewForBubble?.annotation.coordinate {
                    node.pt = coordinate
                }
                node.cityName = self?.city
                node.name = self?.address
                MapHelper.shared.startNavigateWithBaiduMap(node)
            }
            else {
                MapHelper.shared.startNavigateWithLocalMap(self!.city + self!.address)
            }
        }
        
        MapHelper.shared.showUserLocationAnnotation(mapView)
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
