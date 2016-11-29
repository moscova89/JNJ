//
//  Device+CoreDataProperties.swift
//  SwiftAssignment_JNJ
//
//  Created by iMac on 11/29/16.
//  Copyright © 2016 Moscova. All rights reserved.
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device");
    }

    @NSManaged public var deviceID: String?
    @NSManaged public var deviceName: String?
    @NSManaged public var deviceOS: String?
    @NSManaged public var deviceManufacturer: String?
    @NSManaged public var lastCheckedOutDate: NSDate?
    @NSManaged public var lastCheckedOutBy: String?
    @NSManaged public var isCheckedOut: Bool

}
