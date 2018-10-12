//
//  APIURL.h
//  HROCDemo
//
//  Created by Jeremy Pan on 16/7/14.
//  Copyright © 2018年 XHR. All rights reserved.
//

#ifndef APIURL_h
#define APIURL_h

#if   SIT
#define kNetPath_Base                                       @"http://172.16.88.45:8989/nxhd"
#define kWebNetPath_Base                                    @"http://172.16.88.167:8447"

#elif UAT
#define kNetPath_Base                                       @"http://172.16.88.46:3939/nxhd"
#define kWebNetPath_Base                                    @"http://172.16.88.168:8447"

#elif PRO
#define kNetPath_Base                                       @"http://japi.xiangfajr.com/nxhd"
#define kWebNetPath_Base                                    @"http://newm.xiangfajr.com/nxhd"
#endif


#define kNetPath_UploadAvatar                               @"v1/user/uploadAvatar.json"                                    //个人中心头像上传
#define kNetPath_PersonalCenterInfo                         @"v1/user/getUserHomePageInfo.json"                             //个人中心信息
#define kNetPath_AuthCardNo                                 @"v1/user/authCardNo.json"                                      //实名认证
#define kNetPath_AuthPlatform                               @"v1/user/authEmpNo.json"                                       //平台认证
#define kNetPath_AllMessage                                 @"v1/message/getAllMessage.json"                                //我的消息列表
#define kNetPath_ReadMessage                                @"v1/message/readMsg.json"                                      //读取一条消息
#define kNetPath_DeleteMessage                              @"v1/message/deleteMsg.json"                                    //删除一条消息
#define kNetPath_SetAllMessageReaded                        @"v1/message/setRead.json"                                      //全部编辑已读
#define KNetPath_MessageUnreadCount                         @"v1/message/getUnRead.json"                                    //未读消息数量
#define KNetPath_QueryRepayRemind                           @"v1/repaymeRemind/queryRepaymRemind.json"                      //查询还款提醒
#define kNetPath_SetRepayRemind                             @"v1/repaymeRemind/setRepaymRemind.json"                        //设置还款提醒
#define kNetPath_DelRepayRemind                             @"v1/repaymeRemind/delRepaymRemind.json"                        //删除还款提醒
#define kNetPath_AuthResult                                 @"v1/user/authResult.json"                                      //认证查询（实名，平台）

#define kNetPath_HomeInfo                                   @"v1/user/getHomePageData.json"                                 //新首页信息
#define kNetPath_AutoLoansManagerNearHere                   @"v1/creditSquare/aroundLoanOfficers.json"                      //附近车贷员列表数据
#define kNetPath_AllAutoLoansManager                        @"v1/creditSquare/showCreditOfficer.json"                       //车贷员广场列表数据
#define KNetPath_UserLocationInfo                           @"v1/user/updateLongAndLat.json"                                //用户经纬度
#define kNetPath_BusinessCardInfo                           @"v1/creditSquare/seeCreditOfficerBusinessCardInfo.json"        //车贷员个人名片
#define kNetPath_AutoLoansManagerProducts                   @"v1/creditSquare/seeCreditOfficerProducts.json"                //车贷员个人产品列表
#define kNetPath_GetOrdersArea                              @"v1/list/listArea.json"                                        //抢单专区
#define kNetPath_GetOrdersAction                            @"v1/list/robList.json"                                         //抢单Action
#define kNetPath_GetOrders_DetailInfo                       @"v1/list/robListDetail.json"                                   //抢单详情
#define kNetPath_PostOrdersArea                             @"v1/list/rejectionArea.json"                                   //甩单专区
#define kNetPath_CheckBeforePostOrdersAction                @"v1/list/rejectionCheck.json"                                  //甩单之前的检查
#define kNetPath_PostOrdersAction                           @"v1/list/rejection.json"                                       //甩单动作
#define kNetPath_PostOrders_DetailInfo                      @"v1/list/rejectionDetails.json"                                //甩单详情
#define kNetPath_PostOrderArea_GetAction                    @"v1/list/receiveList.json"                                     //甩单专区收单
#define kNetPath_AutoLoansProductList                       @"v1/creditSquare/loanProducts.json"                            //车贷产品列表


