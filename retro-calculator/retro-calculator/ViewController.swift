//
//  ViewController.swift
//  retro-calculator
//
//  Created by Romal Shah on 3/15/16.
//  Copyright © 2016 Romal Shah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound : AVAudioPlayer!
    
    var runningNumber = ""
    var leftVarStr = ""
    var rightVarStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
           try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
        
    }
    
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op:Operation){
        playSound()
        if currentOperation != Operation.Empty{
            //Run Some Math
            
            //A user selected an operator, but then selected another operator without
            //first entering a number 
            if runningNumber != "" {
                rightVarStr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftVarStr)! * Double(rightVarStr)!)"
                }else if currentOperation == Operation.Divide{
                    result = "\(Double(leftVarStr)! / Double(rightVarStr)!)"
                }else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftVarStr)! - Double(rightVarStr)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftVarStr)! + Double(rightVarStr)!)"
                }
                leftVarStr = result
                outputLabel.text = result
 
            }
                        currentOperation = op
        }else{
            //This is the first time an operator is pressed
            leftVarStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    
}

