//
//  ContentView.swift
//  RotateMap
//
//  Created by Chiharu Yasuhara on R 3/06/04.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var manager = LocationManager()
    @State var region = MKCoordinateRegion()
    @State var trackingMode = MapUserTrackingMode.follow
    
    var body: some View {
        let heading   = $manager.heading.wrappedValue
        let latitude  = $region.center.latitude.wrappedValue
        let longitude = $region.center.longitude.wrappedValue

        VStack{
            Text("緯度：\(latitude) 経度： \(longitude)")
            Text("北方向: \(heading)")

            Map(coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: $trackingMode)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding(40)
                .edgesIgnoringSafeArea(.bottom)
                .rotationEffect(Angle(degrees: 360.0-heading))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
