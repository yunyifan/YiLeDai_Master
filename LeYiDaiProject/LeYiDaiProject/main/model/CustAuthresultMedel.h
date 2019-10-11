//
//  CustAuthresultMedel.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/10.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustAuthresultMedel : NSObject
@property (nonatomic,assign)int authSn; // 认证顺序号
@property (nonatomic,strong)NSString *authType; // 认证类型
@property (nonatomic,strong)NSString *authContent; // 认证内容
@property (nonatomic,assign)int authState; // 0：未认证 1：认证通过 9：认证未通过
@property (nonatomic,strong)NSString *authState_dictText; // 0：待审 1：通过 9：拒绝
@property (nonatomic,assign)int authIsvalid; // 00:是 1:否

@end

NS_ASSUME_NONNULL_END