#define kNetPath_OrdersAreaRootPage                         @"v1/list/listHome.json"                                        //单子模块首页
#define kNetPath_LoansReleaseList                           @"v1/list/loanList.json"                                        //我发布的贷款列表
#define kNetPath_MyRobbedOrdersList                         @"v1/list/myRobedList.json"                                     //我抢到的单子列表
#define kNetPath_MyPostOrdersList                           @"v1/list/myRejectionList.json"                                 //我甩出的单子列表
#define kNetPath_MyReceiveOrdersList                        @"v1/list/myReceiveList.json"                                   //我收到的单子列表
#define kNetPath_ConfirmLoanSuccessAuth                     @"v1/loan/confirmLoanSuccAuth.json"                             //确认放款认证请求
#define kNetPath_ConfirmLoanFailAuth                        @"v1/loan/confirmLoanFailAuth.json"                             //确认放款认证失败弹框提醒
#define kNetPath_SubmittedList                              @"v1/submittedList/queryLoanListV3.json"                        //我提交的单子-列表
#define kNetPath_SubmittedListLoanDetail                    @"v1/submittedList/loanDetail.json"                             //我提交的单子-单子详情
#define kNetPath_SubmittedListLoanDetailNew                 @"v1/submittedList/loanDetailV2.json"                           //我提交的单子-单子详情（new）
#define kNetPath_SubmittedListLoanDetails                   @"v1/submittedList/loanDetails.json"                            //我提交的单子-单子详情（不返回页面标签）


#define kNetPath_MyLoansReleaseDetailInfo                   @"v1/list/loanListDetail.json"                                  //我发布的贷款详情
#define kNetPath_ConfirmLoans                               @"v1/loan/confirmLoan.json"                                     //确认放款
#define kNetPath_RejectLoans                                @"v1/loan/cancel.json"                                          //我发布的贷款-撤销动作（审核中）
#define kNetPath_ReleaseAgain                               @"v1/loan/redeploy.json"                                        //我发布的贷款-再次发布
#define kNetPath_CloseLoans                                 @"v1/loan/close.json"                                           //我发布的贷款-关闭（抢单中）

#define kNetPath_MyCommission                               @"v1/performance/myPerformance.json"                            //我的提成
#define kNetPath_Leaderboard                                @"v1/performance/rankingsV2.json"                               //业界排行榜
#define kNetPath_UserSignin                                 @"v1/user/signIn.json"                                          //签到
#define kNetPath_UserSigninDetail                           @"v1/user/signInDetail.json"                                    //签到详情
#define kNetPath_CustomerManagementList                     @"v1/custLabManage/queryLabelList.json"                         //客户管理-列表
#define kNetPath_UploadCustomerPic                          @"v1/custManage/uploadCustomerPic.json"                         //新增客户-上传图片
#define kNetPath_CreateCustomer                             @"v1/custManage/createCustomer.json"                            //新增客户-提交
#define kNetPath_QueryCustomerInfo                          @"v1/custManage/queryCustomerInfo.json"                         //查询客户信息
#define kNetPath_EditCustomerInfo                           @"v1/custManage/editCustomer.json"                              //编辑客户信息
#define kNetPath_DeleteCustomer                             @"v1/custManage/delCustomer.json"                               //删除客户
#define kNetPath_QueryAllLabels                             @"v1/custLabManage/queryAllLabels.json"                         //查询我所有的标签
#define kNetPath_CreateLabel                                @"v1/custLabManage/createLabel.json"                            //新建标签组
#define kNetPath_EditLabel                                  @"v1/custLabManage/editLabel.json"                              //修改标签组名称
#define kNetPath_DeleteLabel                                @"v1/custLabManage/delLabel.json"                               //删除标签组

//#define kNetPath_DraftList                                  @"borrowerDraft/v1/draftList.json"                              //草稿录单列表
#define kNetPath_DeleteDraft                                @"borrowerDraft/v1/delDraft.json"                               //删除草稿
#define kNetPath_DraftCustomerInfo                          @"borrowerDraft/v1/customerInfo.json"                           //个人信息
#define kNetPath_DraftVehicleInfo                           @"borrowerDraft/v1/vehicleInfo.json"                            //车辆信息
#define kNetPath_DraftHouseInfo                             @"borrowerDraft/v1/houseInfo.json"                              //房产信息
#define kNetPath_DraftIncomeInfo                            @"borrowerDraft/v1/incomeInfo.json"                             //收入信息
#define kNetPath_DraftCardRecognition                       @"borrowerDraft/v1/cardRecognition.json"                        //身份证/驾驶证识别
#define kNetPath_DraftCompanyInfo                           @"borrowerDraft/v1/companyInfo.json"                            //公司信息
#define kNetPath_DraftEnterpriseInfo                        @"borrowerDraft/v1/enterpriseInfo.json"                         //企业信息
#define kNetPath_DraftRelativeInfo                          @"borrowerDraft/v1/relativeInfo.json"                           //配偶/直系亲属
#define kNetPath_DraftCarPhotoInfo                          @"borrowerDraft/v1/carInfo.json"                                //车辆照片Info


#define kNetPath_CallAction                                 @"v1/call/callBack.json"                                        //打电话
#define kNetPath_IMUserLogin                                @"v1/imUser/imUserLogin.json"                                   //环信登录
#define kNetPath_IMConversationInfo                         @"v1/imUser/getImUseInfo.json"                                  //对话双方个人信息
#define kNetPath_IMAddFriends                               @"v1/user/addFriends.json"                                      //添加好友
#define kNetPath_IMMyFriendsList                            @"v1/user/queryMyFriends.json"                                  //好友列表
#define kNetPath_IMSendBusinessCard                         @"v1/imUser/sendBusinessCard.json"                              //发送名片
#define kNetPath_IMGetUserInfoByEaseId                      @"v1/imUser/selectXiangfaUserInfoByImId.json"                   //根据环信ID获取用户信息


