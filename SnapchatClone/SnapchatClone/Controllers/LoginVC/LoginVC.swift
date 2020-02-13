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
    var logoImageView: UIImageView!
    var loginRegisterSegControl: UISegmentedControl!
    
    var nameTextField: UITextField!
    var phoneNumberTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    var loginRegisterButton: UIButton!
    
    var ourUserID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 255, g: 254, b: 0)
        setupLogo()
        setupSegControl()
        setupLoginRegisterButton()
        setupTextFields()
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
    
    @objc func handleLoginOrRegister() {
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
    
    @objc func handleLoginRegisterChange() {
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
