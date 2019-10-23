//
//  RepaymentTableViewCell.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/26.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RepaymentTableViewCell.h"

@interface RepaymentTableViewCell ()

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UILabel *moneyLab;
@property (nonatomic,strong)UILabel *desLab; // 应还日
@property (nonatomic,strong)UILabel *bottomLab;

@end

@implementation RepaymentTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];

        [self creatCellUI];
    }
    return self;
}
-(void)setRepayCellData:(RepayDueModel *)model{
    
    self.moneyLab.text = EMPTY_IF_NIL(model.dueAmt);
    
    if (self.cellOverFlag == 0) {
        self.bottomLab.text = [NSString stringWithFormat:@"%@（逾%@期）",EMPTY_IF_NIL(model.createTime),model.dueTerm];

    }else{
        self.bottomLab.text = [NSString stringWithFormat:@"%@（第%@期 %@）",EMPTY_IF_NIL(model.createTime),model.dueTerm,@"可提前还款"];

    }
}
-(void)creatCellUI{
    
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6);
        make.left.mas_equalTo(11);
        make.right.mas_equalTo(-13);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.bgView addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(16);
    }];
    
    [self.bgView addSubview:self.checkDetialBut];
    [self.checkDetialBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLab.mas_right).offset(5);
        make.centerY.equalTo(self.moneyLab);
    }];
    
    [self.bgView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLab);
        make.top.equalTo(self.moneyLab.mas_bottom).offset(20);
        
    }];
    
    [self.bgView addSubview:self.bottomLab];
    [self.bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLab);
        make.top.equalTo(self.desLab.mas_bottom).offset(4);
    }];
    
    [self.bgView addSubview:self.selectBut];
    [self.selectBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.mas_equalTo(0);
        make.width.height.mas_equalTo(40);
    }];
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _bgView.layer.cornerRadius = 4;
    }
    return _bgView;
}
-(UILabel *)moneyLab{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.textColor = Tit_Black_Color;
        _moneyLab.font = BOLDFONT(14);
        _moneyLab.text = @"560.00";
    }
    return _moneyLab;
}
-(FSCustomButton *)checkDetialBut{
    if (!_checkDetialBut) {
        _checkDetialBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        [_checkDetialBut setImage:[UIImage imageNamed:@"repay_but"] forState:UIControlStateNormal];
    }
    return _checkDetialBut;
}
-(UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.font = FONT(14);
        _desLab.text = @"应还日";
        _desLab.textColor = Tit_Black_Color;
    }
    return _desLab;
}
-(UILabel *)bottomLab{
    if (!_bottomLab) {
        _bottomLab = [[UILabel alloc] init];
        _bottomLab.font = FONT(14);
        _bottomLab.textColor = Tit_Gray_Color;
        _bottomLab.text = @"10月12日（第1期 正常还款）";
    }
    return _bottomLab;
}
-(UIButton *)selectBut{
    if (!_selectBut) {
        _selectBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBut setImage:[UIImage imageNamed:@"repay_select_no"] forState:UIControlStateNormal]; //repay_select
    }
    return _selectBut;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
