//
//  BankTableViewCell.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/7.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BankDetialModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BankTableViewCell : BaseTableViewCell

-(void)setCellData:(BankDetialModel *)model;

@end

NS_ASSUME_NONNULL_END
