//
//  MianTopBlueView.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/12.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "MianTopBlueView.h"

@interface MianTopBlueView ()

@property (nonatomic,strong)UIImageView *bgImg;
@property (nonatomic,strong)UILabel *titLab; // 最近还款
@property (nonatomic,strong)UILabel *moneyLab; // 还款金额
@property (nonatomic,strong)UILabel *bottomLab; // 代还日
@property (nonatomic,strong)UILabel *timeLab;
@end
@implementation MianTopBlueView
-(instancetype)init{
    self = [super init];
    if (self) {
        
        [self creatInitUI];
    }
    return self;
}
-(void)setBlueViewData:(MainDetianModel *)detialModel{
    
    self.titLab.text = [NSString stringWithFormat:@"最近待还款%@/%@",EMPTY_IF_NIL(detialModel.loanRepayDue.dueTerm),EMPTY_IF_NIL(detialModel.loanRepayDue.dueTermSum)];
    if(detialModel.loanRepayDue.overFlag == 0){
        self.bottomLab.text =  @"已逾期";
        self.timeLab.text = EMPTY_IF_NIL(detialModel.loanRepayDue.overDays);
        
        NSDictionary *attributes = @{NSFontAttributeName:FONT(12)};
               
        CGSize textSize = [EMPTY_IF_NIL(detialModel.loanRepayDue.overDays) boundingRectWithSize:CGSizeMake(220, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        [self.timeLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(textSize.width + 20);
        }];

    }else{
        self.bottomLab.text =  @"待还日";

        self.timeLab.text = EMPTY_IF_NIL(detialModel.loanRepayDue.dueDate);
        NSDictionary *attributes = @{NSFontAttributeName:FONT(12)};
                      
               CGSize textSize = [EMPTY_IF_NIL(detialModel.loanRepayDue.dueDate) boundingRectWithSize:CGSizeMake(220, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
               
               [self.timeLab mas_updateConstraints:^(MASConstraintMaker *make) {
                   make.width.mas_equalTo(textSize.width + 20);
               }];

    }
    self.moneyLab.text = EMPTY_IF_NIL(detialModel.loanRepayDue.dueAmt);

}
-(void)creatInitUI{
    
    [self addSubview:self.bgImg];
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.titLab];
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(18);
    }];
    
    [self addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titLab.mas_bottom).offset(8);
        make.left.equalTo(self.titLab);
    }];
    
    [self addSubview:self.bottomLab];
    [self.bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLab.mas_bottom).offset(8);
        make.left.equalTo(self.titLab);
        make.width.mas_equalTo(40);
    }];
    
    [self addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomLab);
        make.left.equalTo(self.bottomLab.mas_right).offset(3);
//        make.width.mas_equalTo(64);
        make.height.mas_equalTo(18);
    }];
    
    [self addSubview:self.payBut];
    [self.payBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(-35);
        make.width.mas_equalTo(58);
        make.height.mas_equalTo(24);
    }];
}
-(UIImageView *)bgImg{
    if (!_bgImg) {
        _bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_top_blue"]];
    }
    return _bgImg;
}
-(UILabel *)titLab{
    if (!_titLab) {
        _titLab = [[UILabel alloc] init];
        _titLab.font = FONT(12);
        _titLab.textColor = [UIColor whiteColor];
    }
    return _titLab;
}
-(UILabel *)moneyLab{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.font = BOLDFONT(24);
        _moneyLab.textColor = [UIColor whiteColor];
    }
    return _moneyLab;
}
-(UILabel *)bottomLab{
    if (!_bottomLab) {
        _bottomLab = [[UILabel alloc] init];
        _bottomLab.font = FONT(12);
        _bottomLab.textColor = [UIColor whiteColor];
        _bottomLab.text = @"待还日";
    }
    return _bottomLab;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = FONT(12);
        _timeLab.textColor = [UIColor whiteColor];
        _timeLab.layer.backgroundColor = [UIColor colorWithHex:@"#3A44E6"].CGColor;
        _timeLab.layer.cornerRadius = 9.5;
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLab;
}
-(UIButton *)payBut{
    if (!_payBut) {
        _payBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBut setTitle:@"去还款" forState:UIControlStateNormal];
        _payBut.titleLabel.font = FONT(12);
        [_payBut setTitleColor:[UIColor colorWithHex:@"#4D56EF"] forState:UIControlStateNormal];
        _payBut.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _payBut.layer.cornerRadius = 12;
        _payBut.layer.shadowColor = [UIColor colorWithRed:31/255.0 green:40/255.0 blue:215/255.0 alpha:1.0].CGColor;
        _payBut.layer.shadowOffset = CGSizeMake(0,0);
        _payBut.layer.shadowOpacity = 1;
        _payBut.layer.shadowRadius = 7;
        
    }
    return _payBut;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
