//
//  LoanDetialInfoModel.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/21.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface loanAccountInfoModel : NSObject

@property (nonatomic,strong)NSString * beginDate;

@property (nonatomic,strong)NSString *endDate;
@property (nonatomic,strong)NSString *loanAmount; //借款金额
@property (nonatomic,strong)NSString *retuKind;  //还款类型    0：一次性 1:分期还款

@property (nonatomic,strong)NSString *retuKind_dictText; //还款类值

@property (nonatomic,strong)NSString *realCapiSum; //已还本金总额
@property (nonatomic,strong)NSString *realInte; //已还利息总额
@property (nonatomic,strong)NSString *realFeeSum; //已还费用总额
@property (nonatomic,strong)NSString *dueCapiSum; //未还本金总额
@property (nonatomic,strong)NSString *dueInte; //未还利息总额
@property (nonatomic,strong)NSString *dueFeeSum; //未还费用总额    


@end



@interface LoanDetialInfoModel : NSObject

@property (nonatomic,strong)NSArray *LoanRepayTermList; // 还款计划/实还款记录

@property (nonatomic,assign)int lendState; //0:未通过（loanAccountInfo） 1.审批中（loanAccountInfo） 2.放款中（loanAccountInfo） 3.使用中（loanAccountInfo，LoanRepayTermList） 4.逾期（loanAccountInfo，LoanRepayTermList） 5.已结清
@property (nonatomic) loanAccountInfoModel *loanAccountInfo;  // 放款详情
@end

NS_ASSUME_NONNULL_END
