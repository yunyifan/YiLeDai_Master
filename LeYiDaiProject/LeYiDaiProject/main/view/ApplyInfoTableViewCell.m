//
//  ApplyInfoTableViewCell.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "ApplyInfoTableViewCell.h"

@interface ApplyInfoTableViewCell ()<UITextFieldDelegate>


@end

@implementation ApplyInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initUI];
    }
    return self;
}
-(void)setBotttomTextIsHide:(BOOL)botttomTextIsHide{
    if (botttomTextIsHide == YES) {
        [self.bottomTextFiled mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textFiled.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);

        }];
    }else{
        [self.bottomTextFiled mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textFiled.mas_bottom).offset(14);
            make.bottom.mas_equalTo(-14);
            
        }];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    self.textBack(textField.text);
    
    return YES;
}

-(void)initUI{
    
    [self addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.left.mas_equalTo(14);
    }];
    
    [self addSubview:self.arrrowImg];
    [self.arrrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftLab);
        make.right.mas_equalTo(-18);
    }];
    
    [self addSubview:self.textFiled];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftLab);
        make.right.equalTo(self.arrrowImg.mas_left).offset(-6);
        make.width.mas_equalTo(284);
//        make.bottom.mas_equalTo(-14);
    }];
    
    [self addSubview:self.bottomTextFiled];
    [self.bottomTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFiled.mas_bottom).offset(14);
        make.right.equalTo(self.textFiled);
        make.bottom.mas_equalTo(-14);
    }];
}
-(UILabel *)leftLab{
    if (!_leftLab) {
        _leftLab = [[UILabel alloc] init];
        _leftLab.font = FONT(14);
        _leftLab.textColor = Tit_Black_Color;
    }
    return _leftLab;
}
-(UITextField *)textFiled{
    if (!_textFiled) {
        _textFiled = [[UITextField alloc] init];
        _textFiled.font = FONT(14);
        _textFiled.textAlignment = NSTextAlignmentRight;
        _textFiled.delegate = self;
    }
    return _textFiled;
}
-(UITextField *)bottomTextFiled{
    if (!_bottomTextFiled) {
        _bottomTextFiled = [[UITextField alloc] init];
        _bottomTextFiled.font = FONT(14);
        _bottomTextFiled.textAlignment = NSTextAlignmentRight;
    }
    return _bottomTextFiled;
}

-(UIImageView *)arrrowImg{
    if (!_arrrowImg) {
        
        _arrrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
    }
    return _arrrowImg;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
