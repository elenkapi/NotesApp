//
//  AddNoteViewController.swift
//  Elene_Kapanadze_26
//
//  Created by Ellen_Kapii on 26.08.22.
//

import UIKit
import CoreData

// add or edit viewcontroller

class AddNoteViewController: UIViewController {
    
    private lazy var titleField: UITextField = {
        let titleField = UITextField()
        
        titleField.attributedPlaceholder = NSAttributedString(string: " Title",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        
        titleField.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.2)
        titleField.returnKeyType = .next
        titleField.autocorrectionType = .no
        titleField.layer.cornerRadius = 5
        view.addSubview(titleField)
        return titleField
    }()
    
    private lazy var descriptionField: UITextView = {
        let descriptionField = UITextView()
        descriptionField.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.2)
        descriptionField.layer.cornerRadius = 5
        descriptionField.autocorrectionType = .no
        view.addSubview(descriptionField)
        return descriptionField
    }()
    
    lazy var delNote: UIButton = {
       let deleteNote = UIButton()
        deleteNote.setTitle("Delete Note", for: .normal)
        deleteNote.setTitleColor(UIColor.systemRed, for: .normal)
        deleteNote.backgroundColor = .clear
        view.addSubview(deleteNote)
        return deleteNote
    }()
    
    var selectedNote: Note? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        canEditNote()
        saveNote()
        deleteNote()
        
    }
    
    //MARK: - Config private func
    
    private func setUp() {
        addTitleField()
        addDescriptionField()
        addDelNote()
        
    }
    
    private func canEditNote() {
        
        if selectedNote != nil {
            titleField.text = selectedNote?.title
            descriptionField.text = selectedNote?.desc
        }
        
        
    }
    
    
    
    //MARK: - Adding constraints to views
    
    private func addTitleField() {
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: titleField,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 20)
        
        let leftConstraint = NSLayoutConstraint(item: titleField,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 10)
        
        let rightConstraint = NSLayoutConstraint(item: titleField,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -10)
        
        let height = NSLayoutConstraint(item: titleField,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: 60)
        
        NSLayoutConstraint.activate([topConstraint, rightConstraint, height, leftConstraint])
        
    }
    
    private func addDescriptionField() {
        
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: descriptionField,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: titleField,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 20)
        
        let leftConstraint = NSLayoutConstraint(item: descriptionField,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 10)
        
        let rightConstraint = NSLayoutConstraint(item: descriptionField,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -10)
        
        let bottomConstraint = NSLayoutConstraint(item: descriptionField,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view.safeAreaLayoutGuide,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -100)
        
        NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, leftConstraint])
        
    }
    
    private func addDelNote() {
        
        delNote.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: delNote,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: descriptionField,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 20)
        
        let leftConstraint = NSLayoutConstraint(item: delNote,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 100)
        
        let rightConstraint = NSLayoutConstraint(item: delNote,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -100)
        
        let height = NSLayoutConstraint(item: delNote,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: 30)
        
        NSLayoutConstraint.activate([topConstraint, rightConstraint, height, leftConstraint])
        
    }
    
    
    
    //MARK: -  Save Note
    
    private func saveNote() {
        navigationItem.rightBarButtonItem = UIBarButtonItem( barButtonSystemItem: .save, target: self,action: #selector(saveNotesTapped))
    }
    
    
    
    @objc private func saveNotesTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        
        if selectedNote == nil {
            
            // save note
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            let newNote = Note(entity: entity!, insertInto: context)
            
            newNote.title = titleField.text
            newNote.desc = descriptionField.text
            
            do {
                try context.save()
                notes.append(newNote)
                
                // navigate to previous view controller
                self.navigationController?.popViewController(animated: true)
                
            } catch {
                print("Context save error")
            }
        } else { // edit note
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                try results.forEach { result in
                    let note = result as! Note
                    if note == selectedNote {
                        note.title = titleField.text
                        note.desc = descriptionField.text
                        try context.save()
                        
                        // navigate to previous view controller
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
            } catch {
                print("Fetch Failed")
            }
        }
        
    }
    
    //MARK: - Delete note
    
    private func deleteNote() {
        
        delNote.addTarget(self, action: #selector(deleteNoteTapped), for: .touchUpInside)
        
    }
    
    @objc private func deleteNoteTapped() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            try results.forEach { result in
                let note = result as! Note
                if note == selectedNote {
                    
                    note.deletedData = Date()
                    
                    try context.save()
                    
                    // navigate to previous view controller
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        } catch {
            print("Fetch Failed")
        }
        
    }
    
    
}
