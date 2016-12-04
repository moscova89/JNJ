//
//  AddDeviceViewController.swift
//  SwiftAssignment_JNJ
//
//  Created by iMac on 12/3/16.
//  Copyright © 2016 Moscova. All rights reserved.
//

import UIKit

class AddDeviceViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var deviceOSTextField: UITextField!
    @IBOutlet weak var deviceManufacturerTextField: UITextField!
    
    @IBOutlet var textFields: [UITextField]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFields()

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
        if((deviceTextField.text?.isEmpty)! && (deviceOSTextField.text?.isEmpty)! && (deviceManufacturerTextField.text?.isEmpty)! ){
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
        if((deviceTextField.text?.isEmpty)! || (deviceOSTextField.text?.isEmpty)! || (deviceManufacturerTextField.text?.isEmpty)! ){
            let alertController = UIAlertController.init(title: "Are you sure?", message: "Some of your device info is filled in. Are you sure you want to cancel?", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert:UIAlertAction!) -> Void in
                
            })
            
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }else{
        }
    }

}
