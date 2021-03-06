
//
//  SearchViewModel.swift
//  Rx多线程
//
//  Created by haoran on 2018/4/11.
//  Copyright © 2018年 Xuhaoran. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxAlamofire
import ObjectMapper

class SearchViewModel {
    
   
    lazy var rx_repositories: Driver<[Repository]> = self.fetchRespositories()
    
    fileprivate var repositoryName: Observable<String>
    
    init(searchText nameObservable: Observable<String>) {
        self.repositoryName = nameObservable
    }
    
    
    fileprivate func fetchRespositories() -> Driver<[Repository]>{
        
        // 然后发起网络请求，正常的写法那就是这样:
        return repositoryName.subscribeOn(MainScheduler.instance) // 确保在主线程
            .do(onNext: { (response) in
                // 转菊花
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            })
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMapLatest({ (text)  in
                return RxAlamofire
                    .requestJSON(.get, "https://api.github.com/users/\(text)/repos")
                    .debug()
                    .catchError{ error in
                        return Observable.never()
                }
            })
            // 我们要确保网络请求和json解析在后台线程运行，所以使用observeOn主动切换线程
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map({ (response, json) -> [Repository] in
                // json解析放到后台线程中执行
                if let repos = Mapper<Repository>().mapArray(JSONObject: json){
                    return repos
                }else{
                    return []
                }
            })
            .observeOn(MainScheduler.instance) // 切换回主线程 刷新UI switch to MainScheduler , updates UI
            .do(onNext: { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            .asDriver(onErrorJustReturn: [])
        // 把输入的文字转成网络请求序列，然后对请求的结果进行map转成Repository数组，最后返回。这里使用了Driver保证回到主线程，并不抛出错误。
    }
    
    
    
    
}
