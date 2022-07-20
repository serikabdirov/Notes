//
//  NoteListViewController+Section.swift
//  Notes_CoreData
//
//  Created by Серик Абдиров on 20.07.2022.
//

import Foundation

extension NotesListViewController {
    enum Section: Int, Hashable {
        case all
        case favorite

        var name: String {
            switch self {
            case .all: return ""
            case .favorite: return "Favorite"
            }
        }
    }
}
