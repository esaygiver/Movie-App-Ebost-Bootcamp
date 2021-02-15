//
//  FavoritesViewController.swift
//  Esay - Movie App
//
//  Created by admin on 15.02.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {

    private let realm = try! Realm()
    private var favorites = [Favorites]()
    public var completionHandler: (() -> Void)?
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favorites = realm.objects(Favorites.self).map({ $0 })
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.reloadData()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .done, target: self, action: #selector(refreshButtonTapped))

    }
    
//    @objc func refreshButtonTapped(_ sender: UIBarButtonItem) {
//        guard let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
//        vc.completionHandler = { [weak self] in
//            self?.refresh()
//        }
//    }
//
//    func refresh() {
//        favorites = realm.objects(Favorites.self).map({ $0 })
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
}

//MARK: - TableView Delegate & DataSource
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCollectionViewCell", for: indexPath)
        let selectedCell = favorites[indexPath.row]
        cell.textLabel?.text = selectedCell.MovieTitle
        cell.detailTextLabel?.text = selectedCell.MovieRate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
 
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        realm.beginWrite()
        realm.delete(favorites[indexPath.row])
        DispatchQueue.main.async {
            self.favorites.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        try! realm.commitWrite()
    }
    
    
}
