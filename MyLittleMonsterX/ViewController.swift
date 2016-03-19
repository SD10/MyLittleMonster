//
//  ViewController.swift
//  MyLittleMonsterX
//
//  Created by Steven on 3/18/16.
//  Copyright © 2016 devslopes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImage: UIImageView!
    @IBOutlet weak var heartImage: DragImage!
    @IBOutlet weak var foodImage: DragImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageArray = [UIImage]()
        for x in 1...4 {
            let image = UIImage(named: "idle\(x).png")
            if let image = image {
                imageArray.append(image)
            }
        }
        
        monsterImage.animationImages = imageArray
        monsterImage.animationDuration = 0.8
        monsterImage.animationRepeatCount = 0
        monsterImage.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("I just touched the screen")
    }


}

