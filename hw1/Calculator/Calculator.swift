//
//  Calculator.swift
//  Calculator
//
//  Created by 颜同路 on 2021/10/15.
//

import UIKit

func factorial(_ x: Double)->Double{
    if x > 20{
        return 0
    }
    if !String(x).hasSuffix(".0"){
        return 0
    }
    return Double(recur(Int(x)))
}

func recur(_ x: Int)->Int{
    if x == 0{
        return 1
    }
    else {
        return x * recur(x - 1)
    }
}

class Calculator: NSObject {
    enum Operation{
        case UnaryOp((Double)->Double)
        case BinaryOp((Double, Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    
    var operations = [
        "+": Operation.BinaryOp{
            (op1, op2) in
            return op1 + op2
        },
        
        "-": Operation.BinaryOp{
            (op1, op2) in
            return op1 - op2
        },
        
        "×": Operation.BinaryOp{
            (op1, op2) in
            return op1 * op2
        },
        
        "÷": Operation.BinaryOp{
            (op1, op2) in
            return op1 / op2
        },
        
        "=": Operation.EqualOp,
        
        "AC": Operation.UnaryOp{
            _ in return 0
        },
        
        "+/-": Operation.UnaryOp{
            op in return -op
        },
        
        "%": Operation.UnaryOp{
            op in return op / 100.0
        },
        
        "x^2": Operation.UnaryOp{
            op in return op * op
        },
        
        "x^3": Operation.UnaryOp{
            op in return op * op * op
        },
        
        "x^y": Operation.BinaryOp{
            (op1, op2) in
            return pow(op1, op2)
        },
        
        "e^x": Operation.UnaryOp{
            op in return exp(op)
        },
        
        "10^x": Operation.UnaryOp{
            op in return pow(10, op)
        },
        
        "1/x": Operation.UnaryOp{
            op in return 1/op
        },
        
        "x^1/2": Operation.UnaryOp{
            op in return sqrt(op)
        },
        
        "x^1/3": Operation.UnaryOp{
            op in return pow(op, 1/3)
        },
        
        "x^1/y": Operation.BinaryOp{
            (op1, op2) in
            return pow(op1, 1/op2)
        },
        
        "ln": Operation.UnaryOp{
            op in return log(op)
        },
        
        "log10": Operation.UnaryOp{
            op in return log10(op)
        },
        
        "x!": Operation.UnaryOp{
            op in return factorial(op)
        },
        
        "sin": Operation.UnaryOp{
            op in return sin(op)
        },
        
        "cos": Operation.UnaryOp{
            op in return cos(op)
        },
        
        "tan": Operation.UnaryOp{
            op in return tan(op)
        },
        
        "EE": Operation.BinaryOp{
            (op1, op2) in
            return op1 * pow(10, op2)
        },
        
        "sinh": Operation.UnaryOp{
            op in return sinh(op)
        },
        
        "cosh": Operation.UnaryOp{
            op in return cosh(op)
        },
        
        "tanh": Operation.UnaryOp{
            op in return tanh(op)
        },
        
        "Rand": Operation.Constant(Double(arc4random())),
        
        "π": Operation.Constant(3.1415926535),
        
        "e": Operation.Constant(2.7182818284)
    ]
    
    struct Intermediate{
        var firstOp: Double
        var waitingOperation: (Double, Double)->Double
    }
    
    var pendingOp: Intermediate? = nil
    
    func performOperation(operation: String, operand: Double)->Double? {
        if let op = operations[operation] {
            switch op {
            case .BinaryOp(let function):
                pendingOp = Intermediate(firstOp: operand, waitingOperation: function)
                return nil
            case .Constant(let value):
                return value
            case .EqualOp:
                if pendingOp != nil{
                    var ret = pendingOp!.waitingOperation(pendingOp!.firstOp, operand)
                    pendingOp = nil
                    return ret
                }
                else {
                    return nil
                }
                
            case .UnaryOp(let function):
                return function(operand)
            }
        }
        return nil
    }
}
