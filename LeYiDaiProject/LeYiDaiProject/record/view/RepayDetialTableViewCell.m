//
//  RepayDetialTableViewCell.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/22.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RepayDetialTableViewCell.h"


@interface RepayDetialTableViewCell ()

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UILabel *timeLable; // 时间
@property (nonatomic,strong)UILabel *moneyLab; // 还款金额
@property (nonatomic,strong)UILabel *lineView;

@property (nonatomic,strong)UILabel *bjLab; //本金
@property (nonatomic,strong)UILabel *bjDataLab;
@property (nonatomic,strong)UILabel *lxLab; // 利息
@property (nonatomic,strong)UILabel *lxDataLab;
@property (nonatomic,strong)UILabel *fwLab; // 服务费
@property (nonatomic,strong)UILabel *fwDataLab;

@end

@implementation RepayDetialTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithHex:@"#F6F7FB"];

        [self initDetailUI];
    }
    return self;
}
-(void)setCellData:(NSDictionary *)dic{
    NSLog(@"*************%@",dic[@"realInte"]);
    self.timeLable.text = [NSString stringWithFormat:@"%@",dic[@"dueDate"]];
    self.moneyLab.text = [NSString stringWithFormat:@"%@",dic[@"realAmt"]];
    self.bjDataLab.text=  [NSString stringWithFormat:@"%@",dic[@"realCapi"]];
    self.lxDataLab.text = [NSString stringWithFormat:@"%@",dic[@"realInte"]];
    self.fwDataLab.text = [NSString stringWithFormat:@"%@",dic[@"realFee"]];
}
-(void)initDetailUI{
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(9);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.equalTo(self);
    }];
    
    [self.bgView addSubview:self.timeLable];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.equalTo(self.bgView);
        make.height.mas_equalTo(40);
    }];
    
    [self.bgView addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLable);
        make.right.mas_equalTo(-20);
    }];
    
    [self.bgView addSubview:self.lineView];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.timeLable.mas_bottom);
//        make.left.equalTo(self.timeLable);
//        make.right.equalTo(self.moneyLab);
//        make.height.mas_equalTo(1);
//    }];
    
    [LYDUtil drawDashLine:self.lineView lineLength:10 lineSpacing:5 lineColor:[UIColor colorWithHex:@"#E8E8E8"]];

    [self.bgView addSubview:self.bjLab];
    [self.bjLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLable);
        make.top.equalTo(self.lineView.mas_bottom).offset(15);
    }];
    
    [self.bgView addSubview:self.bjDataLab];
    [self.bjDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bjLab);
        make.right.equalTo(self.moneyLab);
    }];
    
    [self.bgView addSubview:self.lxLab];
    [self.lxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLable);
        make.top.equalTo(self.bjLab.mas_bottom).offset(20);
    }];
    
    [self.bgView addSubview:self.lxDataLab];
    [self.lxDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lxLab);
        make.right.equalTo(self.moneyLab);
    }];

    [self.bgView addSubview:self.fwLab];
    [self.fwLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLable);
        make.top.equalTo(self.lxLab.mas_bottom).offset(20);
    }];
    
    [self.bgView addSubview:self.fwDataLab];
    [self.fwDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fwLab);
        make.right.equalTo(self.moneyLab);
    }];

     
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _bgView.layer.cornerRadius = 4;
    }
    return _bgView;
}

-(UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.font = BOLDFONT(14);
        _timeLable.textColor = Tit_Black_Color;
    }
    return _timeLable;
}
-(UILabel *)moneyLab{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.font = FONT(14);
        _moneyLab.textColor = Tit_Black_Color;
    }
    return _moneyLab;
}
-(UILabel *)lineView{
    if (!_lineView) {
        _lineView = [[UILabel alloc] initWithFrame:CGRectMake(12, 41, SCREEN_WIDTH-12*4, 1)];
    }
    return _lineView;
}
-(UILabel *)bjLab{
    if (!_bjLab) {
        _bjLab = [[UILabel alloc] init];
        _bjLab.font = FONT(14);
        _bjLab.text = @"本金";
        _bjLab.textColor = Tit_Gray_Color;
    }
    return _bjLab;
}
-(UILabel *)bjDataLab{
    if (!_bjDataLab) {
        _bjDataLab = [[UILabel alloc] init];
        _bjDataLab.font = FONT(14);
        _bjDataLab.textColor = Tit_Gray_Color;
        _bjDataLab.textAlignment = NSTextAlignmentRight;
    }
    return _bjDataLab;
}
-(UILabel *)lxLab{
    if (!_lxLab) {
        _lxLab = [[UILabel alloc] init];
        _lxLab.font = FONT(14);
        _lxLab.text = @"利息";
        _lxLab.textColor = Tit_Gray_Color;
    }
    return _lxLab;
}
-(UILabel *)lxDataLab{
    if (!_lxDataLab) {
        _lxDataLab = [[UILabel alloc] init];
        _lxDataLab.font = FONT(14);
        _lxDataLab.textColor = Tit_Gray_Color;
        _lxDataLab.textAlignment = NSTextAlignmentRight;
    }
    return _lxDataLab;
}
-(UILabel *)fwLab{
    if (!_fwLab) {
        _fwLab = [[UILabel alloc] init];
        _fwLab.font = FONT(14);
        _fwLab.text = @"服务费";
        _fwLab.textColor = Tit_Gray_Color;
    }
    return _fwLab;
}
-(UILabel *)fwDataLab{
    if (!_fwDataLab) {
        _fwDataLab = [[UILabel alloc] init];
        _fwDataLab.font = FONT(14);
        _fwDataLab.textColor = Tit_Gray_Color;
        _fwDataLab.textAlignment = NSTextAlignmentRight;

    }
    return _fwDataLab;
}

@end
