//
//  HomeViewModel.swift
//  HRSwiftDemo
//
//  Created by haoran on 2018/10/24.
//  Copyright © 2018年 haoran. All rights reserved.
//

import Foundation

import PromiseKit
import RxSwift
import Moya

class HomeViewModel: BaseViewModel {
    
    
    /// 获取所有的车l列表
    ///
    /// - Returns:
    func getCarList() -> Promise<[CarListModel]> {
        
        return Promise.init(resolver: { (result) in
            
            sendRequest(target: HRHomeApiService.getPrdList, withHUD: true).mapModelArray(modelType: CarListModel.self).subscribe(onNext: { (items) in
                result.fulfill(items)
            }, onError: { (err) in
                result.reject(err)
            }).disposed(by: disposeBag)
        })
        
    }
    
    
    /// 增加车品牌
    ///
    /// - Parameter carBandName: 车品牌名称
    /// - Returns:
    func addCarBand(carBandName: String) -> Promise<[CarListModel]> {
        
        return Promise.init(resolver: { (result) in
            sendRequest(target: HRHomeApiService.addPrd(carBandName: carBandName), withHUD: false).mapModelArray(modelType: CarListModel.self).subscribe(onNext: { (items) in
                result.fulfill(items)
            }, onError: { (err) in
                result.reject(err)
            }).disposed(by: disposeBag)
            
        })
    }
}
