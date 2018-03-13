//
//  FirstViewController.swift
//  KitchenSink
//
//  Created by Elle Ti on 2018-03-13.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signinButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignin", sender: self)
    }
    
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignup", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
