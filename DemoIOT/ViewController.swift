//
//  ViewController.swift
//  DemoIOT
//
//  Created by Luis on 4/11/17.
//  Copyright © 2017 Luis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        led(state: "OFF")
        view.backgroundColor = UIColor.red
        addEvent()
    }
    
    

    @IBAction func OnViewTapped(_ sender: UITapGestureRecognizer) {
        if view.backgroundColor == UIColor.red {
            led(state: "ON")
            view.backgroundColor = UIColor.green
        } else {
            led(state: "OFF")
            view.backgroundColor = UIColor.red
        }
    }
    
    func changeColor(state: String) {
        switch state {
        case "ON":
            view.backgroundColor = UIColor.green
        case "OFF":
            view.backgroundColor = UIColor.red
        default:
            break
        }
    
    }
    
    func led(state: String) {
        let ref = FIRDatabase.database().reference()
        let post : [String:AnyObject] = ["state": state as AnyObject]
        ref.child("led").setValue(post)
        
        
        
    }
    
    func addEvent() {
            let ref = FIRDatabase.database().reference()
        
        ref.observe(FIRDataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            let state = postDict["led"] as? [String : String]
            let change = state?["state"]!
            DispatchQueue.main.async {
                self.changeColor(state: change!)
            }
            
            
            
        })
    }
    
    
}

