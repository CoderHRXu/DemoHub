//
//  Ship.swift
//  RxSwiftLearn
//
//  Created by haoran on 2018/3/21.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import Foundation

// 3.问题进化:当战舰不在原点的情况，需要把Position作为战舰Ship的一个属性。

struct Ship {
    var position: Position
    
    /// 攻击范围
    var fireRange: Distance
    
    /// 自身的不安全范围
    var unsafeRange: Distance
    
    
}



extension Ship {
    
    // 4.给Ship添加一个canSafelyEngageShip(_:),检测另一个战舰是否在可攻击范围内，但是又不能距离自身太近，也就是unsafeRange。
    /*
    func canSafelyAttackShip(target: Ship) -> Bool {
        
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <= fireRange && targetDistance >= unsafeRange
    }
    */
    // 5.最后还要避免战绩攻击范围不能距离友方战舰太近，也就是友方战舰不能和敌方战舰太近。所以canSafelyEngageShip进阶为：
    func canSafelyAttackShip(target: Ship, friendlyShip: Ship) -> Bool {
        
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        let friendlyDx = friendlyShip.position.x - position.x
        let friendlyDy = friendlyShip.position.y - position.y
        let friendlyDistance = sqrt(friendlyDx * friendlyDx + friendlyDy * friendlyDy)

        return targetDistance <= fireRange && targetDistance >= unsafeRange && friendlyDistance > unsafeRange
    }
}
