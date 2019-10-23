//
//  BankDetialModel.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankDetialModel : NSObject

@property (nonatomic,strong)NSString *bankcardName; //所属银行
@property (nonatomic,strong)NSString *bankcardNo; //银行卡号
@property (nonatomic,strong)NSString *cardSignmobile;//签约手机号
@property (nonatomic,strong)NSString *cardState; //账号状态
@property (nonatomic,strong)NSString *cardType; //银行卡类型，1-借记卡，2-信用卡

@property (nonatomic,strong)NSString *custName;// 客户姓名
@property (nonatomic,strong)NSString *sysOrgCode; //
@property (nonatomic,strong)NSString *cardBankid; //开户机构码
@property (nonatomic,strong)NSString *cardBankname; //银行


@end

NS_ASSUME_NONNULL_END
