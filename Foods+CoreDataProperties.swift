//
//  Foods+CoreDataProperties.swift
//  Ios test
//
//  Created by Гарик on 17.10.2022.
//
//

import Foundation
import CoreData


extension Foods {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Foods> {
        return NSFetchRequest<Foods>(entityName: "Foods")
    }
    
    @NSManaged public var sort: Int
    @NSManaged public var productName: String
    @NSManaged public var product: String
    @NSManaged public var descriptionProduct: String
    @NSManaged public var price: String
    @NSManaged public var image: String

}

extension Foods : Identifiable {

}
