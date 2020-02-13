//
//  LoginVC.swift
//  SnapchatClone
//
//  Created by Max Miranda on 9/18/18.
//  Copyright © 2018 ___MaxAMiranda___. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginRegisterSegControl: UISegmentedControl!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginRegisterButton: UIButton!
    
    var ourUserID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 255, g: 254, b: 0)
        loginRegisterSegControl.selectedSegmentIndex = 1
    }
    
    // DEMO FUNCTION 2
    func handleLogin() {
        var email = emailTextField.text!
        var password = passwordTextField.text!
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: password) { (signedInUser, signInError) in
            guard signInError == nil else {
                self.displayAlert(title: "Error", message: signInError.debugDescription)
                return
            }
            guard let user = signedInUser else {
                self.displayAlert(title: "Error", message: "No user")
                return
            }
            self.performSegue(withIdentifier: "toMainFeed", sender: self)
        }
    }
    
    // DEMO FUNCTION 1
    func handleRegister() {
        var name = nameTextField.text!
        var number = phoneNumberTextField.text!
        var email = emailTextField.text!
        var password = passwordTextField.text!
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                self.displayAlert(title: "Error", message: error.debugDescription)
                return
            }
            guard user != nil else {
                self.displayAlert(title: "Error", message: "No user")
                return
            }
            let db = Database.database().reference()
            let usersNode = db.child("Users")
            let newUserId = usersNode.childByAutoId().key
            let userNode = usersNode.child(newUserId!)
            userNode.updateChildValues(["name": name, "email": email, "phoneNumber": number])
            self.performSegue(withIdentifier: "toMainFeed", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        loginRegisterButton.isUserInteractionEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func loginRegisterPressed(_ sender: Any) {
        handleLoginOrRegister()
    }
    
    func handleLoginOrRegister() {
    //loginRegisterButton.isUserInteractionEnabled = false
        if loginRegisterSegControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func handleLoginRegisterChange(_ sender: Any) {
        handleLoginRegisterChange()
    }
    
    func handleLoginRegisterChange() {
        let index = loginRegisterSegControl.selectedSegmentIndex
        let title = loginRegisterSegControl.titleForSegment(at: index)
        loginRegisterButton.setTitle(title, for: UIControl.State())
        
        if title == "Login" {
            nameTextField.isHidden = true
            phoneNumberTextField.isHidden = true
        } else {
            nameTextField.isHidden = false
            phoneNumberTextField.isHidden = false
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
