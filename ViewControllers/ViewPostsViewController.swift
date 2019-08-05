//
//  ViewPostsViewController.swift
//  PostApp
//
//  Created by Admin on 31/07/2019.
//  Copyright © 2019 AAiT. All rights reserved.
//

import UIKit
import Firebase

class ViewPostsViewController: UIViewController {
    var post: [Post] = [Post]()
    var scoreCell: UICollectionViewCell?
    @IBOutlet weak var allUsersPostsCollectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAndDisplayUserPosts()
        Timer.scheduledTimer(timeInterval: 00.1, target: self, selector: #selector(ViewPostsViewController.reloadCollectionviewData), userInfo: nil, repeats: true)
    }
    
    
    
    func getPost(at index: Int) -> Post {
        return post [index]
    }
    
    @objc func reloadCollectionviewData () {
        allUsersPostsCollectionView.reloadData()
    }
    
    
    
    func fetchAndDisplayUserPosts() {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.child("post").observe(.childAdded, with: { (snapshot) -> Void in
            
            // we're now Getting post values
            let value = snapshot.value as? [String:Any]
            self.post.append(Post(data: value!))
            self.allUsersPostsCollectionView.reloadData()
            
        })
    }
    
}




extension ViewPostsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (post.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let userPostCell = self.allUsersPostsCollectionView.dequeueReusableCell(withReuseIdentifier: "userPostCell", for: indexPath) as! AllUserPostsCollectionViewCell
        
        let getPost = self.getPost(at: indexPath.row)
        let name = getPost.name
        let post = getPost.post
        
        userPostCell.usernameLabel.text = ("Anonymous User Name: \(name)")
        userPostCell.userPostLabel.text = post
        
        return userPostCell
    }
    
    
 

}
