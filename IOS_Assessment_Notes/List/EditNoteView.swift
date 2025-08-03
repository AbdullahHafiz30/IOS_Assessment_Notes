//
//  EditNoteView.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 02/08/2025.
//

import SwiftUI

struct EditNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var draft: String
    let original: Note
    let onSave: (Note) -> Void
    
    init(note: Note, onSave: @escaping (Note) -> Void) {
        _draft   = State(initialValue: note.text)
        self.original = note
        self.onSave   = onSave
    }
    
    var body: some View {
        NavigationStack {
            TextEditor(text: $draft)
                .padding()
                .navigationTitle("Edit Note")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            var edited = original
                            edited.text = draft
                            edited.updatedAt = Date()
                            onSave(edited)
                            dismiss()
                        }
                        .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", role: .cancel) { dismiss() }
                    }
                }
        }
    }
}
