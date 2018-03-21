//
//  Position.swift
//  RxSwiftLearn
//
//  Created by haoran on 2018/3/21.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import Foundation

/*
 战舰游戏
 现在在编写一个战舰类游戏，需要确定当前战舰的攻击范围，有以下几点：
 
 这个范围在该战舰的攻击范围
 这个范围不能离自己太近
 这个范围不能离友方战舰太近
 */

// 常规套路
// 1.问题分解:首先假设战舰在原点，计算以原点为中心的一个范围，先定义两种类型，距离和点。(尽量把变量定义成有意义的名字)

typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
    // 3.问题进化:当战舰不在原点的情况，需要把Position作为战舰Ship的一个属性。
}


// 2.给Position添加一个函数inRange(_:)，检验一个点是否在某个范围区域。
extension Position {
    
    func inRange(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
}
