//
//  NotesListView.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 02/08/2025.
//

import SwiftUI

struct NotesListView: View {
    @Binding var isDrawerOpen: Bool
    @StateObject private var vm = NotesListViewModel()
    @State private var editing: Note?
    @State private var pendingDelete: Note?
    @State private var pendingDeleteOffsets: IndexSet?
    
    var body: some View {
        VStack(spacing: 0) {
            ToolbarView(title: "All Notes") { isDrawerOpen.toggle() }
            
            List {
                ForEach(vm.notes) { note in
                    NoteRow(note: note)
                        .contentShape(Rectangle())
                        .onTapGesture { editing = note }
                        .swipeActions(edge: .leading) {
                            Button {
                                editing = note
                            } label: {
                                Label("Edit", systemImage: "square.and.pencil")
                            }
                            .tint(.blue)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                pendingDelete = note
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .onAppear {
                            if note == vm.notes.last { vm.loadMore() }
                        }
                        .listRowInsets(.init())
                }
                .onDelete { offsets in
                    pendingDeleteOffsets = offsets
                    if let first = offsets.first { pendingDelete = vm.notes[first] }
                }
                .listRowSeparator(.hidden)
                .padding(.vertical, 6)
                
                
                if vm.isLoading {
                    HStack {
                        Spacer()
                        ProgressView("Loading more…")
                            .padding(.vertical, 12)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top, 40)
            .listStyle(.plain)
        }
        .alert("Delete this note?",
               isPresented: Binding(get: { pendingDelete != nil || pendingDeleteOffsets != nil },
                                    set: { if !$0 { pendingDelete = nil; pendingDeleteOffsets = nil } })) {
            Button("Delete", role: .destructive) {
                if let note = pendingDelete,
                   let idx = vm.notes.firstIndex(of: note) {
                    vm.delete(at: IndexSet(integer: idx))
                } else if let offsets = pendingDeleteOffsets {
                    vm.delete(at: offsets)
                }
                pendingDelete = nil
                pendingDeleteOffsets = nil
            }
            Button("Cancel", role: .cancel) {
                pendingDelete = nil
                pendingDeleteOffsets = nil
            }
        } message: {
            Text("This action cannot be undone.")
        }
        .padding(.horizontal)
        .onAppear {
            vm.reset()
        }
        .sheet(item: $editing) { note in
            EditNoteView(note: note) { vm.update($0) }
        }
    }
}

private struct NoteRow: View {
    let note: Note
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(note.text)
                .font(.headline)
                .lineLimit(1)
            
            Text(note.createdAt.formatted(date: .abbreviated, time: .shortened))
                .font(.caption)
                .foregroundColor(.secondary)
            
            if let updated = note.updatedAt {
                Text("Edited " + updated.formatted(date: .abbreviated, time: .shortened))
                    .font(.footnote)
                    .foregroundColor(.orange)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 16)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .listRowInsets(.init(top: 0, leading: 12, bottom: 0, trailing: 12))
        
    }
}
