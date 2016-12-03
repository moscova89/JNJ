//
//  ViewController.swift
//  SwiftAssignment_JNJ
//
//  Created by iMac on 11/27/16.
//  Copyright © 2016 Moscova. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableview: UITableView?
    private static let cellID : String? = "cellID"
    
    private var _devices : [Device]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.getDevicesFromCoreData()
        tableview?.delegate = self
        tableview?.dataSource = self
        
        tableview?.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.cellID!)
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDevicesFromCoreData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // MARK: - UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _devices!.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let device = _devices?[indexPath.row]
        
        let cell : UITableViewCell =  tableview!.dequeueReusableCell(withIdentifier: ViewController.cellID!)!
        
        cell.textLabel?.text = (device?.deviceName)! + " - " + (device?.deviceOS)!
        if(device?.isCheckedOut)!{
            cell.detailTextLabel?.text = "Device Last Checked out by \(device?.lastCheckedOutBy)"
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let device = _devices?[indexPath.row]
        
        let ddv : DeviceDetailViewController = DeviceDetailViewController()
        
        ddv.currentDevice = device
        
        self.navigationController?.pushViewController(ddv, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
    
    @IBAction func addDevice(_ sender: Any) {
    }
    // MARK - helper functions
    
    private func getDevicesFromCoreData()   {
        
        let deviceContext = JNJGlobals.devicesObjectContext
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: JNJConstants.deviceEntityName!)
       
        do{
             _devices = try deviceContext?.fetch(fetchRequest) as? [Device]
            
            
            
            
        }catch{
            print(error)
        }
        
       
        
    }
    
    


}

