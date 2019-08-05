//
//  SignUpOrLoginViewController.swift
//  PostApp
//
//  Created by Admin on 15/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import UIKit

class SignUpOrLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func goToSignUpPageController(_ sender: Any) {
        Segueways.segueTo(currentViewController: self, destinationViewController: "signUpVC")
    }
    @IBAction func goToLoginPageController(_ sender: Any) {
        Segueways.segueTo(currentViewController: self, destinationViewController: "loginVC")
    }
}
