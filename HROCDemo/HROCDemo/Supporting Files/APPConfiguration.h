//
//  APPConfiguration.h
//  HROCDemo
//
//  Created by Wang Hai Long (wanghailong096@sunfit.cn)  on 05/02/2017.
//  Copyright © 2017 RJS. All rights reserved.
//

// 声明 项目的配制信息和一些全局枚举等

typedef NS_ENUM(NSInteger, NXLoanType) {
    NXLoanTypeXinDiDai                          = 201,      // 鑫抵贷
    NXLoanTypeXinXinDai                         = 203,      // 鑫信贷
    NXLoanTypeCheYiDai                          = 99201,    // 新车易贷
};

typedef NS_ENUM(NSInteger, XFInfoUploadImageVCType) {
    XFInfoUploadImageVCTypeShopHoseInfo             = 1,    // 1：房产资料
    XFInfoUploadImageVCTypeCarReg                   = 2,    // 2: 车辆登记证
    XFInfoUploadImageVCTypeCompulsoryInsurance      = 3,    // 3: 交强险保单合同
    XFInfoUploadImageVCTypeCommercialInsurance      = 4,    // 4: 商业险保单合同
    XFInfoUploadImageVCTypeWorkCertification        = 5,    // 5: 工作证明
    XFInfoUploadImageVCTypeCreditReport             = 6,    // 6: 央行征信报告
    XFInfoUploadImageVCTypeEnterpriseInfo           = 7,    // 7: 企业资料
    XFInfoUploadImageVCTypeSalaryReport             = 8,    // 8: 收入证明
    XFInfoUploadImageVCTypeCarPhoto                 = 9,    // 9: 车辆照片
    XFInfoUploadImageVCTypeCarVideo                 = 10,   // 10:车辆视频
    XFInfoUploadImageVCTypeDrivingLicenseVicePhoto  = 11,   // 11:行驶证副页
    
    XFInfoUploadImageVCTypeIDCardFront              = 12,   // 12：身份证正面
    XFInfoUploadImageVCTypeIDCardBack               = 13,   // 13:身份证背面
    XFInfoUploadImageVCTypeDrivingLicenseFront      = 14,   // 14: 行驶证主页
    XFInfoUploadImageVCTypeCarLoanStatement         = 16,   // 16:车辆按揭流水
    XFInfoUploadImageVCTypeAccountStatement         = 15,   // 15:账单流水
    XFInfoUploadImageVCTypeInsuranceDetail          = 17,   // 17: 社保/公积金明细
    XFInfoUploadImageVCTypeBankAccountStatement     = 18,   // 18:银行流水
    XFInfoUploadImageVCTypeBusinessLicence          = 19,   // 19:营业执照
    XFInfoUploadImageVCTypeRentContract             = 20,   // 20:租赁合同
    XFInfoUploadImageVCTypeLetterOfCredit           = 21,   // 21:征信授权书
    XFInfoUploadImageVCTypeShareholderInfo          = 22,   // 22:股东资料
    XFInfoUploadImageVCTypeFieldTripsInfo           = 23,   // 23:实地考察资料
    XFInfoUploadImageVCTypeShareholderMeeting       = 24,   // 24:股东会决议
    XFInfoUploadImageVCTypeShareholderStatement     = 25,   // 25:股东声明书
    XFInfoUploadImageVCTypeShareholderIDCard        = 26,   // 26:签名股东身份证复印件
    
    XFInfoUploadImageVCTypeLoanTermsInformation     = 27,   // 27:放款条件资料
    XFInfoUploadImageVCTypePledgeRegistrationForm   = 28,   // 28:押品登记表
    XFInfoUploadImageVCTypeFinancingRentContract    = 29,   // 29:融资租赁合同
    XFInfoUploadImageVCTypeVehicleSalesContract     = 30,   // 30:车辆买卖合同
    XFInfoUploadImageVCTypeGuarantyContract         = 31,   // 31:保证合同
    XFInfoUploadImageVCTypeMortgageContract         = 32,   // 32:抵押合同
    XFInfoUploadImageVCTypeRentObjectConfirmation   = 33,   // 33:租赁物件接收确认书
    XFInfoUploadImageVCTypeRentObjectRemissionConfirmation   = 34,   // 34:租赁物返还同意书件
    XFInfoUploadImageVCTypeServiceChargeInsuranceAcceptance   = 35,   // 35:服务费及保险费承诺函
};

typedef NS_ENUM(NSInteger, XFInfoUploadImageWithSubType) {
    XFInfoUploadImageWithSubTypeShopHouseInfo       = 1,    // 1：房产资料
    XFInfoUploadImageWithSubTypeJobCertification    = 5,    // 5: 工作证明
    XFInfoUploadImageWithSubTypeEnterpriseData      = 7,    // 7: 企业资料
    XFInfoUploadImageWithSubTypeIncomeSource        = 8,    // 8: 收入证明
    XFInfoUploadImageWithSubTypeAccountStatement    = 15,   // 15:账单流水
    XFInfoUploadImageWithSubTypeInsuranceDetail     = 17    // 17: 社保/公积金明细
};

typedef NS_ENUM(NSUInteger, XFInfoCellImageMode){
    
    XFInfoCellImageModeNormal   = 1,
    XFInfoCellImageModeNoImage  = 2
};

typedef NS_ENUM(NSUInteger, XFTextInputCellType){
    
    XFTextInputCellTypePlain        = 1,
    XFTextInputCellTypeArrowImg     = 2,
    XFTextInputCellTypeUnit         = 3

// 声明 项目的配制信息和一些全局枚举等 
};

//红包广场-红包状态
typedef NS_ENUM(NSInteger, RedEnvelopeStatus) {
    Available,              //可领取，展示打开按钮
    NotQualified,           //不可领取-无资格，展示锁按钮
    HasNotStarted,          //不可领取-未开始，展示锁按钮
    HasBeenReceived,        //已领取，展示详情
    HasFinished,            //已领完（本版本不用）
    Over                    //未领取已结束，展示详情
};

//钱包流水类型
typedef NS_ENUM (NSInteger, WalletFlowType) {
    FlowTypeIncome,         //收入
    FlowTypeOutlay,         //支出
};

//一级身份 借款人  客户经理
typedef NS_ENUM(NSUInteger, DDTUserType) {
    /** 未知模式 */
    DDTUserTypeUndefined    = 0,
    /** 借款人模式 */
    DDTUserTypeBorrower     = 1,
    /** 客户经理模式 */
    DDTUserTypeManager      = 2
};

//二级身份 1-纳鑫达人 2-纳鑫战士 3-客户经理 4-团队经理
typedef NS_ENUM(NSUInteger, NXSubUserType) {
    /** 1-纳鑫达人 */
    NXSubUserTypeNXDR = 1,
    /** 2-纳鑫战士 */
    NXSubUserTypeNXZS = 2,
    /** 3-客户经理 */
    NXSubUserTypeKHJL = 3,
    /** 4-团队经理 */
    NXSubUserTypeTDJL = 4,
};