#define kNetPath_BindClient                                 @"v1/userPush/bindClient.json"                                  //绑定ClientId
#define kNetPath_UnBindClient                               @"v1/userPush/unBindClient.json"                                //解绑ClientId
#define kNetPath_Login                                      @"v1/user/loginV2.json"                                         //登录
#define kNetPath_Logout                                     @"v1/user/logout.json"                                          //退出登录
#define kNetPath_SendCode                                   @"v1/user/sendMsgCode.json"                                     //获取验证码
#define kNetPath_SendOldPhoneCode                           @"v1/user/sendPhoneCode.json"                                   //修改手机号码_原手机号验证码
#define kNetPath_UpdateUserPhoneNextStep                    @"v1/user/updateUserPhoneNextStep.json"                         //修改手机号码_下一步
#define kNetPath_SendNewPhoneCode                           @"v1/user/sendNewPhoneCode.json"                                //修改手机号码_新手机号验证码
#define kNetPath_UpdateUserPhone                            @"v1/user/updateUserPhone.json"                                 //修改手机号码_绑定
#define kNetPath_UpdatePasswordNextStep                     @"v1/user/updatePasswordNextStep.json"                          //修改登录密码_下一步
#define kNetPath_UpdatePassword                             @"v1/user/updatePassword.json"                                  //修改登录密码_绑定
#define kNetPath_CheckLoginStatus                           @"v1/user/checkLoginStatus.json"                                //登录状态验证


#define kNetPath_QueryVersion                               @"v1/vesion/queryVesion.json"                                   //版本检测
#define kNetPath_ItunesVersion                              @"https://itunes.apple.com/lookup?id="                          //AppStore更新
#define kNetPath_GoAppStore                                 @"https://itunes.apple.com/app/id"                              //跳转到应用商店
#define APP_ID                                              @"1255767714"                                                   //享发应用Id


#define kNetPath_CheckUpdate                                @"v1/appVer/checkUpdate.json"                                   //应用版本检测升级 - 新
#define kNetPath_CheckH5Update                              @"v1/pluginVer/checkH5Update.json"                              //H5版本检测升级 - 新


#define kNetPath_QueryVehicleBrandList                      @"v1/borrowerAudit/queryVehicleBrandList.json"                  //风控-车辆品牌查询接口
#define kNetPath_QueryVehicleSeriesList                     @"v1/borrowerAudit/queryVehicleSeriesList.json"                 //风控-车辆品牌对应车系查询接口

#define kNetPath_QuerySpecifiedVehicle                      @"v1/borrowerAudit/querySpecifiedVehicle.json"                 //风控-车辆品牌关键字搜索接口


#define kNetPath_GetQRUrl                                   @"v1/borrowerAudit/getQRUrl.json"                               //获取二维码图片的baseUrl

#define kNetPath_GetAllCollegue                             @"lockloan/v1/queryMyFriends.json"                              //查询我的同行
#define kNetPath_UpdateCollegueInfo                         @"lockloan/v1/updateMyFriends.json"                             //更新我的同行信息
#define kNetPath_SearchCollegue                             @"lockloan/v1/findFriends.json"                                 //查找同行
#define kNetPath_AddCollegue                                @"lockloan/v1/inviteCooperation.json"                           //邀请合作

#define kNetPath_GetShareLink                               @"v1/user/getShareLink.json"                                    //邀请好友获取二维码和邀请链接

#define kNetPath_GetMyIncome                                @"withdraw/v1/fundrecords.json"                                 //获取佣金详情
#define kNetPath_GetCollegueApply                           @"lockloan/v1/getRelationRecord.json"                           //申请合作列表
#define kNetPath_EnsureCollegueApply                        @"lockloan/v1/confirmRelationRecord.json"                       //同意申请

#define kNetPath_WithDraw                                   @"withdraw/v1/apply.json"                                       //申请提现


#define kNetPath_LockLoan                                   @"lockloan/v1/lock.json"                                        //锁单（转介绍）
#define kNetPath_LockLoanDetail                             @"lockloan/v1/applyBALoanDetails.json"                          //单子详情（锁单状态）
#define kNetPath_EnsureLoanRate                             @"lockloan/v1/confirmCommissionRate.json"                       //确认佣金比率
#define kNetPath_ChangeLoanRate                             @"lockloan/v1/chgCommissionRate.json"                           //更改佣金比率

#define kNetPath_CheckExistStaff                           @"v1/borrowerAudit/checkExistStaff.json"                     //客户经理信息


#endif /* APIURL_h */
