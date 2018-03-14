//
//  LoginViewController.swift
//  KitchenSink
//
//  Created by Elle Ti on 2018-03-07.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var emailTextField: UITextField!
    var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow

        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialSetup() {
        let titleLabel = UILabel()
        titleLabel.text = "Welcome. Please enter your email & password"
        titleLabel.textColor = .purple
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 24.0).isActive = true
        
        nameTextField = UITextField()
//        nameTextField.placeholder = "Name"
        nameTextField.text = "Gwen"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40.0).isActive = true
        nameTextField.autocorrectionType = .no
        
        emailTextField = UITextField()
//        emailTextField.placeholder = "Email"
        emailTextField.text = "gwen@gwen.com"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20.0).isActive = true
        emailTextField.autocorrectionType = .no
        
//        let passwordTextField = UITextField()
//        passwordTextField.placeholder = "Password"
//        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(passwordTextField)
//        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        passwordTextField.autocorrectionType = .no
        
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.purple, for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 221.0).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        loginButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24.0).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func loginButtonTapped() {
        guard let email = emailTextField.text, let name = nameTextField.text else { return }
        
        let manager = APIManager()
        manager.createUser { (error) in
            DispatchQueue.main.async {
                if let _ = error {
                    print("Error occured creating user")
                }
                else {
                    manager.saveEmail(email: email, completion: { (info, emailError) in
                        DispatchQueue.main.async {
                            if let _ = emailError {
                                print("Error saving email")
                            }
                            else {
                                if let error = info?.errors {
                                    print("Error: \(error)")
                                }
                                else {
//                                    print("Success")
                                    print("User name is: \(name)")
                                    print("User entered email: \(email)")
                                    self.performSegue(withIdentifier: "toVerificationVC", sender: self)
                                }
                            }
                        }
                    })
                }
            }
        }
        
        manager.signInDevice(email: email) { (info, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    print("Error connecting to server..maybe")
                }
                else {
                    if let error = info?.errors {
                        print("Some error")
                    }
                    else {
                        print("Confirmation sent")
                    }
                }
            }
        }
    }
    
    func checkValidEmail(email: String) -> Bool {
        if UIHelper.isValidEmailAddress(emailAddressString: email) {
            print("Valid Email Success")
            return true
        }
        else {
            print("Invalid email format")
            return false
        }
    }

}
