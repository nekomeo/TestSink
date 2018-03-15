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
        
        // @objc func textFieldDidChange(textField: UITextField)
        code1TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        code2TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        code3TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        code4TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        code5TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        code6TextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        //func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//        code1TextField.addTarget(self, action: #selector(textFieldChanged(textField:shouldChangeCharactersInRange:replacementString:)), for: .editingChanged)
//        code2TextField.addTarget(self, action: #selector(textField(_:shouldChangeCharactersIn:replacementString:)), for: .editingChanged)
//        code3TextField.addTarget(self, action: #selector(textField(_:shouldChangeCharactersIn:replacementString:)), for: .editingChanged)
//        code4TextField.addTarget(self, action: #selector(textField(_:shouldChangeCharactersIn:replacementString:)), for: .editingChanged)
//        code5TextField.addTarget(self, action: #selector(textField(_:shouldChangeCharactersIn:replacementString:)), for: .editingChanged)
//        code6TextField.addTarget(self, action: #selector(textField(_:shouldChangeCharactersIn:replacementString:)), for: .editingChanged)
        
        // func textFieldHasChange(textField: UITextField)
//        code1TextField.addTarget(self, action: #selector(textFieldHasChange(textField:)), for: .editingChanged)
//        code2TextField.addTarget(self, action: #selector(textFieldHasChange(textField:)), for: .editingChanged)
//        code3TextField.addTarget(self, action: #selector(textFieldHasChange(textField:)), for: .editingChanged)
//        code4TextField.addTarget(self, action: #selector(textFieldHasChange(textField:)), for: .editingChanged)
//        code5TextField.addTarget(self, action: #selector(textFieldHasChange(textField:)), for: .editingChanged)
//        code6TextField.addTarget(self, action: #selector(textFieldHasChange(textField:)), for: .editingChanged)
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
//        else if ((textField.text?.count)! >= 1  && text?.count == 0) {
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
    
//    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // On inputing value to textfield
//        if ((textField.text?.count)! < 1  && string.count > 0) {
//            if (textField == code1TextField) {
//                code2TextField.becomeFirstResponder()
//            }
//            if (textField == code2TextField) {
//                code3TextField.becomeFirstResponder()
//            }
//            if (textField == code3TextField) {
//                code4TextField.becomeFirstResponder()
//            }
//            if (textField == code4TextField) {
//                code5TextField.becomeFirstResponder()
//            }
//            if (textField == code5TextField) {
//                code6TextField.becomeFirstResponder()
//            }
//            textField.text = string
//            return false
//
//        } else if ((textField.text?.count)! >= 1  && string.count == 0) {
//            // on deleting value from Textfield
//            if (textField == code2TextField) {
//                code1TextField.becomeFirstResponder()
//            }
//            if (textField == code3TextField) {
//                code2TextField.becomeFirstResponder()
//            }
//            if (textField == code4TextField) {
//                code3TextField.becomeFirstResponder()
//            }
//            if (textField == code5TextField) {
//                code4TextField.becomeFirstResponder()
//            }
//            if (textField == code6TextField) {
//                code5TextField.becomeFirstResponder()
//            }
//            textField.text = ""
//            return false
//        } else if ((textField.text?.count)! >= 1 ) {
//            textField.text = string
//            return false
//        }
//        return true
//    }
    
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
    
    //MARK: - Editing Passcode
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.utf16.count == 1 {
            textField.text = ""
        }
    }
    
//    @objc func textFieldHasChange(textField: UITextField) {
//
//        let text = textField.text
//
//        if text?.utf16.count == 1 {
//            switch textField {
//            case code1TextField:
//                if code2TextField.text?.utf16.count == 1 {
//                    code1TextField.resignFirstResponder()
//                }
//                else {
//                    code2TextField.becomeFirstResponder()
//                }
//            case code2TextField:
//                if code3TextField.text?.utf16.count == 1 {
//                    code2TextField.resignFirstResponder()
//                }
//                else {
//                    code3TextField.becomeFirstResponder()
//                }
//            case code3TextField:
//                if code4TextField.text?.utf16.count == 1 {
//                    code3TextField.resignFirstResponder()
//                }
//                else {
//                    code4TextField.becomeFirstResponder()
//                }
//            case code4TextField:
//                if code5TextField.text?.utf16.count == 1 {
//                    code4TextField.resignFirstResponder()
//                }
//                else {
//                    code5TextField.becomeFirstResponder()
//                }
//            case code5TextField:
//                if code6TextField.text?.utf16.count == 1 {
//                    code5TextField.resignFirstResponder()
//                }
//                else {
//                    code6TextField.becomeFirstResponder()
//                }
//            case code6TextField:
//                code6TextField.resignFirstResponder()
//            default:
//                break
//            }
//        }
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

