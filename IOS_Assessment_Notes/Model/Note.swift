//
//  Note.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 01/08/2025.
//


import Foundation


struct Note: Codable, Identifiable, Equatable {
    let id: UUID
    var text: String
    var createdAt: Date
    var updatedAt: Date?
    
    static func new(text: String, at date: Date) -> Note {
        .init(id: UUID(), text: text, createdAt: date)
    }
}
