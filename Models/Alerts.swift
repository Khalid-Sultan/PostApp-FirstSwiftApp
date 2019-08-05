//
//  Alerts.swift
//  PostApp
//
//  Created by Admin on 31/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import Foundation
import UIKit

class Alerts {
    
   static func showAlert(Title: String, Message: String, viewControllerToPresentAlert: UIViewController) {
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        viewControllerToPresentAlert.present(alert, animated: true, completion: nil)
        
    }
    
    
}
