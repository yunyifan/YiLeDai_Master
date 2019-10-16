//
//  MainCenterView.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/11.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "MainCenterView.h"

@interface MainCenterView ()

@property (nonatomic,strong)UILabel *titLab; // 可用额度

@property (nonatomic,strong)UILabel *moneyLab;
@property (nonatomic,strong)UILabel *rateLab; // 利率
@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)UILabel *totalMoney; // 总额度

@property (nonatomic,strong)UIView *lineVc;
@end
@implementation MainCenterView

-(instancetype)initWithMainType:(MainDetianModel *)modelDetia{
    self = [super init];
    if (self) {
        self.creaditInfoModel = modelDetia;
//        [self initDetialView];
        [self creatMainUI];
    }
    return self;
}
-(void)creatMainUI{
    
    for (UIView *suvView in self.subviews) {
        if (suvView.tag>1000) {
            [suvView removeFromSuperview];

        }
    }

    if (self.creaditInfoModel.userState == 1 || self.self.creaditInfoModel.userState == 2 || (self.self.creaditInfoModel.userState == 4 && [self.creaditInfoModel.creditInfo.creditAppstate intValue] == 9) ){
        
        
        NSArray *titArr = @[@"申请借款",@"快速审核",@"实名认证",@"快速放款"];
      
        UIImageView *lastImg;
        for (int i=0; i<3; i++) {
            
            UIImageView *arrimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_red_arrow"]];
            arrimg.tag = 1000+i;
            [self addSubview:arrimg];
            [arrimg mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastImg) {
                    if (i == 1) {
                        make.right.equalTo(lastImg.mas_left).offset(-80);

                    }else{
                        make.left.equalTo(lastImg.mas_right).offset(80);

                    }

                }else{
                    make.centerX.equalTo(self);


                }
                make.top.mas_equalTo(20);
            }];
            if (i == 0) {
                lastImg = arrimg;

            }
            
            UILabel *lable = [[UILabel alloc] init];
            lable.font = FONT(13);
            lable.tag = 1100+i;
            lable.textColor = [UIColor colorWithHex:@"#FF52A5"];
            lable.text = titArr[i];
            [self addSubview:lable];
            [lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(arrimg);
                make.right.equalTo(arrimg.mas_left).offset(-10);
                
            }];

        }
        
        UILabel *lable = [[UILabel alloc] init];
        lable.font = FONT(13);
        lable.textColor = [UIColor colorWithHex:@"#FF52A5"];
        lable.text = titArr[3];
        lable.tag = 1200;
        [self addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lastImg);
            make.left.equalTo(lastImg.mas_right).offset(100);
            
        }];
        
        self.lineVc = [[UIView alloc] initWithFrame:CGRectMake(16, 42, (SCREEN_WIDTH-27*2), 1)];
        [self addSubview:self.lineVc];
        [LYDUtil drawDashLine:self.lineVc lineLength:10 lineSpacing:5 lineColor:[UIColor colorWithHex:@"#FF52A5"]];
        
    }else if(self.self.creaditInfoModel.userState == 3 || self.self.creaditInfoModel.userState == 4 ||self.self.creaditInfoModel.userState == 5){
        UIImage *leftIm;
        NSString *righStr;
        if (self.self.creaditInfoModel.userState == 3) {
            leftIm = [UIImage imageNamed:@"shenhe_icon"];
            righStr = @"统正在审核的资料，我们将在10-30分钟内估算出";
        }else if(self.self.creaditInfoModel.userState == 4 && [self.creaditInfoModel.creditInfo.creditAppstate intValue] == 1){
            leftIm = [UIImage imageNamed:@"loan_icon"];
            righStr = @"恭喜您，审核通过！立即去借款吧。";
        }else{
            leftIm = [UIImage imageNamed:@"loan_icon"];
            righStr = @"正在放款中，预计10分钟内到达账户，请耐心等待";
        }
        
        UIImageView *leftImg = [[UIImageView alloc] initWithImage:leftIm];
        leftImg.tag = 1300;
        [self addSubview:leftImg];
        [leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(14);
            make.left.mas_equalTo(9);
        }];
        
        UILabel *sheheLab = [[UILabel alloc] init];
        sheheLab.font = FONT(13);
        sheheLab.textColor = [UIColor colorWithHex:@"#FF52A5"];
        sheheLab.text = righStr;
        sheheLab.tag = 1400;
        [self addSubview:sheheLab];
        [sheheLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftImg);
            make.left.equalTo(leftImg.mas_right).offset(5);
            
        }];
        
        self.lineVc = [[UIView alloc] initWithFrame:CGRectMake(16, 42, (SCREEN_WIDTH-27*2), 1)];
        [self addSubview:self.lineVc];
        [LYDUtil drawDashLine:self.lineVc lineLength:10 lineSpacing:5 lineColor:[UIColor whiteColor]];
    }
    [self initDetialView];

}
-(void)initDetialView{
    self.moneyLab.text = self.creaditInfoModel.creditInfo.creditLeftamt;
       //        _rateLab.text = @"日利率：0.9%";
       self.rateLab.text = [NSString stringWithFormat:@"日利率：%@%@",self.creaditInfoModel.creditInfo.inteRate,@"%"];
    self.totalMoney.text = [NSString stringWithFormat:@"总额度%@",self.creaditInfoModel.creditInfo.creditLimit];
    if (self.self.creaditInfoModel.userState == 1 || self.self.creaditInfoModel.userState == 2) {
        if(self.self.creaditInfoModel.userState == 1){
            [self.statueBut setTitle:@"去认证" forState:UIControlStateNormal];
        }
        self.titLab.text = @"最高可借额度";
        self.img.hidden = YES;
        self.totalMoney.hidden = YES;
        self.statueBut.enabled = YES;
    }else if (self.self.creaditInfoModel.userState == 3){
        self.titLab.text = @"最高可借额度";
       self.img.hidden = NO;
       self.totalMoney.hidden = NO;
        self.statueBut.enabled = NO;
    }else if (self.self.creaditInfoModel.userState == 4){
        if ([self.creaditInfoModel.creditInfo.creditAppstate intValue] == 1) {
            self.titLab.text = @"可借额度";

            self.statueBut.enabled = YES;
        }else{
            if([self.creaditInfoModel.creditInfo.creditAppstate intValue] == 9){
                self.titLab.text = @"审核未通过,7天后再试";
            }else{
                self.titLab.text = @"最高可借额度";

            }
            self.statueBut.enabled = NO;
        }
    }else if (self.self.creaditInfoModel.userState == 5){
        self.titLab.text = @"剩余额度";
        self.statueBut.enabled = NO;

    }else if (self.creaditInfoModel.userState == 6){
        self.titLab.text = @"剩余额度";
        self.statueBut.enabled = NO;
        if (self.creaditInfoModel.loanRepayDue.overFlag == 1) {
            [self.statueBut setTitle:@"我要借钱" forState:UIControlStateNormal];
        }else{
            [self.statueBut setTitle:@"逾期中" forState:UIControlStateNormal];
        }
    }
    
    
    
    [self addSubview:self.titLab];
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        if (self.creaditInfoModel.userState == 1 || self.creaditInfoModel.userState == 2 || self.creaditInfoModel.userState == 3 || self.creaditInfoModel.userState == 4 ||self.creaditInfoModel.userState == 5) {
            make.top.equalTo(self.lineVc).offset(24);
        }else{
            make.top.mas_equalTo(32);

        }
    }];
    
    [self addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titLab.mas_bottom);
    }];
    
    [self addSubview:self.rateLab];
    [self.rateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.moneyLab.mas_bottom).offset(6);
    }];
    
    [self addSubview:self.statueBut];
    [self.statueBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(182);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.rateLab.mas_bottom).offset(26);
        make.bottom.mas_equalTo(-46);

    }];
    
    [self addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statueBut.mas_bottom).offset(15);
        make.left.equalTo(self.statueBut).offset(44);
        make.width.height.mas_equalTo(14);
    }];
    
    [self addSubview:self.totalMoney];
    [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.img);
        make.left.equalTo(self.img.mas_right).offset(4);
    }];
}
-(UILabel *)titLab{
    if (!_titLab) {
        _titLab = [[UILabel alloc] init];
        _titLab.font = FONT(13);
        _titLab.textColor = Tit_Black_Color;
        
    }
    return _titLab;
}
-(UILabel *)moneyLab{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.font = BOLDFONT(35);
        _moneyLab.textColor = Tit_Black_Color;
        _moneyLab.text = @"800";
    }
    return _moneyLab;
}
-(UILabel *)rateLab{
    if (!_rateLab) {
        _rateLab = [[UILabel alloc] init];
        _rateLab.font = FONT(13);
        _rateLab.textColor = Tit_Gray_Color;
        
    }
    return _rateLab;
}
-(FSCustomButton *)statueBut{
    if (!_statueBut) {
        _statueBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        _statueBut.titleLabel.font = BOLDFONT(15);
        [_statueBut setTitle:@"我要借钱" forState:UIControlStateNormal];
        _statueBut.layer.backgroundColor = But_Bg_Color.CGColor;
        _statueBut.layer.cornerRadius = 20;
        [_statueBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _statueBut.alpha = 0.2;
        
    }
    return _statueBut;
}
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_"]];
    }
    return _img;
}
-(UILabel *)totalMoney{
    if (!_totalMoney) {
        _totalMoney = [[UILabel alloc] init];
        _totalMoney.font = FONT(13);
        _totalMoney.textColor = Tit_Black_Color;
    }
    return _totalMoney;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
