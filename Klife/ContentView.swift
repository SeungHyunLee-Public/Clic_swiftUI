//
//  ContentView.swift
//  Klife
//
//  Created by 이승현 on 2021/06/30.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        switch viewModel.state {
        case .signedIn: Home()
        case .signedOut: Login()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
