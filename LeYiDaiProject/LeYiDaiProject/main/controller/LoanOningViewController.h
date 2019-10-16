//
//  LoanOningViewController.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/17.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseViewController.h"
#import "BankDetialModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoanOningViewController : BaseViewController

@property (nonatomic,strong)NSDictionary *dataDic;

@property (nonatomic,strong)BankDetialModel *detailModel;
@end

NS_ASSUME_NONNULL_END
