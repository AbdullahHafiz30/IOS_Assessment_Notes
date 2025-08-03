//
//  NotesListViewModel.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 01/08/2025.
//


import SwiftUI

@MainActor
final class NotesListViewModel: ObservableObject {
    @Published private(set) var notes: [Note] = []
    @Published private(set) var isLoading = false
    @Published private(set) var hasMore = true
    
    private let repo = CoreDataNotesRepository()
    private let pageSize = 10
    private var page = 0
    
    init() { loadMore() }
    
    func loadMore() {
        guard !isLoading, hasMore else { return }
        isLoading = true
        
        // Small visible delay so the spinner is noticeable
        Task {
            try? await Task.sleep(nanoseconds: 600_000_000) // ~0.6s
            
            // (Fetch remains on MainActor since VM is @MainActor)
            let slice = (try? repo.fetch(limit: pageSize, offset: page*pageSize)) ?? []
            
            if slice.isEmpty {
                hasMore = false
            } else {
                notes.append(contentsOf: slice)
                page += 1
                hasMore = (slice.count == pageSize)
            }
            
            isLoading = false
        }
    }
    
    func delete(at offsets: IndexSet) {
        for idx in offsets { try? repo.delete(id: notes[idx].id) }
        notes.remove(atOffsets: offsets)
    }
    
    func update(_ note: Note) {
        do { try repo.update(note) }
        catch { print("⚠️ Update failed:", error) }
        if let i = notes.firstIndex(where: { $0.id == note.id }) {
            notes[i] = note
        }
    }
    
    func reset() {
        notes.removeAll()
        page = 0
        loadMore()
    }
}
