//
//  DeviceDetailViewController.swift
//  SwiftAssignment_JNJ
//
//  Created by iMac on 11/30/16.
//  Copyright © 2016 Moscova. All rights reserved.
//

import UIKit

class DeviceDetailViewController: UIViewController {

    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceOSLabel: UILabel!
    @IBOutlet weak var deviceManufacturerLabel: UILabel!
    @IBOutlet weak var lastCheckedInLabel: UILabel!
    @IBOutlet weak var checkInOutButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func checkInOrOut(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
