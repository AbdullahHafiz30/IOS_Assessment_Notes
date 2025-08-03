//
//  AddNoteViewModel.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 01/08/2025.
//


import SwiftUI
import CoreData

@MainActor
final class AddNoteViewModel: ObservableObject {
    @Published var text = ""
    @Published private(set) var timestamp: Date?
    @Published private(set) var isBusy = false
    @Published var alert: String?
    
    var canSave: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var repo = CoreDataNotesRepository()
    private var timeSvc = TimeService()
    
    private let pollInterval: UInt64 = 1
    private var pollTask: Task<Void, Never>?
    
    init(repo: CoreDataNotesRepository = .init(),
         timeSvc: TimeService = .init()) {
        self.repo    = repo
        self.timeSvc = timeSvc
        startPolling()
    }
    
    deinit { pollTask?.cancel() }
    
    private func startPolling() {
        pollTask = Task.detached { [weak self] in
            guard let self else { return }
            while !Task.isCancelled {
                do {
                    let newDate = try await self.timeSvc.current()
                    await MainActor.run {
                        self.timestamp = newDate
                        self.isBusy    = false
                    }
                } catch {
                    await MainActor.run { self.alert = error.localizedDescription }
                }
                try? await Task.sleep(for: .seconds(self.pollInterval))
            }
        }
    }
    
    
    func refreshTime() async {
        isBusy = true
        defer { isBusy = false }
        do {
            timestamp = try await timeSvc.current()
        } catch {
            alert = "Couldn’t fetch time – using device clock"
            timestamp = Date()
        }
    }
    
    func save() async {
        guard canSave else {
            alert = "Please type something before saving."
            return
        }
        
        isBusy = true
        defer { isBusy = false }
        
        let now = timestamp ?? Date()
        do {
            try repo.insert(.new(text: text, at: now))
            text = ""
            await refreshTime()
        } catch {
            alert = "Save failed: \(error.localizedDescription)"
        }
    }
}

