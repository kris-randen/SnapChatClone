//
//  LoginViewController.swift
//  Snapchat
//
//  Created by Kris Rajendren on Jun/10/18.
//  Copyright © 2018 House Shout. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    @IBAction func topTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text
        {
            if signupMode
            {
                // Signup
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if let error = error
                    {
                        self.presentAlert(withAlert: error.localizedDescription)
                    }
                    else
                    {
                        print("Signup was successful!")
                    }
                })
            }
            else
            {
                // Login
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                    if let error = error
                    {
                        self.presentAlert(withAlert: error.localizedDescription)
                    }
                    else
                    {
                        print("Login was successful!")
                    }
                })
            }
        }
    }
    
    @IBAction func bottomTapped(_ sender: UIButton) {
        if signupMode
        {
            // Switch to Login
            signupMode = false
            topButton.setTitle("Login", for: .normal)
            bottomButton.setTitle("Switch to Signup", for: .normal)
        }
        else
        {
            // Switch to Signup
            
            signupMode = true
            
            topButton.setTitle("Signup", for: .normal)
            bottomButton.setTitle("Switch to Login", for: .normal)
        }
    }
    
    var signupMode = false
    
    func presentAlert(withAlert alert: String)
    {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

