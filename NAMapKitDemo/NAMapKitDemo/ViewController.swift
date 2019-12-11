//
//  ViewController.swift
//  NAMapKitDemo
//
//  Created by haoran on 2019/12/10.
//  Copyright © 2019 haoran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mapView: MoPopMapView = {
        let mapView = MoPopMapView(frame: CGRect(x: 50, y: 200, width: 300, height: 400))
        mapView.backgroundColor = UIColor.yellow
        let image = UIImage.init(named: "map.png")!
        mapView.displayMap(image)
        mapView.zoomScale = mapView.bounds.size.height / image.size.height
        mapView.minimumZoomScale = mapView.minimumZoomScale < mapView.zoomScale ? mapView.zoomScale : mapView.minimumZoomScale
        mapView.zoomScale = 0.5
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    
    func setupMap() {
        
        view.addSubview(mapView)
        mapView.mapViewDelegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let annotation = PinAnnotation.init(point: CGPoint(x: 500, y: 400), type: .User)
        annotation.title = "JBL THEATER"
        mapView.add(annotation, animated: true)
    }
}

extension ViewController: NAMapViewDelegate {
    
    func mapView(_ mapView: NAMapView!, hasChangedZoomLevel level: CGFloat) {
        print("hasChangedZoomLevel: \(level)")
    }
    
    func mapView(_ mapView: NAMapView!, tappedOn annotation: NAAnnotation!) {
        print("tappedOn annotation:")
        print(annotation ?? "")
    }
}
