//
//  AddDeviceViewController.swift
//  SwiftAssignment_JNJ
//
//  Created by iMac on 12/3/16.
//  Copyright © 2016 Moscova. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class AddDeviceViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var deviceOSTextField: UITextField!
    @IBOutlet weak var deviceManufacturerTextField: UITextField!
    
    @IBOutlet var textFields: [UITextField]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFields()
        self.setupBarButtonItems()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func setupTextFields(){
        for textField in self.textFields{
            textField.delegate = self;
            
        }
    }
    
    
    
    private func validateAdd() -> Bool{
        weak var weakSelf = self
        if((deviceTextField.text?.isEmpty)! == false && (deviceOSTextField.text?.isEmpty)! == false && (deviceManufacturerTextField.text?.isEmpty)!  == false){
            return true;
        }else{
            let alertController = UIAlertController.init(title: "Missing Info", message: "Please Enter the device name, os, AND manufacturer", preferredStyle: .alert)
            let alertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(alertAction)
            
            weakSelf?.present(alertController, animated: true, completion: nil)
            
            return false
        }
    }
    
    private func validateCancel(){
        weak var weakSelf = self
        if( (deviceTextField.text?.isEmpty)! == false || (deviceOSTextField.text?.isEmpty)! == false || (deviceManufacturerTextField.text?.isEmpty)! == false ){
            let alertController = UIAlertController.init(title: "Are you sure?", message: "Some of your device info is filled in. Are you sure you want to cancel?", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert:UIAlertAction!) -> Void in
                weakSelf?.navigationController?.popViewController(animated: true)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(alertAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupBarButtonItems(){
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action:#selector(cancel) )
        let addButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(addDevice))
        
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    
    
    
    @objc private func cancel(){
        self.validateCancel()
    }
    @objc private func addDevice(){
        
        weak var weakSelf = self
        if(self.validateAdd()){
            
            let context = JNJGlobals.devicesObjectContext
            let urlString = JNJConstants.baseURL! + "/devices"
            
            let device = NSEntityDescription.insertNewObject(forEntityName: JNJConstants.deviceEntityName!, into: context!) as! Device
            device.deviceName = deviceTextField.text;
            device.deviceOS = deviceOSTextField.text;
            device.deviceManufacturer = deviceManufacturerTextField.text
            
            let parameters = [
                "device" : device.deviceName ?? "",
                "os"     : device.deviceOS ?? "",
                "manufacturer":device.deviceManufacturer ?? ""
                ] as [String:Any]
            
            Alamofire.request(urlString, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {response in
                
                if let resultValue = response.result.value{
                    let responseDict = resultValue as! NSDictionary
                    device.deviceID = (responseDict.object(forKey: "id") as! Int64?)!
                    device.isCheckedOut = (responseDict.object(forKey:"isCheckedOut") as! Bool?)!
                }
                do{
                    try context?.save()
                }catch{
                    print(error)
                }
                  self.navigationController?.popViewController(animated: true)
                
            })
            
            
            
            
            
        }
    }
    
    
    
    
}
