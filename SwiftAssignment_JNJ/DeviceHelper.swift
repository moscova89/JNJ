//
//  DeviceHelper.swift
//  SwiftAssignment_JNJ
//
//  Created by iMac on 11/29/16.
//  Copyright © 2016 Moscova. All rights reserved.
//

import Foundation
import CoreData
import CoreFoundation
import Alamofire


class DeviceHelper{
    
    
    static func loadDevicesFromBackendAndStoreInCoreData(){
        
        let context = JNJGlobals.devicesObjectContext
        let urlString = JNJConstants.baseURL! + "/devices"
        Alamofire.request(urlString).responseJSON { (response) in
            
            if let result = response.result.value {
                let arrayOfDevices = result as! Array<NSDictionary>;
                
                for deviceDictionary in arrayOfDevices{
                    let deviceID = deviceDictionary["id"] as! Int
                    if(DeviceHelper.doesDeviceExistInCoreData(deviceID: deviceID)){
                        var device = DeviceHelper.getDeviceWithIDFromCoreData(deviceID: deviceID)
                        //                        device.deviceID = (deviceDictionary.object(forKey: "id") as! Int64?)!
                        //                        device.deviceOS = deviceDictionary.object(forKey: "os") as! String?
                        //                        device.deviceName = deviceDictionary.object(forKey: "device") as! String?
                        //                        device.deviceManufacturer = deviceDictionary.object(forKey: "manufacturer") as! String?
                        //                        device.isCheckedOut = (deviceDictionary.object(forKey:"isCheckedOut") as! Bool?)!
                        //                        device.lastCheckedOutBy = deviceDictionary.object(forKey: "lastCheckedOutBy") as! String?
                        //                        device.lastCheckedOutDate = deviceDictionary.object(forKey: "lastCheckedOutDate") as! String?
                        DeviceHelper.populateDeviceUsingDictionary(device: &device, deviceDictionary: deviceDictionary)
                    }else{
                        var device = NSEntityDescription.insertNewObject(forEntityName: JNJConstants.deviceEntityName!, into: JNJGlobals.devicesObjectContext!) as! Device
                        //                        device.deviceID = (deviceDictionary.object(forKey: "id") as! Int64?)!
                        //                        device.deviceOS = deviceDictionary.object(forKey: "os") as! String?
                        //                        device.deviceName = deviceDictionary.object(forKey: "device") as! String?
                        //                        device.isCheckedOut = (deviceDictionary.object(forKey:"isCheckedOut") as! Bool?)!
                        //                        device.deviceManufacturer = deviceDictionary.object(forKey: "manufacturer") as! String?
                        //                        device.lastCheckedOutBy = deviceDictionary.object(forKey: "lastCheckedOutBy") as! String?
                        //                        device.lastCheckedOutDate = deviceDictionary.object(forKey: "lastCheckedOutDate") as! String?
                        DeviceHelper.populateDeviceUsingDictionary(device: &device, deviceDictionary: deviceDictionary)
                        try? context?.save()
                    }
                    
                    
                    
                    
                }
                
            }
        }
    }
    
    static func doesDeviceExistInCoreData(deviceID: Int) -> Bool{
        let context = JNJGlobals.devicesObjectContext
        
        //        let fetReq = NSFetchRequest<NSFetchRequestResult>(entityName:JNJConstants.deviceEntityName!)
        //        fetReq.predicate = NSPredicate(format: "deviceID = \(deviceID)")
        //        let fetchResults  = context?.fetch(<#T##request: NSFetchRequest<T>##NSFetchRequest<T>#>)
        
        let request: NSFetchRequest<Device> = Device.fetchRequest()
        request.predicate = NSPredicate(format: "deviceID == %i", deviceID)
        
        let deviceCount: Int =  try! (context?.count(for: request))!
        
        if deviceCount > 0 {
            return true
        }else{
            return false
        }
        
    }
    static func getDeviceWithIDFromCoreData(deviceID: Int) -> Device{
        let context = JNJGlobals.devicesObjectContext
        
        var returnDevice : Device?
        let fetReq : NSFetchRequest<Device> = Device.fetchRequest()
        fetReq.predicate = NSPredicate(format: "deviceID == %i", deviceID)
        do{
            let fetRes = try context?.fetch(fetReq)
            
            returnDevice = fetRes?.first
            
        }catch{
            print("Error with fetch Request \(error)")
        }
        
        
        return returnDevice!;
        
    }
    
    static func getAllDevicesFromCoreData() ->[Device]{
        
        let deviceContext = JNJGlobals.devicesObjectContext
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: JNJConstants.deviceEntityName!)
        var deviceArray : [Device]? = nil
        do{
            deviceArray = try deviceContext?.fetch(fetchRequest) as? [Device]
            
            
        }catch{
            print(error)
        }
        return deviceArray!
        
        
    }
    
    static func removeDeviceWithIDFromCoreData(deviceID:Int){
        let context = JNJGlobals.devicesObjectContext
        var deviceToDelete : Device?
        let fetReq : NSFetchRequest<Device> = Device.fetchRequest()
        fetReq.predicate = NSPredicate(format: "deviceID == %i", deviceID)
        do{
            let fetRes = try context?.fetch(fetReq)
            
            deviceToDelete = fetRes?.first
            context?.delete(deviceToDelete!)
        }catch{
            print("Error with deleting context \(error)")
        }
        
        
        
        
    }
    
    
    
    static func populateDeviceUsingDictionary(device: inout Device, deviceDictionary: NSDictionary){
        device.deviceID = (deviceDictionary.object(forKey: "id") as! Int64?)!
        device.deviceOS = deviceDictionary.object(forKey: "os") as! String?
        device.deviceName = deviceDictionary.object(forKey: "device") as! String?
        device.isCheckedOut = (deviceDictionary.object(forKey:"isCheckedOut") as! Bool?)!
        device.deviceManufacturer = deviceDictionary.object(forKey: "manufacturer") as! String?
        device.lastCheckedOutBy = deviceDictionary.object(forKey: "lastCheckedOutBy") as! String?
        device.lastCheckedOutDate = deviceDictionary.object(forKey: "lastCheckedOutDate") as! String?
    }
}
