//
//  MapView.swift
//  TKT
//
//  Created by Kalandarov Vakil on 27.12.2023.
//

import SwiftUI
import YandexMapsMobile
import Combine

struct MapView: View {
    @ObservedObject var locationManager = LocationManager()
    var body: some View {
        ZStack{
            YandexMapView().edgesIgnoringSafeArea(.all).environmentObject(locationManager)
                  }.onAppear{
                      locationManager.currentUserLocation()
                  }
        }
    }



struct YandexMapView: UIViewRepresentable {
    @EnvironmentObject var locationManager : LocationManager
    func makeUIView(context: Context) -> YMKMapView {
        return locationManager.mapView
    }
    func updateUIView(_ mapView: YMKMapView, context: Context) {}
}
