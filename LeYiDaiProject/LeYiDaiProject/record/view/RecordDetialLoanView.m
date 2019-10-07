//
//  RecordDetialLoanView.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/11.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RecordDetialLoanView.h"

@interface RecordDetialLoanView ()

/**
 放款中
 */
@property (nonatomic,strong)UILabel *moanyLab;
@property (nonatomic,strong)UILabel *payTypeLab;
@property (nonatomic,strong)UILabel *moanyLabData;
@property (nonatomic,strong)UILabel *payTypeLabData;


/**
 使用中
 */
@property (nonatomic,strong)UIImageView *oneArrImg;
@property (nonatomic,strong)UIImageView *twoArrImg;
@property (nonatomic,strong)UIButton *planBut;
@property (nonatomic,strong)UIButton *reepaymentBut;
@end

@implementation RecordDetialLoanView

-(instancetype)initWithType:(RecordType)recordType{
    self = [super init];
    if (self) {
        self.detialRecordType = recordType;
        if (recordType == RecordTypeLoanning) {
            [self creatLoanUI];

        }else if (recordType == RecordTypeUseing){
            [self creatUseingUI];
        }
    }
    
    return self;
}
-(void)setRedordViewData{
    if (self.detialRecordType == RecordTypeLoanning) {
        self.moanyLab.text = @"借款金额";
        self.payTypeLab.text = @"还款方式";
        self.moanyLabData.text = @"1000.00";
        self.payTypeLabData.text = @"共分两期还款";
    }else if (self.detialRecordType == RecordTypeUseing){
        self.moanyLab.text = @"查看还款计划";
        self.payTypeLab.text = @"去还款";
        self.moanyLabData.text = @">";
        self.payTypeLabData.text = @">";
    }
    
}
-(void)buttonClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(recordDetialLoanButtonClick:)] && self.delegate) {
        [self.delegate recordDetialLoanButtonClick:sender.tag];

    }
}
/**
 放款中
 */
-(void)creatLoanUI{
    
    [self addSubview:self.moanyLab];
    [self.moanyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(19);
    }];
    
    [self addSubview:self.payTypeLab];
    [self.payTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.left.equalTo(self.moanyLab);
    }];
    
    [self addSubview:self.moanyLabData];
    [self.moanyLabData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moanyLab);
        make.right.mas_equalTo(-15);
    }];
    
    [self addSubview:self.payTypeLabData];
    [self.payTypeLabData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payTypeLab);
        make.right.equalTo(self.moanyLabData);
    }];
}

/**
 使用中
 */
-(void)creatUseingUI{
    [self addSubview:self.moanyLab];
    [self.moanyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(19);
    }];
    
    [self addSubview:self.payTypeLab];
    [self.payTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.left.equalTo(self.moanyLab);
    }];
    
    [self addSubview:self.oneArrImg];
    [self.oneArrImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moanyLab);
        make.right.mas_equalTo(-15);
    }];
    
    [self addSubview:self.twoArrImg];
    [self.twoArrImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payTypeLab);
        make.right.equalTo(self.oneArrImg);
    }];
    
    [self addSubview:self.planBut];
    [self.planBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    [self addSubview:self.reepaymentBut];
    [self.reepaymentBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(50);
    }];
}
-(UILabel *)moanyLab{
    if (!_moanyLab) {
        _moanyLab = [[UILabel alloc] init];
        _moanyLab.font = FONT(14);
        _moanyLab.textColor = Tit_Black_Color;
    }
    return _moanyLab;
}
-(UILabel *)payTypeLab{
    if (!_payTypeLab) {
        _payTypeLab = [[UILabel alloc] init];
        _payTypeLab.font = FONT(14);
        _payTypeLab.textColor = Tit_Black_Color;
    }
    return _payTypeLab;
}
-(UILabel *)moanyLabData{
    if (!_moanyLabData) {
        _moanyLabData = [[UILabel alloc] init];
        _moanyLabData.font = FONT(13);
        _moanyLabData.textColor = Tit_Gray_Color;
    }
    return _moanyLabData;
}
-(UILabel *)payTypeLabData{
    if (!_payTypeLabData) {
        _payTypeLabData = [[UILabel alloc] init];
        _payTypeLabData.font = FONT(13);
        _payTypeLabData.textColor = Tit_Gray_Color;
    }
    return _payTypeLabData;
}
-(UIImageView *)oneArrImg{
    if (!_oneArrImg) {
        _oneArrImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
    }
    return _oneArrImg;
}
-(UIImageView *)twoArrImg{
    if (!_twoArrImg) {
        _twoArrImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
    }
    return _twoArrImg;
}
-(UIButton *)planBut{
    if (!_planBut) {
        _planBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _planBut.tag = 1;
        [_planBut addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _planBut;
}
-(UIButton *)reepaymentBut{
    if (!_reepaymentBut) {
        _reepaymentBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _reepaymentBut.tag = 2;
        [_reepaymentBut addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reepaymentBut;
}
@end
