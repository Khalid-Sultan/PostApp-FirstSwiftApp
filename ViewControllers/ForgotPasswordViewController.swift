//
//  ForgotPasswordViewController.swift
//  PostApp
//
//  Created by Admin on 16/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
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

    @IBAction func sendEmailAction(_ sender: Any) {
        guard let email = emailAddressTextField.text else{ return}
        Auth.auth().sendPasswordReset(withEmail: email){
            (error) in
            if error != nil{
                self.showAlert(title: "Reset Fail", message: "Failed To send password reset link based on the given arguments")
                print("Failed to send password reset link")
                return
            }
            self.showAlert(title: "Reset Success", message: "Successfully sent a password reset link to the given email.")
            print("Successfully sent reset link")
            
        }
    }
    func showAlert(title:String, message: String){
        Alerts.showAlert(Title: "oops", Message: message, viewControllerToPresentAlert: self)

    }

    
    @IBAction func goBackToLoginAction(_ sender: Any) {
      Segueways.segueTo(currentViewController: self, destinationViewController: "loginVC")
    }
}
