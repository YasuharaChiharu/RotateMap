//
//  LocationManager.swift
//  RotateMap
//
//  Created by Chiharu Yasuhara on R 3/06/04.
//

import MapKit

//現在地を取得
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion()
    @Published var heading:CLLocationDirection = 0.0

    let manager = CLLocationManager()

    override init() {
        super.init()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        //電子コンパス設定
        manager.headingFilter = kCLHeadingFilterNone
        manager.headingOrientation = .portrait
        manager.startUpdatingHeading()
        
        //位置情報取得
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 2
        manager.startUpdatingLocation()
        
    }
    
    //電子コンパス値取得
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.heading = newHeading.magneticHeading
    }
    
    //位置情報からMAP表示用のRegion生成
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locations.last.map {
            let center = CLLocationCoordinate2D(
                latitude: $0.coordinate.latitude,
                longitude: $0.coordinate.longitude)

            region = MKCoordinateRegion(
                center: center,
                latitudinalMeters: 1000.0,
                longitudinalMeters: 1000.0
            )
        }
        
    }
    
    
}
