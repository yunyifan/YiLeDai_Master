//
//  RepaymentTableViewCell.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/26.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepaymentTableViewCell : BaseTableViewCell
@property (nonatomic,strong)FSCustomButton *checkDetialBut; // 查看具体详情
@property (nonatomic,strong)UIButton *selectBut;

@end

NS_ASSUME_NONNULL_END
