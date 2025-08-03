//
//  NavigationDrawerRowType.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 30/07/2025.
//


enum NavigationDrawerRowType: Int, CaseIterable {
    case newNote = 0
    case Notes
    
    var title: String {
        switch self {
        case .newNote:
            return "New Note"
        case .Notes:
            return "Notes"
        }
    }
    
    var iconName: String {
        switch self {
        case .newNote:
            return "square.and.pencil"
        case .Notes:
            return "list.bullet.clipboard"
        }
    }
}
