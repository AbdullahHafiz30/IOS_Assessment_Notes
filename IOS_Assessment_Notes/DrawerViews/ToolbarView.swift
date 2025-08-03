//
//  ToolbarView.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 30/07/2025.
//

import SwiftUI

struct ToolbarView: View {
    var title: String
    var iconAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: iconAction) {
                Image(systemName: "line.horizontal.3")
                    .font(.title2).foregroundColor(Color("Burgundy"))
            }
            Spacer()
        }
        .padding(.top, 16)
        .overlay(
            Text(title)
                .font(.headline)
                .foregroundColor(Color("Burgundy"))
        )
    }
}
