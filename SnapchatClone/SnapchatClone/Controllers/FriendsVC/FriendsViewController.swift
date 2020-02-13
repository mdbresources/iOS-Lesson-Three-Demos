//
//  FriendsViewController.swift
//  SnapchatClone
//
//  Created by Max Miranda on 9/20/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import Firebase

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var friendsList: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsList = []
        setupFriendsList()
        // Do any additional setup after loading the view.
    }
    
    // DEMO FUNCTION 4
    func setupFriendsList() {
        let ref = Database.database().reference()
        let userRef = ref.child("Users")
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let usersDict = snapshot.value as? [String: [String: String]] else {
                print("friends error")
                return
            }
            for (userId, _) in usersDict {
                guard let userInfoDict = usersDict[userId] else {
                    print("friends error 2")
                    continue
                }
                print(userInfoDict["name"]!)
                self.friendsList.append(userInfoDict["name"]!)
            }
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = UIColor(r: 0, g: 188, b: 255)
    }
}
