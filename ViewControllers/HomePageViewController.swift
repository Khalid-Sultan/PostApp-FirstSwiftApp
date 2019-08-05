//
//  HomePageViewController.swift
//  PostApp
//
//  Created by Admin on 15/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import UIKit
import Firebase

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var users: [Users] = [Users]()
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser?.uid != nil {
            accessAndDisplayUserCridentials()
        }
        login()
        
    }
    
    
    func accessAndDisplayUserCridentials() {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let postID = Auth.auth().currentUser?.uid
        ref.child("user").child(postID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // we're now Getting user value
            
            DispatchQueue.main.async {
                guard let value = snapshot.value as? [String:Any] else {
                    print("error here")
                    return
                }
                
                self.users.append(Users(data: value))
                print(self.users)
                
                self.usernameLabel.text = self.users.first?.name
                self.emailLabel.text = self.users.first?.email
                self.userImage.setImage(from: self.users.first?.profileImageUrl)
            }
        })
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }
        catch _ as NSError {
            //If there is an error while logging out we will present an error here.
            return
        }
        if Auth.auth().currentUser?.uid == nil{
             Segueways.segueTo(currentViewController: self, destinationViewController: "singUpOrLoginVC")
        }
    }
    

    func login(){
        if Auth.auth().currentUser?.uid == nil{
            Segueways.segueTo(currentViewController: self, destinationViewController: "signUpOrLoginVC")        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
