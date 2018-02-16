//
//  MissWords+CoreDataProperties.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/02/15.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//
//

import Foundation
import CoreData


extension MissWords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MissWords> {
        return NSFetchRequest<MissWords>(entityName: "MissWords")
    }

    @NSManaged public var word: String?

}
