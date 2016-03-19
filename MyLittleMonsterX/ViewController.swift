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
        print("ITEM DROPPED ON CHARACTER")
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
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
    
    func gameOver() {
        timer.invalidate()
        monsterImage.playDeathAnimation()
    }
    


}

