//
//  SignUpViewController.swift
//  PostApp
//
//  Created by Admin on 15/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
ImagePicker.addGestureRecognizer(UITapGestureRecognizer(
    target:self, action: #selector (handleTheSelectedProfileImage)
))
        // Do any additional setup after loading the view.
    }
    
    @objc func handleTheSelectedProfileImage(){

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated:true, completion:nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        var selectedImageFromThePicker: UIImage?
        if let editedProfileImage = info[.editedImage] as? UIImage{
            selectedImageFromThePicker = editedProfileImage
            self.ImagePicker.image = selectedImageFromThePicker!
            dismiss(animated: true, completion: nil)
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImageFromThePicker = originalImage
            self.ImagePicker.image = selectedImageFromThePicker!
            dismiss(animated:true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var ImagePicker: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func registerAction(_ sender: Any) {
        signUpRegister()
    }
    
    func signUpRegister(){
        guard let username = nameTextField.text else { return}
        guard let email = emailTextField.text else { return}
        guard let password = passwordTextField.text else { return}
        
        Auth.auth().createUser(withEmail: email, password: password, completion:
            {(authResult, error) in
            if error != nil {
                //this is where we'll write our error alert due to authentication part
                self.showAlert(title: "Authentication Failed In Authentication", message: "Failed To Register user with the given arguments")
                print("Error while adding authentication")
                return
	
            }
            guard let uid = authResult?.user.uid else{ return }
                
            var imageName = NSUUID().uuidString
            let store = Storage.storage().reference().child("ProfileImages").child("PI-\(imageName).png")
	
                if let uploadData = self.ImagePicker
                .image!.pngData(){
                store.putData(uploadData, metadata: nil, completion: {
                    (metadata, error) in
                    
                    if error != nil {
                        //Failed to save profile picture
                        print("Failed to save profile picture")
                        return
                    }
                    
                    store.downloadURL(completion: { (url, error) in
                        
                        if error != nil {
                            print(error!.localizedDescription)
                            return
                        }
                        if let profileImageUrl = url?.absoluteString {
                            let values = ["name":username, "email":email, "profileImageURL":profileImageUrl] as [String: Any]
                            self.addUserToDatabase(uid: uid, values: values as [String: AnyObject])
                        }
                    })
                    
                })
            }
        })
    }

    func addUserToDatabase(uid: String, values:[String: AnyObject]){
        guard let email = emailTextField.text else { return}
        guard let password = passwordTextField.text else { return}
        let ref = Database.database().reference(fromURL: "https://postapp-e8da6.firebaseio.com/")
        let userReference = ref.child("user").child(uid)
        userReference.updateChildValues(values, withCompletionBlock:{
            (err, ref) in
            if err != nil{
                //this is where we'll write our error alert due to realtime database part
                self.showAlert(title: "Authentication Failed In Database", message: "Failed To Register user with the given arguments.")
                print("Error while Adding To Database")
                return
            }
            Auth.auth().signIn(withEmail: email, password: password, completion: {
                (user, error) in
                if error != nil{
                    //this is where we'll write our error alert due to failed login attempt'
                    self.showAlert(title: "Login Failed ", message: "Failed To Login user with the given arguments.")
                    print("Error while Logging in")
                    return
                }
                self.goToHomePage()
            })
        })
    }
    func showAlert(title:String, message: String){
        Alerts.showAlert(Title: title, Message: message, viewControllerToPresentAlert: self)
	
    }
    
    func goToHomePage(){
         Segueways.segueTo(currentViewController: self, destinationViewController: "tabBarController")
        
    }
    
    @IBAction func goBackToLoginAction(_ sender: Any) {
         Segueways.segueTo(currentViewController: self, destinationViewController: "loginVC")
    }
}
