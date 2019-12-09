//
//  ViewController.swift
//  iBeaconDemo
//
//  Created by haoran on 2019/11/4.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }

    

}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("didStartMonitoringFor\(region)")
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        print("didRangeBeacons \(beacons.count)个")

    }
    
    // monitoring 监听某个beacon失败
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Failed monitoring region\(error.localizedDescription)")
    }
    
    // 位置管理者出现错误信息
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed \(error.localizedDescription)")
    }
    
    // ranging 监听某个beacon失败
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print("rangingBeaconsDidFailFor")
    }
    
    // 已经进入到某个区域
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion")
    }
    
    // 已经从某个区域离开
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion")
    }

}
