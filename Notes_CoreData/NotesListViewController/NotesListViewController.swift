//
//  ViewController.swift
//  Notes_CoreData
//
//  Created by Серик Абдиров on 19.07.2022.
//

import UIKit

class NotesListViewController: UICollectionViewController {
    #if DEBUG
    var notes: [Note] = Note.debugNotes
    #endif
    
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = listLayout()

        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistration)

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
