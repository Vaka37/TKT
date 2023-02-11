//
//  ContentView.swift
//  TKT
//
//  Created by Kalandarov Vakil on 24.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    var body: some View {
        VStack{
            if status{
                OrderView()
            }else{
                SignIniew()
            }
            
        }.animation(.spring())
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                    
                    let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    self.status = status
                }
            }
    }
}


