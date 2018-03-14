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
    var emailTextField: UITextField!
    var numberToolbar: UIToolbar!
    
    var code1TextField: UITextField!
    var code2TextField: UITextField!
    var code3TextField: UITextField!
    var code4TextField: UITextField!
    var code5TextField: UITextField!
    var code6TextField: UITextField!
    
    var errorLabel: UILabel!
    
    let manager = APIManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        backToBeginning()
        verificationCodeSetup()
        
        manager.getUserEmails { (info, error) in
            DispatchQueue.main.async {
                if error == nil {
                    print("Not able to retrieve data")
                }
                else {
//                    if let email = info?.email {
//                        self.emailTextField.text = "Hi \(email)"
//                    }
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
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0).isActive = true
        
        let verifyButton = UIButton()
        verifyButton.setTitle("Sign in", for: .normal)
        verifyButton.setTitleColor(.red, for: .normal)
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        verifyButton.addTarget(self, action: #selector(verifyButtonPressed), for: .touchUpInside)
        view.addSubview(verifyButton)
        verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verifyButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 60.0).isActive = true
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
    
    func verificationCodeSetup() {
        let codeStackView = UIStackView()
        codeStackView.spacing = 8
        codeStackView.distribution = .fillEqually
        codeStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(codeStackView)
        codeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        codeStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        code1TextField = UITextField(rounded: true)
//        code1TextField.tag = 11
//        code1TextField.addTarget(self, action: #selector(codeChanged(_:)), for: .editingChanged)
        codeStackView.addArrangedSubview(code1TextField)
        
        code2TextField = UITextField(rounded: true)
//        code1TextField.tag = 12
//        code2TextField.addTarget(self, action: #selector(codeChanged(_:)), for: .editingChanged)
        codeStackView.addArrangedSubview(code2TextField)
        
        code3TextField = UITextField(rounded: true)
//        code1TextField.tag = 13
//        code3TextField.addTarget(self, action: #selector(codeChanged(_:)), for: .editingChanged)
        codeStackView.addArrangedSubview(code3TextField)
        
        code4TextField = UITextField(rounded: true)
//        code1TextField.tag = 14
//        code4TextField.addTarget(self, action: #selector(codeChanged(_:)), for: .editingChanged)
        codeStackView.addArrangedSubview(code4TextField)
        
        code5TextField = UITextField(rounded: true)
//        code1TextField.tag = 15
//        code5TextField.addTarget(self, action: #selector(codeChanged(_:)), for: .editingChanged)
        codeStackView.addArrangedSubview(code5TextField)
        
        code6TextField = UITextField(rounded: true)
//        code1TextField.tag = 16
//        code6TextField.addTarget(self, action: #selector(codeChanged(_:)), for: .editingChanged)
        codeStackView.addArrangedSubview(code6TextField)
        
        errorLabel = UILabel()
        errorLabel.textAlignment = .center
        view.addSubview(errorLabel)
        errorLabel.topAnchor.constraint(equalTo: codeStackView.bottomAnchor, constant: 30.0).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        code1TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        code2TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        code3TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        code4TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        code5TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        code6TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Entering 6-digit code is first thing that happens in view
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        code1TextField.becomeFirstResponder()
//    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        
        if text?.utf16.count == 1 {
            switch textField {
            case code1TextField:
                code2TextField.becomeFirstResponder()
            case code2TextField:
                code3TextField.becomeFirstResponder()
            case code3TextField:
                code4TextField.becomeFirstResponder()
            case code4TextField:
                code5TextField.becomeFirstResponder()
            case code5TextField:
                code6TextField.becomeFirstResponder()
            case code6TextField:
                code6TextField.resignFirstResponder()
            default:
                break
            }
        }
        else {
            
        }
    }
    
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
    
//    @objc func codeChanged(_ sender: UITextField) {
//        guard let text = sender.text else { return }
//
//        let lastChar = text.suffix(1)
//        sender.text = String(lastChar)
//
//        if sender.tag >= 11 && sender.tag <= 15 {
//            let nextTextField = sender.superview?.viewWithTag(sender.tag + 1)
//            nextTextField?.becomeFirstResponder()
//        }
//
////        displayNoValidation()
//    }
    
//    func getInputCode() -> String {
//        let firstChar = code1TextField.text ?? ""
//        let secondChar = code2TextField.text ?? ""
//        let thirdChar = code3TextField.text ?? ""
//        let fourthChar = code4TextField.text ?? ""
//        let fifthChar = code5TextField.text ?? ""
//        let sixthChar = code6TextField.text ?? ""
//
//        return "\(firstChar)\(secondChar)\(thirdChar)\(fourthChar)\(fifthChar)\(sixthChar)"
//    }
    
//    func displayValidationError(message: String) {
//
//        // Show error message
//        errorLabel.text = message
//
//        setTextFieldStyle(textField: code1TextField, errorStyle: true)
//        setTextFieldStyle(textField: code2TextField, errorStyle: true)
//        setTextFieldStyle(textField: code3TextField, errorStyle: true)
//        setTextFieldStyle(textField: code4TextField, errorStyle: true)
//        setTextFieldStyle(textField: code5TextField, errorStyle: true)
//        setTextFieldStyle(textField: code6TextField, errorStyle: true)
//
//        code1TextField.becomeFirstResponder()
//    }
//
//    func displayNoValidation() {
//
//        // Clear error message
//        errorLabel.text = ""
//
//        setTextFieldStyle(textField: code1TextField, errorStyle: false)
//        setTextFieldStyle(textField: code2TextField, errorStyle: false)
//        setTextFieldStyle(textField: code3TextField, errorStyle: false)
//        setTextFieldStyle(textField: code4TextField, errorStyle: false)
//        setTextFieldStyle(textField: code5TextField, errorStyle: false)
//        setTextFieldStyle(textField: code6TextField, errorStyle: true)
//    }
    
//    func setTextFieldStyle(textField: UITextField, errorStyle: Bool) {
//        textField.autocorrectionType = UITextAutocorrectionType.no
//        textField.layer.borderWidth = 1.0
//        textField.layer.cornerRadius = 20.0
//        textField.layer.borderColor = errorStyle ? UIColor.red.cgColor : UIColor(red: 105/255, green: 128/255, blue: 151/255, alpha: 1.0).cgColor
//
//        // Maybe there is a simpler way to change the color of the current text...
//        let tempText = textField.text
//        textField.text = ""
//        textField.textColor = errorStyle ? UIColor.red : UIColor(red: 105/255, green: 128/255, blue: 151/255, alpha: 1.0)
//        textField.text = tempText
//    }

}

extension UITextField {

    convenience init(rounded: Bool) {
        self.init()
        
        if rounded {
            self.autocorrectionType = .no
            self.layer.borderWidth = 1.0
            self.layer.cornerRadius = 20.0
            self.translatesAutoresizingMaskIntoConstraints = false
            self.textAlignment = .center
            self.contentHorizontalAlignment = .center
            self.contentVerticalAlignment = .center
            self.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
            self.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
            self.keyboardType = .numberPad
        }
    }
}

