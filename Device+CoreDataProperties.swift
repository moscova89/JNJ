//
//  Device+CoreDataProperties.swift
//  
//
//  Created by iMac on 11/29/16.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device");
    }

    @NSManaged public var deviceID: Int64
    @NSManaged public var deviceManufacturer: String?
    @NSManaged public var deviceName: String?
    @NSManaged public var deviceOS: String?
    @NSManaged public var isCheckedOut: Bool
    @NSManaged public var lastCheckedOutBy: String?
    @NSManaged public var lastCheckedOutDate: String?

}
