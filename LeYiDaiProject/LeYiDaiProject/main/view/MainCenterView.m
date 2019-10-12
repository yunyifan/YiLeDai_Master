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

-(instancetype)initWithMainType:(NSInteger)typeIndex{
    self = [super init];
    if (self) {
        self.type = typeIndex;
//        [self initDetialView];
        [self creatMainUI];
    }
    return self;
}
-(void)setCreaditInfoModel:(MainDetianModel *)creaditInfoModel{
    _creaditInfoModel = creaditInfoModel;
    self.moneyLab.text = self.creaditInfoModel.creditInfo.creditLimit;
    //        _rateLab.text = @"日利率：0.9%";
    self.rateLab.text = [NSString stringWithFormat:@"日利率：%@%@",self.creaditInfoModel.creditInfo.inteRate,@"%"];
}
-(void)creatMainUI{
    if (self.type == 1 || self.type == 2) {
        NSArray *titArr = @[@"申请借款",@"快速审核",@"实名认证",@"快速放款"];
      
        UIImageView *lastImg;
        for (int i=0; i<3; i++) {
            
            UIImageView *arrimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_red_arrow"]];
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
        [self addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lastImg);
            make.left.equalTo(lastImg.mas_right).offset(100);
            
        }];
        
        self.lineVc = [[UIView alloc] initWithFrame:CGRectMake(16, 42, (SCREEN_WIDTH-27*2), 1)];
        [self addSubview:self.lineVc];
        [LYDUtil drawDashLine:self.lineVc lineLength:10 lineSpacing:5 lineColor:[UIColor colorWithHex:@"#FF52A5"]];
        
    }else{
        
        UIImageView *leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shenhe_icon"]];
        [self addSubview:leftImg];
        [leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(14);
            make.left.mas_equalTo(9);
        }];
        
        UILabel *sheheLab = [[UILabel alloc] init];
        sheheLab.font = FONT(13);
        sheheLab.textColor = [UIColor colorWithHex:@"#FF52A5"];
        sheheLab.text = @"统正在审核的资料，我们将在10-30分钟内估算出";
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
    
    if (self.type == 1 || self.type == 2) {
        self.titLab.text = @"最高可借额度";
        self.img.hidden = YES;
        self.totalMoney.hidden = YES;
    }
    
    
    
    [self addSubview:self.titLab];
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        if (self.type == 1 || self.type == 2) {
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
-(UIButton *)statueBut{
    if (!_statueBut) {
        _statueBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _statueBut.titleLabel.font = BOLDFONT(15);
        [_statueBut setTitle:@"我要借钱" forState:UIControlStateNormal];
        _statueBut.layer.backgroundColor = But_Bg_Color.CGColor;
        _statueBut.layer.cornerRadius = 20;
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
        _totalMoney.text = @"总额度 2000";
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
