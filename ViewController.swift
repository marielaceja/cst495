//
//  ViewController.swift
//  Calculator
//
//  Created by Mariela Ceja on 9/14/15.
//  Copyright (c) 2015 Mariela Ceja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber{
            display.text = display.text! + digit
        }
        else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
        
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
            case "×": performOperation({ $0 * $1 })
            case "÷": performOperation({ $0 / $1 })
            case "+": performOperation({ $0 + $1 })
            case "−": performOperation({ $0 - $1 })
            case "√": performOperation({ sqrt($0) })
        default: break
        }
    }
    
    // Function takes in two doubles and returns a Double
    func performOperation(operation: (Double, Double) -> Double){
        if(operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func performOperation(operation: (Double) -> Double){
        if(operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
    
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    

}

