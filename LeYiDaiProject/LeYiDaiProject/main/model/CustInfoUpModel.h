//
//  CustInfoUpModel.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/14.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustInfoUpModel : NSObject
@property (nonatomic,strong)NSString *custEducation; // 最高学历
@property (nonatomic,strong)NSString *custMarrsign; // 婚姻状况
@property (nonatomic,strong)NSString *custAreacode; // 省市县联动选择9位行政区域码
@property (nonatomic,strong)NSString *custAddr; // 住宅地址
@property (nonatomic,strong)NSString *relation1Mobile; // 第一联系人手机
@property (nonatomic,strong)NSString *relation1Name; // 第一联系人姓名
@property (nonatomic,strong)NSString *relation2Mobile    ; // 第二联系人手机
@property (nonatomic,strong)NSString *relation2Name; // 第二联系人姓名
@property (nonatomic,strong)NSString *custCorpration; // 单位名称
@property (nonatomic,strong)NSString *workAreacode    ; // 省市县联动选择9位行政区域码

@property (nonatomic,strong)NSString *workAddr; // 单位地址
@property (nonatomic,strong)NSString *custCorpkind    ; // 0：国企 1：私企 2：外企 3：其他

@property (nonatomic,strong)NSString *custJob    ; // 职位
@property (nonatomic,strong)NSString *custIncome; // 0：3000以下 1：3000-5000 2：5000-10000 3:1万以上

@end

NS_ASSUME_NONNULL_END
