//
//  MainDetianModel.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/6.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface LoanRepayDueModel : NSObject
@property (nonatomic,assign)int overFlag; // 0：逾期 1：未逾期

@property (nonatomic,assign)NSString * dueTermSum; // 贷款总期次
@property (nonatomic,assign)NSString * dueTerm; //贷款期次
@property (nonatomic,strong)NSString *dueDate; // 应还日期
@property (nonatomic,strong)NSString *dueAmt; // 应还总额
@property (nonatomic,assign)NSString * overDays; // 逾期天数
@end

@interface CreaditInfoModel : NSObject

@property (nonatomic,strong)NSString *creditAppstate; // 0：待审 1：通过 9：拒绝
@property (nonatomic,strong)NSString *creditAppstate_dictText; // 审批状态值
@property (nonatomic,strong)NSString *creditLeftamt; //剩余额度
@property (nonatomic,strong)NSString *creditLimit; // 审批额度
@property (nonatomic,strong)NSString *creditRemarks;
@property (nonatomic,strong)NSString *creditTerm; // 审批期限
@property (nonatomic,strong)NSString *creditUsedamt; //已用额度
@property (nonatomic,assign)NSString *inteRate; // 利率

@end



@interface MainDetianModel : NSObject

@property (nonatomic,assign)int userState; //1.未认证（creditInfo）2.认证中，认证信息未填写完（creditInfo） 3.认证资料填写完成，等待授信中(creditInfo) 4.已授信未借款（可能未通过）(creditInfo)5.已借款未放款 (creditInfo)6.放款中 (creditInfo,repayInfo)

@property (nonatomic,strong)CreaditInfoModel *creditInfo;

@property (nonatomic,strong)LoanRepayDueModel *loanRepayDue;
@end

NS_ASSUME_NONNULL_END
