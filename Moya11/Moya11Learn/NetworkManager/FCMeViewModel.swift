//
//  FCMeViewModel.swift
//  JiKeJiaoShi
//
//  Created by haoran on 2018/1/30.
//  Copyright © 2018年 fclassroom. All rights reserved.
//

import UIKit
import PromiseKit
import RxSwift
import Moya

class FCMeViewModel: FCBaseViewModel {
    
    func questionCartWithQuerySimple() -> Promise<[String:Any]> {
        
        return Promise.init(resolvers: { (resolve, reject ) in

            sendRequest(target: FCMeApiService.taskReadExamCount)
                .mapDictionary()
                .subscribe(onNext: {
                    resolve($0)
                }, onError: {
                    reject($0)
                })
                .disposed(by: self.disposeBag)
        })
        
        
    }
    
    
    
    func requestTaskReadExamCount() -> Promise<FCReadExamCountModel> {
        
        return Promise.init(resolvers: { ( resolve, reject ) in
            
            sendRequest(target: FCMeApiService.taskReadExamCount)
                .mapModelObject(FCReadExamCountModel.self)
                .subscribe(onNext: {
                    resolve($0)
                }, onError: {
                    reject($0)
                })
                .disposed(by: self.disposeBag)
        })
    }
    
    func updateNickName(nickName : String) -> Promise<[String:Any]> {
        
        return Promise.init(resolvers: { ( resolve, reject ) in
            
            sendRequest(target: FCMeApiService.updateNickName(nickName: nickName))
                .mapDictionary()
                .subscribe(onNext: {
                    resolve($0)
                }, onError: {
                    reject($0)
                })
                .disposed(by: self.disposeBag)
        })
        
    }
    
    
    
}
