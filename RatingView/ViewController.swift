//
//  ViewController.swift
//  RatingView
//
//  Created by Devanshu Saini on 11/02/17.
//  Copyright © 2017 Devanshu Saini devanshu2@gmail.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ratingV = RatingView()
        ratingV.text = "4.5+"
        ratingV.cornerRadius = 8.0
        ratingV.updateUIElements()
        ratingV.frame = CGRect(x: 30, y: 230.0, width: ratingV.viewWidth, height: 20.0)
        self.view.addSubview(ratingV)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

