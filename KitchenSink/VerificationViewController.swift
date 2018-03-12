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
        
        manager.getUserEmails { (info, error) in
            DispatchQueue.main.async {
                if error != nil {
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
        emailLabel = UILabel()
        emailLabel.text = ""
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
        verifyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 24.0).isActive = true
        verifyButton.widthAnchor.constraint(equalToConstant: 221.0).isActive = true
        verifyButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
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
                    if let error = emailInfo?.errors {
                        print("Some error")
                    }
                    else {
                        print("Code was sent to your email address")
                    }
                }
            }
        }
        print("Verify button pressed")
    }

}
