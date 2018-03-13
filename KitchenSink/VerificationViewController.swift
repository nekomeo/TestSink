//
//  VerificationViewController.swift
//  KitchenSink
//
//  Created by Elle Ti on 2018-03-12.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit

class VerificationViewController: UIViewController {
    
    var email: String?
    var emailLabel: UILabel!
    
    let manager = APIManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        backToBeginning()
        
        manager.getUserEmails { (info, error) in
            DispatchQueue.main.async {
                if error == nil {
                    print("Not able to retrieve data")
                }
                else {
                    if let email = info?.email {
                        self.emailLabel.text = "Hi \(email)"
                    }
                }
                print("Yo")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initialSetup() {
        let headingLabel = UILabel()
        headingLabel.text = "We sent you an email.\nPlease check your email to confirm registration"
        headingLabel.textColor = .darkGray
        headingLabel.textAlignment = .center
        headingLabel.numberOfLines = 0
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headingLabel)
        headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headingLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20.0).isActive = true
        
        emailLabel = UILabel()
        emailLabel.text = "Hello"
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -12.0).isActive = true
        
        let verifyButton = UIButton()
        verifyButton.setTitle("Verify", for: .normal)
        verifyButton.setTitleColor(.red, for: .normal)
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        verifyButton.addTarget(self, action: #selector(verifyButtonPressed), for: .touchUpInside)
        view.addSubview(verifyButton)
        verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verifyButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 12.0).isActive = true
        verifyButton.widthAnchor.constraint(equalToConstant: 221.0).isActive = true
        verifyButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
    
    func backToBeginning() {
        let dismissButton = UIButton()
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.setTitleColor(.blue, for: .normal)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        view.addSubview(dismissButton)
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -24.0).isActive = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func verifyButtonPressed() {
        guard let email = email else { return }
        
        let manager = APIManager()
        
        manager.signInDevice(email: email) { (emailInfo, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    print("Error when connecting to the server")
                }
                else {
                    if (emailInfo?.errors) != nil {
                        print("Some error: \(String(describing: emailInfo?.errors))")
                    }
                    else {
                        print("Code was sent to your email address")
                        self.performSegue(withIdentifier: "toMainVC", sender: self)
                    }
                }
            }
        }
        print("Verify button pressed")
    }
    
    @objc func dismissButtonPressed() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

}
