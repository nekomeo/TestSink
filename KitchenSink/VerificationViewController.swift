//
//  VerificationViewController.swift
//  KitchenSink
//
//  Created by Elle Ti on 2018-03-12.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit

protocol CustomTextFieldDelegate{
    func textFieldDidDelete()
}

class CustomTextField: UITextField {
    var myCustomTextFieldDelegate : CustomTextFieldDelegate!
    override func deleteBackward() {
        super.deleteBackward()
        myCustomTextFieldDelegate.textFieldDidDelete()
    }
}


public protocol VerificationDelegate: class {
    func verifyCode(email: String, code: String)
}

class VerificationViewController: UIViewController {
    
    public weak var delegate: VerificationDelegate?
    
    var email: String?
    var code: String?
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
        codeStackView.addArrangedSubview(code1TextField)
        
        code2TextField = UITextField(rounded: true)
        codeStackView.addArrangedSubview(code2TextField)
        
        code3TextField = UITextField(rounded: true)
        codeStackView.addArrangedSubview(code3TextField)
        
        code4TextField = UITextField(rounded: true)
        codeStackView.addArrangedSubview(code4TextField)
        
        code5TextField = UITextField(rounded: true)
        codeStackView.addArrangedSubview(code5TextField)
        
        code6TextField = UITextField(rounded: true)
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
        else if text?.utf16.count == 0 {
            let textField = ""
            switch textField {
            case code2TextField.text!:
                code1TextField.becomeFirstResponder()
            case code3TextField.text!:
                code2TextField.becomeFirstResponder()
            case code4TextField.text!:
                code3TextField.becomeFirstResponder()
            case code5TextField.text!:
                code4TextField.becomeFirstResponder()
            case code6TextField.text!:
                code5TextField.becomeFirstResponder()
            case code1TextField.text!:
                code1TextField.resignFirstResponder()
            default:
                break
            }
        }
    }
    
    @objc func verifyButtonPressed() {
//        self.delegate?.verifyCode(email: "", code: "") // Use for programmatic view
        
        guard let email = email, let code = code else { return }
        
        let manager = APIManager()
        
        manager.verifyAccountInfo(email: email, code: code) { (emailInfo, error) in
            DispatchQueue.main.async {
                
            }
        }
        
//        manager.signInDevice(email: email) { (emailInfo, error) in
//            DispatchQueue.main.async {
//                if let _ = error {
//                    print("Error when connecting to the server")
//                }
//                else {
//                    if (emailInfo?.errors) != nil {
//                        print("Some error: \(String(describing: emailInfo?.errors))")
//                    }
//                    else {
//                        print("Code was sent to your email address")
//                        self.performSegue(withIdentifier: "toMainVC", sender: self)
//                    }
//                }
//            }
//        }
        print("Verify button pressed")
    }
    
        // Test out later. Looks better to use because can increase/decrease number of textfields
//    @objc func textFieldChanged(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        code1TextField = textField as! CustomTextField
//        let nextTag = textField.tag + 1;
//        // get next responder
//        var nextResponder = textField.superview?.viewWithTag(nextTag);
//
//        // On inputing value to textfield
//        if ((textField.text?.count)! < 1  && string.count > 0) {
//
//            if (nextResponder == nil){
//                nextResponder = textField.superview?.viewWithTag(1);
//            }
//            textField.text = string;
//
//            if nextTag == 5 {
//                code6TextField.resignFirstResponder()
//                return true;
//            }
//
//            nextResponder?.becomeFirstResponder();
//            return false;
//        }
//        if (textField.text?.count >= 1  && string.count == 0) {
//            // on deleteing value from Textfield
//            let presentTag = textField.tag;
//            // get next responder
//            var presentResponder = textField.superview?.viewWithTag(presentTag);
//
//            if (presentResponder == nil){
//                presentResponder = textField.superview?.viewWithTag(1);
//            }
//            textField.text = "";
//            presentResponder?.becomeFirstResponder();
//            return false;
//        }
//
//        let currentCharacterCount = textField.text?.count ?? 0
//        let newLength = currentCharacterCount + string.count - range.length
//        if newLength > 1 {
//            textField.text = string
//            if (nextResponder != nil){
//                nextResponder?.becomeFirstResponder();
//            }
//
//        }
//        let returnVal = newLength <= 1
//        return returnVal;
//    }
    
//    func textFieldDidDelete() {
//        print("Entered Delete");
//        print("Tag!!\(currentActiveTextField.tag)")
//        var previousTag = 0
//        if currentActiveTextField.text == ""{
//            previousTag = currentActiveTextField.tag - 1
//        }else{
//            previousTag = currentActiveTextField.tag
//        }
//        let previousResponder = currentActiveTextField.superview?.viewWithTag(previousTag)
//        if(previousTag > 0){
//            let previousTextField = previousResponder as! CustomTextField
//            previousTextField.text = ""
//            currentActiveTextField = previousTextField
//            previousResponder?.becomeFirstResponder()
//        }
//    }
    
    
    @objc func dismissButtonPressed() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    

    
    //MARK: - Editing Passcode
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.utf16.count == 1 {
            textField.text = ""
        }
    }
    

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

