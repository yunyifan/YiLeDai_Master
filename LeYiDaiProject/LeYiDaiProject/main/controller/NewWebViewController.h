//
//  NewWebViewController.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/30.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewWebViewController : BaseViewController

@property (nonatomic,assign) NSInteger typeIndex; //1.综合授权书 2.借款协议 3.权益服务协议 4，委托扣款协议 5.用户协议 6.注册协议 7.隐私协议

@property (nonatomic,strong)NSString *loanMoneyStr; // 借款金额
@end

NS_ASSUME_NONNULL_END
