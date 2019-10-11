//
//  NavigateViewController.swift
//  TestProject
//
//  Created by ugur on 12.10.2019.
//  Copyright © 2019 ugur. All rights reserved.
//

import UIKit

class NavigateViewController: UIViewController {

    var reachability:Reachability?
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showAlertMessage(message: "Internet is not Available")
    }
    
     
    @IBAction func checkConnection(_ sender: UIButton) {
        
        do {
            self.reachability = try? Reachability.init()
            
            if((self.reachability!.connection) != .unavailable){
                print("internet available")
                
               showMainConroller()
                
            }else{
                
              showAlertMessage(message: " internet connection is still continue, check your connection")
                
                
            }
            
        }
        
    }
    

    func showAlertMessage(message:String){
        
        let alert = UIAlertController(title: "Internet Problem", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func  showMainConroller() {
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "mainscreen") as UIViewController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = initialViewControlleripad
        window?.makeKeyAndVisible()
    }

}
