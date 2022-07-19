//
//  NotesListViewController+DataSource.swift
//  Notes_CoreData
//
//  Created by Серик Абдиров on 19.07.2022.
//

import UIKit

extension NotesListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Note.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Note.ID>

    func updateSnapshot(reloading ids: [Note.ID] = []) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(notes.map { $0.id }, toSection: 0)
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
        }
        dataSource.apply(snapshot)
    }

    func cellRegistration(cell: UICollectionViewListCell, indexPath: IndexPath, id: Note.ID) {
        let note = get(for: id)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = note.title
        contentConfiguration.secondaryText = note.date.dayAndTimeText
        cell.contentConfiguration = contentConfiguration

        let doneButtonConfiguration = favoriteButtonConfiguration(for: note)
        cell.accessories = [ .customView(configuration: doneButtonConfiguration) ]
    }

    func favoriteButtonConfiguration(for note: Note) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = note.favorite ? "star.fill" : "star"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = FavoriteButton()
        button.id = note.id
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didPressedFavoriteButton), for: .touchUpInside)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }

    @objc func didPressedFavoriteButton(_ sender: FavoriteButton) {
        guard let id = sender.id else {
            return
        }
        changeFavorite(for: id)
    }

    func changeFavorite(for id: Note.ID) {
        var note = get(for: id)
        note.favorite.toggle()
        update(note, for: id)
        updateSnapshot(reloading: [id])
    }

    func get(for id: Note.ID) -> Note {
        guard let index = notes.firstIndex(where: { $0.id == id}) else {
            fatalError()
        }
        return notes[index]
    }

    func update(_ note: Note, for id: Note.ID) {
        guard let index = notes.firstIndex(where: { $0.id == id}) else {
            fatalError()
        }
        notes[index] = note
    }
}
