//
//  NotesRepository.swift
//  IOS_Assessment_Notes
//
//  Created by Abdullah Hafiz on 01/08/2025.
//


import CoreData

protocol NotesRepository {
    func insert(_ note: Note) throws
    func update(_ note: Note) throws
    func delete(id: UUID) throws
    func fetch(limit: Int, offset: Int) throws -> [Note]
    var totalCount: Int { get throws }
}

final class CoreDataNotesRepository: NotesRepository {
    private let ctx: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        ctx = context
    }
    
    func insert(_ note: Note) throws {
        try ctx.performAndWait {
            let entity = NoteEntity(context: ctx)
            entity.fill(from: note)
            try ctx.save()
        }
    }
    
    func update(_ note: Note) throws {
        try ctx.performAndWait {
            if let e = try find(id: note.id) {
                e.text      = note.text
                e.updatedAt = Date()
                try ctx.save()
            }
        }
    }
    
    func delete(id: UUID) throws {
        try ctx.performAndWait {
            if let e = try find(id: id) {
                ctx.delete(e)
                try ctx.save()
            }
        }
    }
    
    func fetch(limit: Int, offset: Int) throws -> [Note] {
        let req: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        req.fetchLimit      = limit
        req.fetchOffset     = offset
        req.sortDescriptors = [.init(key: "createdAt", ascending: false)]
        return try ctx.fetch(req).map { $0.toModel() }
    }
    
    var totalCount: Int {
        (try? ctx.count(for: NoteEntity.fetchRequest())) ?? 0
    }
    
    private func find(id: UUID) throws -> NoteEntity? {
        let r: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        r.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        r.fetchLimit = 1
        return try ctx.fetch(r).first
    }
    
    func latest() throws -> Note? {
        var result: Note?
        try ctx.performAndWait {
            let req: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
            req.sortDescriptors = [.init(key: #keyPath(NoteEntity.createdAt), ascending: false)]
            req.fetchLimit = 1
            result = try ctx.fetch(req).first?.toModel()
        }
        return result
    }
}
