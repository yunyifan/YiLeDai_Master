//
//  RepayDueModel.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/15.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepayDueModel : NSObject

@property (nonatomic,strong)NSString *dueCapi; //应还本金
@property (nonatomic,strong)NSString *dueInte; //应还利息
@property (nonatomic,strong)NSString *dueOtherfee; //应还其他费用
@property (nonatomic,strong)NSString *dueSum; //应还总计
@property (nonatomic,strong)NSString *dueDate; //应还日期
@property (nonatomic,strong)NSString *dueTerm; //应还期次
@end

NS_ASSUME_NONNULL_END
