//
//  MianTopBlueView.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/12.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseView.h"
#import "MainDetianModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MianTopBlueView : BaseView

-(void)setBlueViewData:(MainDetianModel *)detialModel;

@property (nonatomic,strong)UIButton *payBut;

@end

NS_ASSUME_NONNULL_END
