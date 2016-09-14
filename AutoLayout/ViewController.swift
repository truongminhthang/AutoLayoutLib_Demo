//
//  ViewController.swift
//  AutoLayout
//
//  Created by Admin on 9/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let midSize         = CGSize(width: 100, height: 100)
    let smallSize       = CGSize(width: 25, height: 25)
    let midColor        = UIColor.blue
    let smallColor      = UIColor.yellow
    let offSet          = UIOffset(horizontal: -18, vertical:100)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let myView = UIView()
        myView.autolayout(at: .inCenter, of: self.view, offsetIs: offSet  , sizeIs: midSize)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

