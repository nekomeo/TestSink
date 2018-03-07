//
//  ViewController.swift
//  KitchenSink
//
//  Created by Elle Ti on 2018-03-06.
//  Copyright © 2018 Elle Ti. All rights reserved.
//

import UIKit
import Amplitude_iOS

class ViewController: UIViewController {
    
    var pressedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSetup()
        pressedLabelSetup()
    }
    
    func buttonSetup() {
        let pressMeButton = UIButton()
        pressMeButton.setTitle("Press me", for: .normal)
        pressMeButton.setTitleColor(.white, for: .normal)
        pressMeButton.translatesAutoresizingMaskIntoConstraints = false
        pressMeButton.addTarget(self, action: #selector(cancelButtonTouched), for: .touchUpInside)
        view.addSubview(pressMeButton)
        pressMeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pressMeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let secondButton = UIButton()
        secondButton.setTitle("Press me next", for: .normal)
        secondButton.setTitleColor(.white, for: .normal)
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.addTarget(self, action: #selector(secondButtonPressed), for: .touchUpInside)
        view.addSubview(secondButton)
        secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -24.0).isActive = true
        
    }
    
    func pressedLabelSetup() {
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
        
        Amplitude.instance().logEvent("Button pressed")
    }
    
    @objc func secondButtonPressed() {
        pressedLabel.text = "Second button pressed"
        pressedLabel.textColor = .orange
        
        Amplitude.instance().logEvent("Second button pressed")
    }

}

