//
//  ViewController.swift
//  RxSwiftLearn
//
//  Created by haoran on 2018/3/21.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        step1()
    }

    func step1() {
        
        
        let position: Position = Position(x: 5, y: 5)
        let myShip = Ship(position: position, fireRange: 20, unsafeRange: 5)
        
        let friendShip = Ship(position: Position(x: 10 ,y:10 ), fireRange: 20, unsafeRange: 5)
        
        let targetShip = Ship(position: Position(x: 16, y: 20), fireRange: 20, unsafeRange: 5)
        
        let canAttack = myShip.canSafelyAttackShip(target: targetShip , friendlyShip: friendShip)
        print(canAttack)
        // 传一个区域和移动的偏移来生成一个新的圆。代码可以从:
//        Region circle = circle(10,Position(x:5, y:5))
 

        
    }
}

