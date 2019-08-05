//
//  Post.swift
//  PostApp
//
//  Created by Admin on 31/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import Foundation
struct Post {
    var name: String = ""
    var post: String = ""
    
    
    init(data: [String:Any]) {
        
        if let obj = data["name"] as? String {
            self.name = obj
        }
        if let obj = data["post"] as? String {
            self.post = obj
        }
        
    }
    
}
