//
//  ViewController.swift
//  CustomEmailLogin
//
//  Created by David Thurman on 8/25/17.
//  Copyright © 2017 David Thurman. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInAction(_ sender: Any) {
        
        if let email = emailTextField.text, let pass = passwordTextField.text {
            if isSignIn {
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                    
                    //Check that user isnt nil
                    if let u = user {
                        //User is found, go to home screen
                        self.performSegue(withIdentifier: "gotohome", sender: self)
                    }
                    else {
                        //Error: check error and show message
                    }
                })
            }
            else {
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    if let u = user {
                        print("TEST1")
                        //Registered successfully
                        self.performSegue(withIdentifier: "gotohome", sender: self)
                    }
                    else {
                        print("TEST2")
                        //Error: check error and show message
                        print(error)
                    }
                }
            }
        }

    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        isSignIn = !isSignIn
        
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}

