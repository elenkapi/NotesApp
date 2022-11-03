//
//  NoteCell.swift
//  Elene_Kapanadze_26
//
//  Created by Ellen_Kapii on 26.08.22.
//

import UIKit
import CoreData


public var starHasTapped = true

class NoteCell: UITableViewCell {
    
    var note: Note?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteDescription: UILabel!
    
    
    @IBOutlet weak var starIcon: UIButton!
    
    
    var link: NotesViewController!
    var selectedNote: Note? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    
    
  
    @IBAction func addToFavs(_ sender: UIButton) {
//        if starHasTapped {
//    
//        starIcon.tintColor = .yellow
//            starHasTapped = false
//        
//        } else {
//            starIcon.tintColor = .systemGray4
//            starHasTapped = true
//        }
        
        //link.markAsFav(cell: self)
        
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//
//        do {
//            let results: NSArray = try context.fetch(request) as NSArray
//            try results.forEach { result in
//                let note = result as! Note
//                if note == selectedNote {
//
//                    note.isFavorite = true
//
//                    try context.save()
//
//                    // navigate to previous view controller
//
//                }
//            }
//
//        } catch {
//            print("Fetch Failed")
//        }
        
        
    }
    
    
    
}
