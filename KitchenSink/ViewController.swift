//
//  ViewController.swift
//  KitchenSink
//
//  Created by Elle Ti on 2018-03-06.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pressedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pressMeButton = UIButton()
        pressMeButton.setTitle("Press me", for: .normal)
        pressMeButton.setTitleColor(.white, for: .normal)
        pressMeButton.translatesAutoresizingMaskIntoConstraints = false
        pressMeButton.addTarget(self, action: #selector(cancelButtonTouched), for: .touchUpInside)
        view.addSubview(pressMeButton)
        pressMeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pressMeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        pressedLabel = UILabel()
        pressedLabel.text = ""
        pressedLabel.textColor = .yellow
        pressedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pressedLabel)
        pressedLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 24.0).isActive = true
        pressedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @objc func cancelButtonTouched() {
        pressedLabel.text = "Pressed"
    }

}

