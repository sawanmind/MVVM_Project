//
//  AnimationExtenions.swift
//  Spacebook
//
//  Created by iOS Development on 5/18/18.
//  Copyright © 2018 Genisys. All rights reserved.
//

import Foundation
import UIKit



// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Animations

func logoAnimator(element:AnyObject) {
    let groupOne = CAAnimationGroup()
    groupOne.beginTime = CACurrentMediaTime() + 0.0
    groupOne.repeatCount = Float(1)
    groupOne.duration = 1.0
    groupOne.autoreverses = false
    groupOne.isRemovedOnCompletion = false
    groupOne.fillMode = kCAFillModeRemoved
    groupOne.animations = []
    
    let animationOne = CABasicAnimation()
    animationOne.beginTime = 0.0
    animationOne.repeatCount = Float(1)
    animationOne.duration = 1.0
    animationOne.autoreverses = false
    animationOne.isRemovedOnCompletion = false
    animationOne.timingFunction = CAMediaTimingFunction(controlPoints: 0.12, 0.683078835227273, 0.58, 1.0)
    animationOne.keyPath = "transform.translation.y"
    animationOne.fromValue = 500
    animationOne.toValue = 0
    groupOne.animations?.append(animationOne)
    
    let animationTwo = CABasicAnimation()
    animationTwo.beginTime = 0.0
    animationTwo.repeatCount = Float(1)
    animationTwo.duration = 1.0
    animationTwo.autoreverses = false
    animationTwo.isRemovedOnCompletion = false
    animationTwo.timingFunction = CAMediaTimingFunction(controlPoints: 0.1, 0.644264914772727, 0.58, 1.0)
    animationTwo.keyPath = "opacity"
    animationTwo.fromValue = 0
    animationTwo.toValue = 1
    groupOne.animations?.append(animationTwo)
    
    let animationThree = CAKeyframeAnimation()
    animationThree.beginTime = 0.0
    animationThree.repeatCount = Float(1)
    animationThree.duration = 1.0
    animationThree.autoreverses = false
    animationThree.isRemovedOnCompletion = false
    animationThree.timingFunction = CAMediaTimingFunction(controlPoints: 0.1, 0.631640625, 0.58, 1.0)
    animationThree.keyPath = "transform.rotation"
    animationThree.keyTimes = [ 0.0, 0.8, 1.0 ]
    animationThree.values = [ -45.0 / 180 * Double.pi, -45.0 / 180 * Double.pi, 0.0 / 180 * Double.pi ]
    groupOne.animations?.append(animationThree)
    
    element.layer.add(groupOne, forKey: nil)
}

 func bounceAnimator(element:AnyObject,completion:@escaping() -> Void) {
    let groupOne = CAAnimationGroup()
    groupOne.beginTime = CACurrentMediaTime() + 0.0
    groupOne.repeatCount = Float(1)
    groupOne.duration = 1.0
    groupOne.autoreverses = false
    groupOne.isRemovedOnCompletion = false
    groupOne.fillMode = kCAFillModeRemoved
    groupOne.animations = []
    
    let animationOne = CAKeyframeAnimation()
    animationOne.beginTime = 0.0
    animationOne.repeatCount = Float(1)
    animationOne.duration = 1.0
    animationOne.autoreverses = false
    animationOne.isRemovedOnCompletion = false
    animationOne.timingFunction = CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1.0)
    animationOne.keyPath = "transform.scale"
    animationOne.keyTimes = [ 0.0, 0.2, 0.4, 0.6, 0.8, 1.0 ]
    animationOne.values = [ 0.3, 1.1, 0.9, 1.03, 0.97, 1.0 ]
    groupOne.animations?.append(animationOne)
    
    let animationTwo = CAKeyframeAnimation()
    animationTwo.beginTime = 0.0
    animationTwo.repeatCount = Float(1)
    animationTwo.duration = 1.0
    animationTwo.autoreverses = false
    animationTwo.isRemovedOnCompletion = false
    animationTwo.timingFunction = CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1.0)
    animationTwo.keyPath = "opacity"
    animationTwo.keyTimes = [ 0.0, 0.6, 1.0 ]
    animationTwo.values = [ 0.0, 1.0, 1.0 ]
    groupOne.animations?.append(animationTwo)
    
    element.layer.add(groupOne, forKey: nil)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
        completion()
    }
}


