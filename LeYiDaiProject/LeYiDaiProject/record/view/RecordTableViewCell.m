//
//  RecordTableViewCell.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/9.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RecordTableViewCell.h"

@interface RecordTableViewCell ()
@property (nonatomic,strong)UILabel *moneyLab;
@property (nonatomic,strong)UILabel *timeLab;
@property (nonatomic,strong)UILabel *stauteLab;
@property (nonatomic,strong)UIView *lineView;
@end

@implementation RecordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style  reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
        [self initUI];
    }
    
    return self;
}
-(void)setUIData{
    self.moneyLab.text = @"1000.00";
    self.timeLab.text = @"2019年07月16日";
    self.stauteLab.text = @"违约还款";
}
-(void)initUI{
    
    [self addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(20);
    }];
    
    [self addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLab);
        make.top.equalTo(self.moneyLab.mas_bottom).offset(3);
    }];
    
    [self addSubview:self.stauteLab];
    [self.stauteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(-25);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.equalTo(self);
        make.top.equalTo(self.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
    }];
}
-(UILabel *)moneyLab{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.font = BOLDFONT(16);
        _moneyLab.textColor = Tit_Black_Color;
    }
    return _moneyLab;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = FONT(12);
        _timeLab.textColor = Tit_Gray_Color;
    }
    return _timeLab;
}
-(UILabel *)stauteLab{
    if (!_stauteLab) {
        _stauteLab = [[UILabel alloc] init];
        _stauteLab.font = FONT(12);
        _stauteLab.textColor = Tit_Red_Color;
        _stauteLab.textAlignment = NSTextAlignmentRight;
    }
    return _stauteLab;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = Line_Color;
    }
    return _lineView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
