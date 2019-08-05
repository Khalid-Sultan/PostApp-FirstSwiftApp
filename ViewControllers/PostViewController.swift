//
//  PostViewController.swift
//  PostApp
//
//  Created by Admin on 31/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
         
        @IBOutlet weak var usernameTextfield: UITextField!
        @IBOutlet weak var userPostTextfield: UITextField!
        
    
        
        @IBAction func postButton(_ sender: Any) {
            if usernameTextfield.hasText == true && userPostTextfield.hasText == true {
                savePostToFirebaseDatabase()
            } else if usernameTextfield.hasText == false || userPostTextfield.hasText == false {
                Alerts.showAlert(Title: "oops", Message: "You left a textfield empty!", viewControllerToPresentAlert: self)
            }
        }
        
        func savePostToFirebaseDatabase() {
            guard let username = usernameTextfield.text else{ return }
            guard let userPost = userPostTextfield.text else{ return }
            
            
            
            //        guard let postID = Auth.auth().currentUser?. else {
            //            return
            //        }
            
            let postID = NSUUID().uuidString
            let values = ["name": username, "post": userPost] as [String : Any]
            self.registerUsersPostIntoDatabase(postID: postID, values: values as [String : AnyObject])
            
            usernameTextfield.text = ""
            userPostTextfield.text = ""
            
        }
        
        private func registerUsersPostIntoDatabase(postID: String, values: [String:AnyObject] ) {
            let ref = Database.database().reference(fromURL: "https://postapp-e8da6.firebaseio.com/" )
            let userPostRef = ref.child("post").child(postID)
            userPostRef.updateChildValues( values, withCompletionBlock: {
                (err, ref) in
                if err != nil {
                    
                    //this is where we'll write our error alert
                    return
                }
            })
        }
        
    
}
