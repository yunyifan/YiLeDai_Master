//
//  RecordDetialLoanView.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/11.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RecordDetialLoanViewDelegate <NSObject>

-(void)recordDetialLoanButtonClick:(NSInteger)butTag;

@end

@interface RecordDetialLoanView : BaseView

@property (nonatomic,assign)RecordType detialRecordType;

@property (nonatomic,weak)id <RecordDetialLoanViewDelegate> delegate;

-(instancetype)initWithType:(RecordType)recordType;

-(void)setRedordViewData;

@end

NS_ASSUME_NONNULL_END
