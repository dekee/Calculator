//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by DERRICK JOHNSON on 4/24/16.
//  Copyright © 2016 wedevops. All rights reserved.
//

import Foundation
//function are public by default
func multiply(op1: Double, op2: Double)-> Double {
    return op1*op2
}

class CalculatorBrain {
    
    /*    enum Optional<T> {
     case None
     case Some(T)
     }*/
    
    //accumulate the result
    private var accumulator = 0.0
    //make a property be read only
    var result: Double {
        get {
            return accumulator
        }
    }
    
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    //have to initialize all vars
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI), //M_PI,
        "e" : Operation.Constant(M_E),  //M_E
        "±" : Operation.UnaryOperation({ -$0 }),
        "√" : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "×":  Operation.BinaryOperation({ $0 * $1 }),
        "÷":  Operation.BinaryOperation({$0 / $1}),
        "+":  Operation.BinaryOperation({$0 + $1}),
        "−":  Operation.BinaryOperation({$0 - $1}),
        "=":  Operation.Equals
    ]
    
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double, Double)->Double)
        case Equals
    }
    
    func peformOperation(symbol: String) {
        //Dictionary may not contain so it is a optional
        //If let unrap if it is found in table
        if let operation = operations[symbol] {
            //accumulator = constant
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
        private func executePendingBinaryOperation() {
            if pending != nil {
                accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
                pending = nil
            }

        }
    /*switch symbol {
     case "π": accumulator = M_PI
     case "√": accumulator = sqrt(accumulator)
     default: break
     }*/
    
    
    //question mark means optional
    //optional, because it is only optional if I clicked on the key
    private var pending: PendingBinaryOperationInfo?
    
    //struct like enum is passed by value instead of reference
    // pass by reference you have a pointer to the item
    // pass by value, when you pass it, you get a copy of it
    // int, Double are all structs
    // free initializer on vars for structs
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
}