//
//  CalcViewController.swift
//  Calculator
//
//  Created by 颜同路 on 2021/10/14.
//

import UIKit

class CalcViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var display: UILabel!
    
    var digitOnDisplay: String {
        get {
            return self.display.text!
        }
        
        set {
            self.display.text! = newValue
            if self.display.text!.hasSuffix(".0"){
                self.display.text!.remove(at: self.display.text!.index(before: self.display.text!.endIndex))
                self.display.text!.remove(at: self.display.text!.index(before: self.display.text!.endIndex))
            }
        }
    }
    
    var isTypingMode = false // 是否在输入状态
    
    var is2ndMode = false // 是否在2nd状态
    
    @IBAction func numPressed(_ sender: UIButton){
        // 数字键被按下时运行的函数
        if isTypingMode {
            digitOnDisplay.append(sender.titleLabel!.text!)
        }
        else {
            digitOnDisplay = sender.titleLabel!.text!
            isTypingMode = true
        }
    }
    
    let calculator = Calculator()
    
    @IBAction func opPressed(_ sender: UIButton){
        // 操作符键被按下时运行的函数
        // print(sender.titleLabel!.text!)
        if let op = sender.titleLabel?.text{
            if let result = calculator.performOperation(operation: op, operand: Double(digitOnDisplay)!){
                digitOnDisplay = String(result)
        }
            isTypingMode = false
    }
}
}
