	//
//  User.swift
//  PostApp
//
//  Created by Admin on 31/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import Foundation
import UIKit
    
struct Users {
        var name: String = ""
        var email: String = ""
        var profileImageUrl: String = ""
        
        init(data: [String:Any]) {
            
            if let obj = data["name"] as? String {
                self.name = obj
            }
            if let obj = data["email"] as? String {
                self.email = obj
            }
            if let obj = data["profileImageUrl"] as? String {
                self.profileImageUrl = obj
            }
        }
        
    }
