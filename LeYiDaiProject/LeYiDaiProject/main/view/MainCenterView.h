//
//  MainCenterView.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/11.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseView.h"
#import "MainDetianModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainCenterView : BaseView
-(instancetype)initWithMainType:(NSInteger)typeIndex;

@property (nonatomic,assign)NSInteger type;  //0 默认没有借过钱
@property (nonatomic,strong)UIButton *statueBut;

@property (nonatomic,strong)MainDetianModel *creaditInfoModel;
@end

NS_ASSUME_NONNULL_END
