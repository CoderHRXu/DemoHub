//
//  ViewController.swift
//  MultipleLan
//
//  Created by haoran on 2019/12/9.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let polygon = [CGPoint(x: 50, y: 50), CGPoint(x: 100, y: 50), CGPoint(x: 150, y: 100), CGPoint(x: 100, y: 150),CGPoint(x: 76, y: 80),CGPoint(x: 10, y: 40), CGPoint(x: 50, y: 50), ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        test()

        let path = UIBezierPath.init()
        polygon.enumerated().forEach { (index, point) in
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        path.close()
        
        let routeLayer              = CAShapeLayer()
        routeLayer.lineWidth        = 1
        routeLayer.strokeColor      = UIColor.blue.cgColor
//        routeLayer.lineDashPattern  = [NSNumber(2), NSNumber(2)]
        routeLayer.path             = path.cgPath
        routeLayer.fillColor        = UIColor.clear.cgColor
        view.layer.addSublayer(routeLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let pt = touch?.location(in: view)
        let flag = checkPointisInPolygon(polygon: polygon, point: pt!)
        print(pt)
        print(flag)
    }
    
    func test() {
        
        let manager = LanguageManager.shared
        
        let label = UILabel.init(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
  
        label.text = NSLocalizedString("labelText", tableName: "Language", bundle: Bundle.main, value: "value", comment: "comment")
//        label.text = manager.localizedString(key: "labelText", value: "", table: "Language")
        view.addSubview(label)
        
        let btn = UIButton.init(frame: CGRect(x: 10, y: 200, width: 100, height: 100))
//        btn.setTitle(NSLocalizedString("btnNormalTitle", tableName: "Language", bundle: Bundle.main, value: "按钮文字", comment: "注释"), for: .normal)
//        let title = manager.localizedString(key: "btnNormalTitle", value: "", table: "Language")
        let title = NSLocalizedString("btnNormalTitle", tableName: "Language", bundle: Bundle.main, value: "", comment: "")
        
        btn.setTitle(title, for: .normal)
        btn.sizeToFit()
        view.addSubview(btn)
        btn.setTitleColor(UIColor.black, for: .normal)
        
        
        let label2 = UILabel.init(frame: CGRect(x: 10, y: 300, width: 375, height: 50))

        let temp = NSLocalizedString("Congratulations! You have got the %@ Verification on %@ %@.", tableName: "Language", bundle: Bundle.main, value: "", comment: "")
        label2.text = String.localizedStringWithFormat(temp, "11", "22", "33")
        label2.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(label2)
                
    }

    
    @IBAction func btnclick(_ btn: UIButton) {
        
        var language = "en"
        if let lan = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
            
            language = lan.first == "en" ? "es" : "en"
        }
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
//        let delagate = UIApplication.shared.delegate as! AppDelegate
//        delagate.perform(controller: vc)
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    
    func checkPointisInPolygon(polygon: [CGPoint], point: CGPoint) -> Bool {

        let count = polygon.count
        var nCross = 0
        for i in 0..<count {
            
            let j = polygon[i].x
            let k = polygon[i].y
            let m = polygon[(i + 1) % count].x
            let n = polygon[(i + 1) % count].y
            
            let p1 = CGPoint(x: j, y: k)
            let p2 = CGPoint(x: m, y: n)

            if p1.y == p2.y {
                continue
            }
            if point.y < min(p1.y, p2.y) {
                continue
            }
            if point.y > max(p1.y, p2.y) {
                continue
            }
            let x = (point.y - p1.y) * (p2.x - p1.x) / (p2.y - p1.y) + p1.x

            if x > point.x {
                nCross += 1
            }
        }
        
        return nCross % 2 != 0
    }
}

