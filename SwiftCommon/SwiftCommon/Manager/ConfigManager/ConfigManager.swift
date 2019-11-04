//
//  ConfigManager.swift
//  SwiftDemo
//
//  Created by haoran on 2018/1/25.
//  Copyright © 2018年 xuhaoran. All rights reserved.
//

import UIKit
import Foundation

//MARK: NetWork

//0:开发环境(.net) 1:测试环境(.cn) 2:生产环境(.com)



#if PRO // 正式环境
    
    /// 账号
let accountServerDomain                 = "https://api.fclassroom.com/account/"
    /// 试卷
let examServerDomain                    = "https://api.fclassroom.com/exam/"
    /// 报表
let reportDomain                        = "https://api.fclassroom.com/report/"
    /// 消息
let msgDomain                           = "https://msg-api.fclassroom.com/"
    /// 日志
let logDomain                           = "https://log-api.fclassroom.com/"
    /// 家庭
let familyDoamin                        = "https://api.fclassroom.com/family/"
    /// 家长端
let HTML5Domain                         = "https://teacher.fclassroom.com/"
    /// 家长端
let notificationDomain                  = "https://push-api.fclassroom.com/"
    /// mis
let misDomain                           = "https://mis.fclassroom.com/"
   
#endif

#if DEV // 开发环境

    /// 账号
let accountServerDomain                 = "https://api.fclassroom.net/account/"
    /// 试卷
let examServerDomain                    = "https://api.fclassroom.net/exam/"
    /// 报表
let reportDomain                        = "https://api.fclassroom.net/report/v2/"
    /// 消息
let msgDomain                           = "https://msg-api.fclassroom.net/"
    /// 日志
let logDomain                           = "https://log-api.fclassroom.net/"
    /// 家庭
let familyDoamin                        = "https://api.fclassroom.net/family/"
    /// 家长端
let HTML5Domain                         = "https://teacher.fclassroom.net/app/"
    /// 家长端
let notificationDomain                  = "https://push-api.fclassroom.net/"
    /// mis
let misDomain                           = "https://misv2.fclassroom.net/"
    

#endif

#if SIT // 测试环境

/// 账号
let accountServerDomain                 = "https://apixqtk.fclassroom.cn/account/"
    /// 试卷
let examServerDomain                    = "https://apixqtk.fclassroom.cn/exam/"
    /* 新版本的report服务需要加v2 report v2环境中加了一些新接口 */
    /* 新版本目前只有这一个接口learning/clzssscoreinfo 是在v2环境*/
    /// 报表
let reportDomain                        = "https://apixqtk.fclassroom.cn/report/"
    /// 消息
let msgDomain                           = "https://msgxqtk-api.fclassroom.cn/"
    /// 日志
let logDomain                           = "https://logxqtk-api.fclassroom.cn/"
    /// 家庭
let familyDoamin                        = "https://apixqtk.fclassroom.cn/family/"
    /// 教师端
let HTML5Domain                         = "http://teacherxqtk.fclassroom.cn/"
    /// 家长端
let notificationDomain                  = "https://pushxqtk-api.fclassroom.cn/"
    /// mis
let misDomain                           = "https://misxqtk.fclassroom.cn/"

    
#endif


// 账号切换服务器策略 审核专用 如果账号为`reviewingAccount` 则切换为对应服务器地址

/// 审核账户
let reviewingAccount                    = "dingxiao123"
/// 账号
let reviewingAccountServerDomain        = "https://account-api.fclassroom.cn/"
/// 试卷
let reviewingExamServerDomain           = "https://exam-api.fclassroom.cn/"
/// 报表
let reviewingReportDomain               = "https://report-api.fclassroom.cn/"
/// 消息
let reviewingMsgDomain                  = "https://msg-api.fclassroom.cn/"
/// 日志
let reviewingLogDomain                  = "https://log-api.fclassroom.cn/"
/// 家庭
let reviewingFamilyDoamin               = "https://teacher.fclassroom.cn/app/"
/// 家长端
let reviewingHTML5Domain                = "https://teacher.fclassroom.cn/app/"
/// 家长端
let reviewingNotificationDomain         = "https://push-api.fclassroom.cn/"


//MARK: 颜色
let NavigationBarColor                  = UIColor(red: 66, green: 133, blue: 244)
let BorderColor                         = UIColor(red: 238, green: 238, blue: 238)
let Blue_COLOR_Unenable                 = UIColor(red: 52, green: 109, blue: 241)
let Blue_COLOR                          = UIColor(red: 72, green: 107, blue: 231)
let Blue_COLOR_Forget                   = UIColor(red: 81, green: 141, blue: 235)
let Gray_COLOR                          = UIColor(red: 243, green: 243, blue: 243)
let COLOR_NavigationBar                 = UIColor(red: 66, green: 133, blue: 244)



//MARK: UI
let kScreenWidth                        = UIScreen.main.bounds.width
let kScreenHeight                       = UIScreen.main.bounds.height


//MARK: Notification
extension Notification.Name {
    
    /// 用户状态变更
    static let UserStatusHasChanged     = Notification.Name("UserStatusHasChangedNoti")
    
    /// 无法识别的scheme
    static let UnSupportScheme          = Notification.Name("UnSupportSchemeNoti")
    
    /// 无法识别的host
    static let UnSupportHost            = Notification.Name("UnSupportHostNoti")
    
}
