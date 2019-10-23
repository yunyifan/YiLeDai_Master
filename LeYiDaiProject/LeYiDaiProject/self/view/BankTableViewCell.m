//
//  BankTableViewCell.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/7.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BankTableViewCell.h"

@interface BankTableViewCell ()

@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UILabel *nameLab; // 银行名字
@property (nonatomic,strong)UILabel *decLab;
@property (nonatomic,strong)UILabel *numLab;

@end

@implementation BankTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self creatDetialCell];
    }
    
    return self;
}
-(void)setCellData:(BankDetialModel *)model{
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"bankImage"]];

    self.nameLab.text = EMPTY_IF_NIL(model.cardBankname);
//    if ([model.cardType intValue] == 1) {
        self.decLab.text = model.cardType;

//    }else{
//        self.decLab.text = @"信用卡";
//    }
    
    self.numLab.text = model.bankcardNo;
}
-(void)creatDetialCell{
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(12);
        make.height.mas_equalTo(95);
        make.right.mas_equalTo(-12);
    }];
    
    self.iconImage.layer.cornerRadius = 18;
    self.iconImage.layer.masksToBounds = YES;
    [self.bgView addSubview:self.iconImage];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.mas_equalTo(18);
        make.width.height.mas_equalTo(36);
    }];
    
    [self.bgView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImage).offset(-5);
        make.left.equalTo(self.iconImage.mas_right).offset(10);
    }];
    
    [self.bgView addSubview:self.decLab];
    [self.decLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconImage);
        make.left.equalTo(self.nameLab);
    }];
    
    [self.bgView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-20);
        make.centerY.equalTo(self.bgView);
    }];
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.backgroundColor = [UIColor colorWithHex:@"#D95757"].CGColor;
        _bgView.layer.cornerRadius = 4;
    }
    return _bgView;
}
-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.backgroundColor = [UIColor whiteColor];
        
    }
    return _iconImage;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor whiteColor];
        _nameLab.font = FONT(16);
        
    }
    return _nameLab;
}
-(UILabel *)decLab{
    if (!_decLab) {
        _decLab = [[UILabel alloc] init];
        _decLab.textColor = [UIColor whiteColor];
        _decLab.font = FONT(12);
        _decLab.text = @"储蓄卡";
    }
    return _decLab;
}
-(UILabel *)numLab{
    if (!_numLab) {
        _numLab = [[UILabel alloc] init];
        _numLab.textColor = [UIColor whiteColor];
        _numLab.font = FONT(16);
        _numLab.text = @"**** **** **** 9998";
    }
    return _numLab;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
