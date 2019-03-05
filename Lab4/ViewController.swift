//
//  ViewController.swift
//  Lab4
//
//  Created by iosdev on 26/01/2019.
//  Copyright © 2019 iosdev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var decreasae: UIButton!
    @IBOutlet weak var increase: UIButton!
    @IBOutlet weak var reset: UIButton!
    var counterBrain = CounterBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.text = String(counterBrain.getValue())
    }
    
    @IBAction func decreaseClick(_ sender: UIButton) {
        counterBrain.decrease()
        label.text = String(counterBrain.getValue())
    }
    
    @IBAction func increaseClick(_ sender: UIButton) {
        counterBrain.increase()
        label.text = String(counterBrain.getValue())
    }
    
    @IBAction func resetClick(_ sender: UIButton) {
        counterBrain.reset()
        label.text = String(counterBrain.getValue())
    }
}

