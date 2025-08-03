//
//  ContentView.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 29/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isDrawerOpen = false
    @State private var selectedNavigationItem = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selectedNavigationItem) {
                    HomeView(isDrawerOpen: $isDrawerOpen)
                        .tag(0)
                    NotesListView(isDrawerOpen: $isDrawerOpen)
                        .tag(1)
                }
                if isDrawerOpen {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isDrawerOpen = false
                            }
                        }
                }
                
                NavigationMenu(isShowing: $isDrawerOpen, content: AnyView(DrawerView(selectedNavigationItem: $selectedNavigationItem, isDrawerOpen: $isDrawerOpen)))
            }
        }
    }
}


#Preview {
    ContentView()
}
