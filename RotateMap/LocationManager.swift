//
//  LocationManager.swift
//  RotateMap
//
//  Created by Chiharu Yasuhara on R 3/06/04.
//

import MapKit

//現在地を取得
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var heading:CLLocationDirection = 0.0

    let manager = CLLocationManager()

    override init() {
        super.init()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        //電子コンパス設定
        manager.headingFilter      = kCLHeadingFilterNone
        manager.headingOrientation = .portrait
        manager.startUpdatingHeading()
    }
    
    //電子コンパス値取得
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.heading = newHeading.magneticHeading
    }
    
}
