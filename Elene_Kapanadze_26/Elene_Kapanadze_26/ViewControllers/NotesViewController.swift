//
//  ViewController.swift
//  Elene_Kapanadze_26
//
//  Created by Ellen_Kapii on 26.08.22.
//

import UIKit
import CoreData

//MARK: - Public Variables

public var notes = [Note]()

class NotesViewController: UIViewController {
    
    // returns an array of nondeleted notes
   private func nonDeletedNotes() -> [Note] {
        
        var nonDeletedNotes = [Note]()
        notes.forEach { note in
            if note.deletedData == nil {
                nonDeletedNotes.append(note)
            }
        }
        return nonDeletedNotes
        
    }
    
    
    var firsLoad = true
    
    
    private lazy var notesTableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveData()
        
        setup()
        setUpTableView()
        addNotes()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        notesTableView.reloadData()
    }
    
    //MARK: - Config private functions
    
    private func setup() {
        addNotesTableView()
    }
    
    private func setUpTableView() {
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.register(UINib(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        notesTableView.separatorStyle = .singleLine
        notesTableView.showsVerticalScrollIndicator = false
        notesTableView.backgroundColor = .clear
    }
    
    
    
    //MARK: -  Add Notes
    
    private func addNotes() {
        navigationItem.rightBarButtonItem = UIBarButtonItem( barButtonSystemItem: .add, target: self,action: #selector(addNotesTapped))
    }
    
    
    
    @objc private func addNotesTapped() {
        
        // navigate to add view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController else { return }
        
        vc.delNote.isHidden = true
        
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: - Adding constraints to views
    
    private func addNotesTableView() {
        
        notesTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let topConstraint = NSLayoutConstraint(item: notesTableView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        
        let leftConstraint = NSLayoutConstraint(item: notesTableView,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 0)
        
        let rightConstraint = NSLayoutConstraint(item: notesTableView,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -0)
        
        let bottomConstraint = NSLayoutConstraint(item: notesTableView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -0)
        
        
        NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, leftConstraint])
    }
    
    //MARK: - data persistent private functions
    
    private func saveData() {
      
        if firsLoad {
            firsLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                results.forEach { result in
                    let note = result as! Note
                    notes.append(note)
                }
                
            } catch {
                print("Fetch Failed")
            }
        }
        
        
    }
    
    
    //MARK: - mark note as favorite
    func markAsFav(cell: NoteCell) {

        let indexpath =  notesTableView.indexPath(for: cell)
        let currentNote = notes[indexpath!.row]

        currentNote.isFavorite = true
        notesTableView.reloadData()

        
        if starHasTapped {
    
            cell.starIcon.tintColor = .yellow
            starHasTapped = false
        
        } else {
            cell.starIcon.tintColor = .systemGray4
            starHasTapped = true
        }
        
        

        
        
        

//        cell.noteTitle.text = currentNote.title
//        cell.noteDescription.text = currentNote.desc



    }
}

//MARK: - Extensions

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nonDeletedNotes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell else { return UITableViewCell() }
        cell.link = self
        
        let currentNote = nonDeletedNotes()[indexPath.row]
        cell.noteTitle.text = currentNote.title
        cell.noteDescription.text = currentNote.desc
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.performSegue(withIdentifier: "noteDetails", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "noteDetails" {
            let indexpath = notesTableView.indexPathForSelectedRow!
            let noteDetail = segue.destination as? AddNoteViewController
            noteDetail?.title = "Note Details"
            let selectedNote = nonDeletedNotes()[indexpath.row]
            
            noteDetail?.selectedNote = selectedNote
            
            notesTableView.deselectRow(at: indexpath, animated: true)
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
    
}

