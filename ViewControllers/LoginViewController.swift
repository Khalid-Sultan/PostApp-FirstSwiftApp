//
//  LoginViewController.swift
//  PostApp
//
//  Created by Admin on 15/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email = emailTextField.text else { return}
        guard let password = passwordTextField.text else { return}
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            (user, error) in
            if error != nil{
                //this is where we'll write our error alert due to failed login attempt
                self.showAlert(title: "Login Failed", message: "Failed To Login user with the given arguments.")
                print("Error while logging in directly")
                return
            }
            self.goToHomePage()
        })
    }
    func showAlert(title:String, message: String){
        Alerts.showAlert(Title: "oops", Message: message, viewControllerToPresentAlert: self)
    }
    func goToHomePage(){
        
        Segueways.segueTo(currentViewController: self, destinationViewController: "tabBarController")
    }
    
    @IBAction func goBackToSignUpPageAction(_ sender: Any) {
        Segueways.segueTo(currentViewController: self, destinationViewController: "signUpVC")
    }
    @IBAction func forgotPasswordAction(_ sender: Any) {
        
        Segueways.segueTo(currentViewController: self, destinationViewController: "forgotPasswordVC")
        
    }
}
