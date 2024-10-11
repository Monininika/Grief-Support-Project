//
//  PersonalizationOption.swift
//  Eternai
//
//  Created by Monica Shen on 2024-09-29.
//


import Foundation

public enum PersonalizationOption: String {
    case familyMember = "Reconnect with A Loved One"
    case virtualCharacter = "Create a New Character"
}

import SwiftUI

struct PersonalizationOptionView: View {
    @State private var selectedOption: PersonalizationOption?
    @State private var showTerms = false
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.15).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Choose an Option")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Button("Reconnect with a Loved One") {
                    selectedOption = .familyMember
                    showTerms = true
                }
                .buttonStyle(CustomButtonStyle())
                
                Button("Create a New Character") {
                    selectedOption = .virtualCharacter
                    showTerms = true
                }
                .buttonStyle(CustomButtonStyle())
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showTerms) {
            if let option = selectedOption {
                TermsAndAgreementView(option: option)
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct PersonalizationOptionView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationOptionView()
    }
}
