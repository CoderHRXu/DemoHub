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
    
    
    
    /*
     8.虽然上面已经解决了我们的问题，但是通过函数式的思维把上面解决的问题抽象化，前面提到函数在Swift里面是一等值，所以可以把我们要解决的问题抽象化，用函数的方式去声明。
     
     比如在上面遇到的一个问题是判断一个点是不是在某个区域内。问题分解：
     
     输入： 某个点 Position
     输出: 这个点是不是在该区域
     怎么描述这个区域：暂时还不知道，它可能是一个圆，也可能是一个矩形或者其它的形状。
     
     写成函数是这样：
     
     */
    
    func pointInRange(point: Position) -> Bool {
        //怎么描述这个区域，暂时还不知道
        return true
    }
    
    
    /*
     怎么描述一个区域，你到时跟我说吧，反正你给一个点，我就能告诉你这个点在不在你描述的这个区域，其实就是定义的一个区域范围。
     假设战舰还是在原点，定义一个在圆心在圆点的一个圆表示它的攻击范围：
     */
    func circle(radius: Distance) -> Region {
        return {(ponit) in ponit.length <= radius}
    }
    
    // 然后把圆心的位置加进去：
    func circle(radius: Distance, center: Position) -> Region {
        return {(ponit) in
            ponit.minus(p: center).length <= radius
        }
    }
    
    // 这样每次在创建这个圆的时候都要指定圆点，是不是可以通过对一个在圆点的圆做一个变换之后来得到一个新的圆呢？ 比如这样：
    
    /// 原点转换
    ///
    /// - Parameters:
    ///   - region: <#region description#>
    ///   - offset: <#offset description#>
    /// - Returns: <#return value description#>
    func shiftRegionCenter(region: @escaping Region, offset: Position) -> Region {
        return {(ponit) in
            region(ponit.minus(p: offset))
        }
    }
    

    // 反转区域
    func invert(region: @escaping Region) -> Region {
        return { ponit in
            !region(ponit)
        }
    }
    
    // 取交集
    func interSection(region1: @escaping Region, region2: @escaping Region) -> Region {
        return { (point) in
            region1(point) && region2(point)
        }
    }
    
    // 取并集
    func union(region1: @escaping Region, region2: @escaping Region) -> Region {
        return { (position) in
            region1(position) || region2(position)
        }
    }
    
    // 在第一个区域不在第二个区域
    func difference(region: @escaping Region, minus: @escaping Region) -> Region {
        return interSection(region1: region, region2: invert(region: minus))
    }
    
    
    
    
    // 5.最后还要避免战绩攻击范围不能距离友方战舰太近，也就是友方战舰不能和敌方战舰太近。所以canSafelyEngageShip进阶为：
    
    func canSafelyAttackShip(target: Ship, friendlyShip: Ship) -> Bool {
        
        // 进化为
        /*
         let targetDistance = target.position.minus(p: position).length
         let friendlyDistance = friendlyShip.position.minus(p: position).length
         
         return targetDistance <= fireRange && targetDistance > unsafeRange && friendlyDistance > unsafeRange
         */
        
        // 再进化为
        let rangeRegion = difference(region: circle(radius: fireRange), minus: circle(radius: unsafeRange))
        let fireRegion = shiftRegionCenter(region: rangeRegion, offset: position)
        let friendlyRegion = shiftRegionCenter(region: circle(radius: unsafeRange), offset: friendlyShip.position)
        let resultRegion = difference(region: fireRegion, minus: friendlyRegion)
        
        return resultRegion(target.position)
        
    }
    
    
    
}
