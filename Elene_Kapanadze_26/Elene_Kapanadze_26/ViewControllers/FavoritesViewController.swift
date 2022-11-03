//
//  FavoritesViewController.swift
//  Elene_Kapanadze_26
//
//  Created by Ellen_Kapii on 26.08.22.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    private lazy var favsTableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        return tableView
    }()
    
    
    private var notes = [Note]()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        setUpTableView()
       
    }
    
    
    //MARK: - Config private functions
    
    private func setUp() {
        addFavsTableView()
    }
    
    
    
    private func setUpTableView() {
        favsTableView.delegate = self
        favsTableView.dataSource = self
        favsTableView.register(UINib(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        favsTableView.separatorStyle = .singleLine
        favsTableView.showsVerticalScrollIndicator = false
        favsTableView.backgroundColor = .clear
    }
    
    
    //MARK: - Adding Constraints to views
    
    private func addFavsTableView() {
        
        favsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let topConstraint = NSLayoutConstraint(item: favsTableView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        
        let leftConstraint = NSLayoutConstraint(item: favsTableView,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: favsTableView,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -0)
        
        let bottomConstraint = NSLayoutConstraint(item: favsTableView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -0)
        
        
        NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, leftConstraint])
    }
    
    
    //MARK: - Favorites
    
    private func getFavNotes() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        do {
            let request = Note.fetchRequest()
            request.predicate = NSPredicate(format: "isFavorite == true")
            let notes = try context.fetch(request)
            self.notes = notes
            self.favsTableView.reloadData()
        } catch {
            print("Fetch Failed")
        }
        
        
        
        
    }
    

}

//MARK: - Extensions

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell else { return UITableViewCell() }
        
        let currentNote = self.notes[indexPath.row]
        cell.noteTitle.text = currentNote.title
        cell.noteDescription.text = currentNote.desc
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
    
    
    
    
    
    
}
