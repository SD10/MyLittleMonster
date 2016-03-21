//
//  ViewController.swift
//  MyLittleMonsterX
//
//  Created by Steven on 3/18/16.
//  Copyright © 2016 devslopes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImage: MonsterImage!
    @IBOutlet weak var heartImage: DragImage!
    @IBOutlet weak var foodImage: DragImage!
    @IBOutlet weak var penaltyOneImage: UIImageView!
    @IBOutlet weak var penaltyTwoImage: UIImageView!
    @IBOutlet weak var penaltyThreeImage: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var currentPenalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        
        foodImage.dropTarget = monsterImage
        heartImage.dropTarget = monsterImage
        penaltyOneImage.alpha = DIM_ALPHA
        penaltyTwoImage.alpha = DIM_ALPHA
        penaltyThreeImage.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func itemDroppedOnCharacter(notification: NSNotification) {
        monsterHappy = true
        startTimer()
        
        foodImage.alpha = DIM_ALPHA
        heartImage.alpha = DIM_ALPHA
        heartImage.userInteractionEnabled = false
        heartImage.userInteractionEnabled = false
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            currentPenalties++
            switch currentPenalties {
            case 1: penaltyOneImage.alpha = OPAQUE; penaltyTwoImage.alpha = DIM_ALPHA
            case 2: penaltyTwoImage.alpha = OPAQUE; penaltyThreeImage.alpha = DIM_ALPHA
            case currentPenalties where currentPenalties >= 3: penaltyThreeImage.alpha = OPAQUE
            default: penaltyOneImage.alpha = DIM_ALPHA; penaltyTwoImage.alpha = DIM_ALPHA; penaltyThreeImage.alpha = DIM_ALPHA
            }
            
            if currentPenalties >= MAX_PENALTIES {
                gameOver()
            }
        }
        
        let randomNumber = arc4random_uniform(2) // 0 or 1
        
        if randomNumber == 0 {
            foodImage.alpha = DIM_ALPHA
            foodImage.userInteractionEnabled = false
            heartImage.alpha = OPAQUE
            heartImage.userInteractionEnabled = true
        } else {
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
        }
        
        currentItem = randomNumber
        monsterHappy = false
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImage.playDeathAnimation()
    }
    


}

