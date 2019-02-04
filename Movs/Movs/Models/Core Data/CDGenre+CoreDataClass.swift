//
//  CDGenre+CoreDataClass.swift
//  Movs
//
//  Created by Brendoon Ryos on 03/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CDGenre)
public class CDGenre: NSManagedObject {

  convenience init(id: Int, name: String, context: NSManagedObjectContext) {
    let newMovie = NSEntityDescription.entity(forEntityName: "CDGenre", in: context)!
    self.init(entity: newMovie, insertInto: context)
    self.id = Int32(id)
    self.name = name
  }
}
