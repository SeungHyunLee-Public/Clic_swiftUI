//
//  KlifeApp.swift
//  Klife
//
//  Created by 이승현 on 2021/06/30.
//
import SwiftUI
import Firebase
import GoogleSignIn

@main
struct KlifeApp: App {
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
        setupAuthentication()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

extension KlifeApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    }
}
