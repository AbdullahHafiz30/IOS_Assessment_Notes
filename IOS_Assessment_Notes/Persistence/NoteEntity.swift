//
//  NoteEntity.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 01/08/2025.
//

import CoreData
import Foundation

extension NoteEntity {
    func fill(from note: Note) {
        id        = note.id
        text      = note.text
        createdAt = note.createdAt
        updatedAt = note.updatedAt
    }
    
    func toModel() -> Note {
        Note(id: id ?? UUID(),
             text: text ?? "",
             createdAt: createdAt ?? .distantPast,
             updatedAt: updatedAt)
    }
}
