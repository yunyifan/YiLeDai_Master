//
//  BaseViewController.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/5.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIScrollView+EmptyDataSet.h"
#import "YLDDefine.h"
#import "LYDUtil.h"
#import "RequestAPI.h"

#import "LoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
-(void)backAction:(id)sender;

@property (nonatomic,strong)LoginModel *loginModel;
@end

NS_ASSUME_NONNULL_END
