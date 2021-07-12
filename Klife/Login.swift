//
//  LoginView.swift
//  Klife
//
//  Created by 이승현 on 2021/06/30.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Clik")
                .fontWeight(.black)
                .foregroundColor(Color(.black))
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Text("Convenient Life In Korea")
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button("Sign in with Google") {
                viewModel.signIn()
            }
            .buttonStyle(AuthenticationButtonStyle())
        }
    }
}

struct AuthenticationButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemIndigo))
            .cornerRadius(12)
            .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
