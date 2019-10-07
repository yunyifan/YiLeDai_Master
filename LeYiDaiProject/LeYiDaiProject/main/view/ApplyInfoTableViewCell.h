//
//  ApplyInfoTableViewCell.h
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef void(^ApplyInfoTextFildCallBlock)(NSString * _Nonnull textStr);
NS_ASSUME_NONNULL_BEGIN

@interface ApplyInfoTableViewCell : BaseTableViewCell
@property (nonatomic,strong)UILabel *leftLab;

@property (nonatomic,strong)UITextField *textFiled;

@property (nonatomic,strong)UIImageView *arrrowImg;

@property (nonatomic,strong)UITextField *bottomTextFiled;

@property (nonatomic,assign)BOOL botttomTextIsHide;

@property (nonatomic,copy)ApplyInfoTextFildCallBlock textBack;
@end

NS_ASSUME_NONNULL_END
