//
//  ViewController.swift
//  BrightnessSensor
//
//  Created by Muronaka Hiroaki on 2015/06/02.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var brightnessLabel:UILabel?
    @IBOutlet var limitBrightnessLabel:UILabel?
    @IBOutlet var limitBrightnessSlider:UISlider?
    
    var currentBrightness:CGFloat {
        get {
            let screen = UIScreen.mainScreen()
            return screen.brightness
        }
    }
    
    var isAlreadySent:Bool = false
    var limitBrightness:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.limitBrightness = CGFloat(self.limitBrightnessSlider!.value)
        checkBrightness()
        
        setBrightnessLabel(self.currentBrightness)
        setBrightnessSliderLabel()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "didChangeScreenBrightness:", name: UIScreenBrightnessDidChangeNotification, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didChangeScreenBrightness(notification:NSNotification?) {
        setBrightnessLabel(self.currentBrightness)
        checkBrightness()
    }
    
    @IBAction func didChangedLimitBrightnessSlider(slider:UISlider?) {
        self.limitBrightness = CGFloat(slider!.value)
        setBrightnessSliderLabel()
        checkBrightness()
    }
    
    private func checkBrightness() {
        
        // 暗くなった
        if self.limitBrightness > self.currentBrightness {
            if( !self.isAlreadySent ) {
                self.view.backgroundColor = UIColor.redColor()
                self.isAlreadySent = true
            }
        } else {
            self.view.backgroundColor = UIColor.whiteColor()
            self.isAlreadySent = false
        }
    }

    private func setBrightnessLabel(brightness:CGFloat) {
        self.brightnessLabel?.text = "\(brightness)"
    }
    
    private func setBrightnessSliderLabel() {
        self.limitBrightnessLabel?.text = "\(self.limitBrightnessSlider!.value)"
    }

}

