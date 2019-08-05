//
//  Segueways.swift
//  PostApp
//
//  Created by Admin on 31/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import Foundation
import UIKit
class Segueways{
    static func segueTo(currentViewController: UIViewController, destinationViewController: String?) {
        let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(destinationViewController!)")
        currentViewController.present(destinationVC, animated: true, completion: nil)
    }
}
