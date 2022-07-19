//
//  ViewController.swift
//  Notes_CoreData
//
//  Created by Серик Абдиров on 19.07.2022.
//

import UIKit

class NotesListViewController: UICollectionViewController {

    typealias DataSource = UICollectionViewDiffableDataSource<Int, Note.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Note.ID>

    var notes: [Note] = Note.debugNotes
    var dataSource: DataSource!

    func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(notes.map { $0.id }, toSection: 0)
        dataSource.apply(snapshot)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = listLayout()

        let cellRegistration = UICollectionView.CellRegistration { [self] (cell: UICollectionViewListCell, indexPath: IndexPath, id: Note.ID) in
            let note = note(for: id)
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = note.title
            contentConfiguration.secondaryText = note.date.dayAndTimeText
            cell.contentConfiguration = contentConfiguration
        }

        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Note.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }

        updateSnapshot()

        collectionView.dataSource = dataSource
    }

    func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }

}

extension NotesListViewController {
    func note(for id: Note.ID) -> Note {
        guard let index = notes.firstIndex(where: { $0.id == id}) else {
            fatalError()
        }
        return notes[index]
    }
}
