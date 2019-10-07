//
//  MainAccationView.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/15.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "MainAccationView.h"

@interface MainAccationView ()

@end
@implementation MainAccationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"#FFEFD5"];
        [self initAccaView];
    }
    return self;
}
-(void)initAccaView{
    [self addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(21);
    }];
    
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(-6);
        make.left.equalTo(self.img.mas_right).offset(4);
        make.right.mas_equalTo(-28);
        
    }];
}
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mian_caveat"]];
    }
    return _img;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = FONT(12);
        _titleLab.textColor = [UIColor colorWithHex:@"#E65100"];
        _titleLab.numberOfLines = 0;
        
    }
    return _titleLab;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
