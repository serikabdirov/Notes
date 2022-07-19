//
//  Model.swift
//  Notes_CoreData
//
//  Created by Серик Абдиров on 19.07.2022.
//

import Foundation

struct Note: Hashable, Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var body: String? = nil
    var date: Date
    var favorite: Bool = false
}

#if DEBUG

extension Note {
    static var debugNotes: [Note] = [
        Note(title: "Title 1", body: "Body 1", date: Date().addingTimeInterval(3600)),
        Note(title: "Title 2", body: "Body 2", date: Date().addingTimeInterval(4800)),
        Note(title: "Title 3", body: "Body 3", date: Date().addingTimeInterval(12300), favorite: true),
        Note(title: "Title 4", body: "Body 4", date: Date().addingTimeInterval(10000)),
        Note(title: "Title 5", body: "Body 5", date: Date().addingTimeInterval(99999), favorite: true),
        Note(title: "Title 6", body: "Body 6", date: Date().addingTimeInterval(80987))
    ]
}
#endif
