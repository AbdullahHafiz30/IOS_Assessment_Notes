//
//  DrawerView.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 30/07/2025.
//

import SwiftUI

struct DrawerView: View {
    @Binding var selectedNavigationItem: Int
    @Binding var isDrawerOpen: Bool
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: .green.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading) {
                    ProfileImageView()
                        .padding(.bottom, 10)
                    
                    ForEach(NavigationDrawerRowType.allCases, id: \.self) { row in
                        RowView(isSelected: selectedNavigationItem == row.rawValue, imageName: row.iconName, title: row.title) {
                            selectedNavigationItem = row.rawValue
                            isDrawerOpen.toggle()
                        }
                    }
                    Spacer()
                }
                .padding(.top, 50)
                .frame(width: 270)
            }
            Spacer()
        }
    }
    
    func ProfileImageView() -> some View {
            HStack {
                Image(systemName: "person.circle.fill")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .background(Color("Burgundy"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Abdullah Hafiz")
                        .font(.system(size: 18, weight: .bold))
                    Text("test@gmail.com")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black.opacity(0.5))
                        .tint(.gray)
                }
            }
            .padding(.leading)
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 20) {
                Rectangle()
                    .fill(isSelected ? Color("Burgundy") : .white)
                    .frame(width: 5)
                Image(systemName: imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(isSelected ? .black : Color("Burgundy"))
                    .frame(width: 26, height: 26)
                Text(title)
                    .font(.system(size: 14, weight: .regular))
                    .tint(isSelected ? .white : Color("Burgundy"))
                Spacer()
            }
        }
        .frame(height: 50)
        .background(isSelected ? Color("Burgundy").opacity(0.5) : .white)
    }
}
