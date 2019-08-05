//
//  UIImageExtensions.swift
//  PostApp
//
//  Created by Admin on 31/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(from urlAddress: String?) {
        guard let urlAddress = urlAddress,
            let url = URL(string: urlAddress) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
        
    }
}
