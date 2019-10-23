//
//  RepaySelectBankView.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/22.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RepaySelectBankView.h"

@interface RepaySelectBankView ()

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UILabel *titLab;
@property (nonatomic,strong)UIButton *cancleBut;
@property (nonatomic,strong)UILabel *topLine;

@property (nonatomic,strong)UILabel *desLab;
@property (nonatomic,strong)UILabel *centerLine;
@end

@implementation RepaySelectBankView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [self creatDetailUI];
    }
    return self;
}
-(void)creatDetailUI{
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(368);
    }];
    
    
    [self.bgView addSubview:self.titLab];
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    [self.bgView addSubview:self.cancleBut];
    [self.cancleBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titLab);
        make.right.mas_equalTo(-15);
        make.height.width.mas_equalTo(50);
    }];
    
    [self.bgView addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.titLab.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.bgView addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.topLine).offset(33);
    }];
    
    [self.bgView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(27);
        make.top.equalTo(self.moneyLab.mas_bottom).offset(40);
    }];
    
    [self.bgView addSubview:self.bankNum];
    [self.bankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.desLab);
        make.right.mas_equalTo(-30);
    }];
     
    [self.bgView addSubview:self.centerLine];
    [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankNum.mas_bottom).offset(15);
        make.left.mas_equalTo(14);
        make.right.mas_equalTo(-14);
        make.height.mas_equalTo(1);
    }];
    
    [self.bgView addSubview:self.repayBut];
    [self.repayBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(self);
        make.height.mas_equalTo(45);
    }];
    
}
-(void)cancleButtonClick{
    
    [self removeFromSuperview];
}
-(UIView *)bgView{
    if (!_bgView ) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(UILabel *)titLab{
    if (!_titLab) {
        _titLab = [[UILabel alloc] init];
        _titLab.font = FONT(17);
        _titLab.textColor = [UIColor blackColor];
        _titLab.text = @"确认付款";
    }
    return _titLab;
}
-(UIButton *)cancleBut{
    if (!_cancleBut) {
        _cancleBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBut.titleLabel.font = FONT(15);
        [_cancleBut setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancleBut addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBut;
}

-(UILabel *)topLine{
    if (!_topLine) {
        _topLine = [[UILabel alloc] init];
        _topLine.backgroundColor = Line_Color;
    }
    return _topLine;
}
-(UILabel *)moneyLab{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.textColor = [UIColor blackColor];
        _moneyLab.font = BOLDFONT(30);
    }
    return _moneyLab;
}
-(UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.font = FONT(14);
        _desLab.textColor = [UIColor colorWithHex:@"#999999"];
        _desLab.text = @"还款账户";

    }
    return _desLab;
}
-(UILabel *)centerLine{
    if (!_centerLine) {
        _centerLine = [[UILabel alloc] init];
        _centerLine.backgroundColor = Line_Color;

    }
    return _centerLine;
}
-(FSCustomButton *)bankNum{
    if (!_bankNum) {
        _bankNum = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        _bankNum.buttonImagePosition = FSCustomButtonImagePositionRight;
        _bankNum.adjustsButtonWhenHighlighted = NO;
        _bankNum.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);

        _bankNum.titleLabel.font = FONT(14);
        [_bankNum setImage:[UIImage imageNamed:@"cell_arrow"] forState:UIControlStateNormal];
        [_bankNum setTitle:@"招商银行" forState:UIControlStateNormal];
        [_bankNum setTitleColor:Tit_Black_Color forState:UIControlStateNormal];
    }
    return _bankNum;
}
-(UIButton *)repayBut{
    if (!_repayBut) {
        _repayBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _repayBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];
        [_repayBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _repayBut.layer.shadowOffset = CGSizeMake(0, 2);
        _repayBut.layer.shadowOpacity = 1;
        _repayBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
        _repayBut.layer.shadowRadius = 9;
        _repayBut.titleLabel.font = BOLDFONT(18);
        _repayBut.timeInterval = 5;
        [_repayBut setTitle:@"立即还款" forState:UIControlStateNormal];

    }
    return _repayBut;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
