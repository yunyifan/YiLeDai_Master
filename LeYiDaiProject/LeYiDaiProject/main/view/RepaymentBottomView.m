//
//  RepaymentBottomView.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/26.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RepaymentBottomView.h"

@interface RepaymentBottomView ()

@property (nonatomic,strong)UIButton *cancleBut;

@property (nonatomic,strong)UILabel *linLab;
@end

@implementation RepaymentBottomView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self creatDetialUI];
    }
    return self;
}
-(void)creatDetialUI{
    
    [self addSubview:self.cancleBut];
    [self.cancleBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(0);
    }];
    
    [self addSubview:self.linLab];
    [self.linLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.cancleBut.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    
}
-(void)setDataArray:(NSArray *)leftArray RightDataArray:(NSArray *)rightArr{
    
    
    UILabel *lastLab;
    for (int i = 0; i<leftArray.count; i++) {
        UILabel *leftLab = [[UILabel alloc] init];
        leftLab.font = FONT(14);
        leftLab.textColor = [UIColor colorWithHex:@"#333333"];
        leftLab.text = leftArray[i];
        leftLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:leftLab];
        [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(24);
            if (lastLab) {
                make.top.equalTo(lastLab.mas_bottom).offset(15);
            }else{
                make.top.equalTo(self.linLab).offset(13);
            }
            
            if (i == leftArray.count-1) {
                make.bottom.mas_equalTo(-10);
            }
        }];
    
        
        UILabel *rightlab = [[UILabel alloc] init];
        rightlab.font = FONT(14);
        rightlab.textColor = Tit_Gray_Color;
        rightlab.textAlignment = NSTextAlignmentRight;
        rightlab.text = rightArr[i];
        [self addSubview:rightlab];
        [rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftLab);
            make.right.mas_equalTo(-26);
        }];
        
        
        lastLab = leftLab;
    }
}
-(void)cancleButClick{
    
    [YSSModelDialog hideView];
}
-(UIButton *)cancleBut{
    if (!_cancleBut) {
        _cancleBut = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancleBut setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBut addTarget:self action:@selector(cancleButClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancleBut;
}
-(UILabel *)linLab{
    if (!_linLab) {
        _linLab = [[UILabel alloc] init];
        _linLab.backgroundColor = [UIColor colorWithHex:@"#ECECEC"];
    }
    return _linLab;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
