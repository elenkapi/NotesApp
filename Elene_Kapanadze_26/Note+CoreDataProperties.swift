//
//  Note+CoreDataProperties.swift
//  Elene_Kapanadze_26
//
//  Created by Ellen_Kapii on 26.08.22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: Int32
    @NSManaged public var isFavorite: Bool
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var deletedData: Date?

}

extension Note : Identifiable {

}
