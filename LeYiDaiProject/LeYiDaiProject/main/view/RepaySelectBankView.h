//
//  RepaySelectBankView.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/22.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepaySelectBankView : BaseView

@property (nonatomic,strong)FSCustomButton *bankNum; // 银行账户
@property (nonatomic,strong)UIButton *repayBut; // 立即还款
@property (nonatomic,strong)UILabel *moneyLab;

@end

NS_ASSUME_NONNULL_END
