//
//  DeviceDetailViewController.swift
//  SwiftAssignment_JNJ
//
//  Created by iMac on 11/30/16.
//  Copyright © 2016 Moscova. All rights reserved.
//

import UIKit
import Alamofire

class DeviceDetailViewController: UIViewController {
    
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceOSLabel: UILabel!
    @IBOutlet weak var deviceManufacturerLabel: UILabel!
    @IBOutlet weak var lastCheckedInLabel: UILabel!
    @IBOutlet weak var checkInOutButton: UIButton!
    
    weak var currentDevice : Device?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateLabels()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.updateLabels()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func checkInOrOut(_ sender: Any) {
        if (self.currentDevice?.isCheckedOut == true) {
            self.checkIn()
        }else{
            self.checkOut()
        }
    }
    
    // MARK: - private functions
    private func setButtonText() {
        switch currentDevice?.isCheckedOut {
        case true?:
            checkInOutButton.setTitle("Check In", for: UIControlState.normal)
            break
        case false?:
            checkInOutButton.setTitle("Check Out", for: UIControlState.normal)
            break
            
        default: break
        }
    }
    
    // MARK: - checkIn
    private func checkIn(){
        weak var weakSelf = self
        let alertController = UIAlertController.init(title: "Check In", message: nil, preferredStyle: .alert)
        
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert:UIAlertAction!) -> Void in
            weakSelf?.currentDevice?.isCheckedOut = false;
            weakSelf?.checkInOnNetwork()
            weakSelf?.updateLabels();
            do{
                try JNJGlobals.devicesObjectContext?.save()
            }catch{
                print(error)
            }
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
    }
    
    
    private func checkInOnNetwork() {
        let urlString = JNJConstants.baseURL! + "/devices/\(currentDevice?.deviceID)"
        
        let parameters = [
            "isCheckedOut":false
            
            ] as [String : Any]
        
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {response in
            print(response)
        })
        
    }
    
    
    // MARK: - checkOut
    private func checkOut(){
        
        weak var weakSelf = self
        let alertController = UIAlertController.init(title: "Check Out", message: "Please Enter your name", preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField!) in
            textField.placeholder = "Name";
        }
        
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert:UIAlertAction!) -> Void in
            weakSelf?.currentDevice?.isCheckedOut = true;
            weakSelf?.currentDevice?.lastCheckedOutBy = alertController.textFields?.first?.text
            weakSelf?.updateLabels();
            do{
                weakSelf?.checkOutOnNetwork(name: weakSelf?.currentDevice?.lastCheckedOutBy)
                try JNJGlobals.devicesObjectContext?.save()
            }catch{
                print(error)
            }
            
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        
    }
    
    private func checkOutOnNetwork(name:String?){
        let dateString = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.full, timeStyle: DateFormatter.Style.full)
        let urlString = JNJConstants.baseURL! + "/devices/\(currentDevice?.deviceID)"
        
        let parameters = [
            "lastCheckedOutDate":dateString,
            "lastCheckedOutBy":name!,
            "isCheckedOut":true
            
            ] as [String : Any]
        
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {response in
            print(response)
        })
        
        
        
    }
    
    
    private func updateLabels(){
        deviceNameLabel.text = "Device Name: \((currentDevice?.deviceName)!) "
        deviceOSLabel.text = "OS: \((currentDevice?.deviceOS)!)"
        deviceManufacturerLabel.text = "Manufacturer: \((currentDevice?.deviceManufacturer)!)"
        if currentDevice?.isCheckedOut == true {
            lastCheckedInLabel.isHidden = false
            lastCheckedInLabel.text  = "Last Checked Out: \((currentDevice?.lastCheckedOutBy)!) on \((currentDevice?.lastCheckedOutDate)!)"
        }else{
            lastCheckedInLabel.isHidden = true
        }
    }
    
    
    
}
