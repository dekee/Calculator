//
//  ViewController.swift
//  Calculator
//
//  Created by DERRICK JOHNSON on 4/20/16.
//  Copyright © 2016 wedevops. All rights reserved.
//

import UIKit //module group of classes 

class ViewController: UIViewController {

    //override func viewDidLoad() {
    //    super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    //}

    //override func didReceiveMemoryWarning() {
    //    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    //}

    
    @IBOutlet private weak var display: UILabel!
    private var brain: CalculatorBrain = CalculatorBrain()
    
    //var userIsInTheMiddleOfTyping: Bool = false
    //swift will infer boolean
    private var userIsInTheMiddleOfTyping = false
    //controller drag from number and this will be created
    //click on circle and will tell where it connects
    //sender: type
    @IBAction private func touchDigit(sender: UIButton) {
       let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display!.text!
            display!.text = textCurrentlyInDisplay + digit
        } else {
            display!.text = digit
        }
        userIsInTheMiddleOfTyping = true
       print("touchDigit \(digit) digit")
      
    }

    //computed property
    //special keyw world
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
        
    }
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        //only unwrap if it has a value
        if let mathematicalSymbol = sender.currentTitle {
             brain.peformOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
}

