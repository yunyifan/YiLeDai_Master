//
//  LoanDetialView.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/11.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoanDetialView : BaseView

@property (nonatomic,assign)RecordType detialRecordType;

-(instancetype)initWithType:(RecordType)recordType;

-(void)creatDetialUI:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
