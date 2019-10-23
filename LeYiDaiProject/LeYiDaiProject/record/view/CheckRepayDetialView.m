//
//  CheckRepayDetialView.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/22.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "CheckRepayDetialView.h"

@interface CheckRepayDetialView ()

@property (nonatomic,strong)UILabel *titLab;
@property (nonatomic,strong)UIButton *cancleBut;
@property (nonatomic,strong)UILabel *lineView;

@end
@implementation CheckRepayDetialView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initDetailUI];
    }
    return self;
}
-(void)initDetailUI{
    
    [self addSubview:self.titLab];
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    [self addSubview:self.cancleBut];
    [self.cancleBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(80);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancleBut.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
//        make.bottom.mas_equalTo(-10);
    }];
}
-(void)creatArrayLable:(NSArray *)titArray{
    
    UILabel *lastLab;
    for (int i = 0; i<titArray.count; i++) {
        UILabel *lable = [[UILabel alloc] init];
        lable.textColor = Tit_Gray_Color;
        lable.font = FONT(14);
        [lable setAttributedText:titArray[i]];
        [self addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.height.mas_equalTo(40);
            if (lastLab) {
                make.top.equalTo(lastLab.mas_bottom);
            }else{
                make.top.equalTo(self.lineView.mas_bottom);
            }
        }];
        
        lastLab = lable;
        
    }
    
    [lastLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
    }];
    
}

-(void)cancleButtonCLick{
    [YSSModelDialog hideView];
}
-(UILabel *)titLab{
    if (!_titLab) {
        _titLab = [[UILabel alloc] init];
        _titLab.font = FONT(14);
        _titLab.backgroundColor = [UIColor colorWithHex:@"#F6F6F6"];
        _titLab.text = @"还款计划";
        _titLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titLab;
}
-(UIButton *)cancleBut{
    if (!_cancleBut) {
        _cancleBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBut.titleLabel.font = FONT(15);
        [_cancleBut setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBut setTitleColor:Tit_Gray_Color forState:UIControlStateNormal];
        [_cancleBut addTarget:self action:@selector(cancleButtonCLick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBut;
}
-(UILabel *)lineView{
    if (!_lineView) {
        _lineView = [[UILabel alloc] init];
        _lineView.backgroundColor = Line_Color;
    }
    return _lineView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
