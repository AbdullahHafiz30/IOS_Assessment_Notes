//
//  HomeView.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 30/07/2025.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var isDrawerOpen: Bool
    @FocusState private var isFocused: Bool
    @StateObject private var vm = AddNoteViewModel()
    
    var body: some View {
        VStack {
            ToolbarView(title: "New Note", iconAction: { isDrawerOpen.toggle() })
            
            HStack {
                Text("Time : ")
                
                if let ts = vm.timestamp {
                    Text(ts.formatted(date: .numeric, time: .standard))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .padding(.top, 40)
            
            ZStack(alignment: .topLeading) {
                if vm.text.isEmpty && !isFocused {
                    Text("Write your note here...")
                        .foregroundColor(Color("Burgundy").opacity(0.4))
                        .padding(.horizontal, 10)
                        .padding(.top, 30)
                }
                
                
                TextEditor(text: $vm.text)
                    .focused($isFocused)
                    .frame(height: 350)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("Burgundy"), lineWidth: 1)
                    )
                    .padding(.top)
                    .foregroundColor(.black.opacity(0.7))
                    .scrollContentBackground(.hidden)
                
            }
            
            Button(action: {
                Task { await vm.save(); isFocused = false }
            }) {
                Text("Save Note")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color("Burgundy"))
                    .cornerRadius(8)
            }
            .disabled(vm.isBusy)
            .padding(.top, 20)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .overlay {
            if vm.isBusy { ProgressView().scaleEffect(1.4) }
        }
        .alert("Error",
               isPresented: Binding(
                get: { vm.alert != nil },
                set: { _ in vm.alert = nil })) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text(vm.alert ?? "")
                }
    }
}

#Preview {
    HomeView(isDrawerOpen: .constant(false))
}
