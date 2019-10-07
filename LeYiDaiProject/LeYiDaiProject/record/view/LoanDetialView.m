//
//  LoanDetialView.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/11.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "LoanDetialView.h"

@interface LoanDetialView ()
@property (nonatomic,strong)UILabel *titLab;

@property (nonatomic,strong)UILabel *leftLab;
@property (nonatomic,strong)UIImageView *arrImg;
@property (nonatomic,strong)UIButton *recordBut;

@end

@implementation LoanDetialView
-(instancetype)initWithType:(RecordType)recordType{
    self = [super init];
    if (self) {
        self.detialRecordType = recordType;
       
    }
    
    return self;
}
-(void)creatDetialUI:(NSArray *)array{

    self.titLab = [[UILabel alloc] init];
    self.titLab.font = BOLDFONT(14);
    self.titLab.textColor = Tit_Black_Color;
    [self addSubview:self.titLab];
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(16);
    }];
    
    NSArray *leftArr;
    if (self.detialRecordType == RecordTypeSettlement) {
        leftArr = @[@"借款金额",@"合同期限",@"还款方式"];
        self.titLab.text = @"借款明细";

    }else if (self.detialRecordType == RecordTypeUseing){
        leftArr = @[@"借款金额",@"合同期限"];
        self.titLab.text = @"借款明细";

    }else if (self.detialRecordType == RecordTypeRepayment){
        leftArr = @[@"已还本金",@"已还利息",@"服务费"];
        self.titLab.text = @"还款明细";

    }else if (self.detialRecordType == RecordTypeDefault){
        leftArr = @[@"未还本金",@"未还利息",@"违约金"];
        self.titLab.text = @"违约还款明细";
    }
    
    
    UIView *lineVc = [[UIView alloc] initWithFrame:CGRectMake(16, 42, (SCREEN_WIDTH-27*2), 1)];
    [self addSubview:lineVc];
    
    [LYDUtil drawDashLine:lineVc lineLength:10 lineSpacing:5 lineColor:[UIColor colorWithHex:@"#E8E8E8"]];
    
    UILabel *lastLab;
    for(int i = 0; i<leftArr.count; i++) {
        UILabel *leftLab = [[UILabel alloc] init];
        leftLab.font = FONT(14);
        leftLab.textColor = [UIColor colorWithHex:@"#99A7B8"];
        leftLab.text = leftArr[i];
        [self addSubview:leftLab];
        [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            if (lastLab) {
                make.top.equalTo(lastLab.mas_bottom).offset(20);
                
            }else{
                make.top.equalTo(self.titLab.mas_bottom).offset(28);
            }
            
        }];
        
        UILabel *dataLab = [[UILabel alloc] init];
        dataLab.font = FONT(13);
        dataLab.textAlignment = NSTextAlignmentRight;
        dataLab.textColor = [UIColor colorWithHex:@"#99A7B8"];
        dataLab.text = EMPTY_IF_NIL(array[i]);
        [self addSubview:dataLab];
        [dataLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftLab);
            make.right.mas_equalTo(-20);
        }];
        
        lastLab = leftLab;
    
    }
    
    
    if(self.detialRecordType == RecordTypeRepayment || self.detialRecordType == RecordTypeDefault){
        
        [self addSubview:self.leftLab];
        [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.top.equalTo(lastLab.mas_bottom).offset(15);
            make.bottom.equalTo(self).offset(-16);

        }];
        
        [self addSubview:self.arrImg];
        [self.arrImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftLab);
            make.right.mas_equalTo(-20);
        }];
        
        [self addSubview:self.recordBut];
        [self.recordBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.bottom.equalTo(self.leftLab);
        }];
    }else{
        [lastLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-16);

        }];
    }
    
}

/**
 还款记录
 */
-(void)recordButtonClick{
    
    [MBProgressHUD showError:@"还款记录"];
    if (self.detialRecordType == RecordTypeRepayment) {
        
    }else if(self.detialRecordType == RecordTypeDefault){
        
    }
}
-(UILabel *)leftLab{
    if (!_leftLab) {
        _leftLab = [[UILabel alloc] init];
        _leftLab.font = FONT(13);
        _leftLab.textColor = Tit_Gray_Color;
        _leftLab.text = @"还款记录";
    }
    return _leftLab;
}
-(UIImageView *)arrImg{
    if (!_arrImg) {
        _arrImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
    }
    return _arrImg;
}
-(UIButton *)recordBut{
    if (!_recordBut) {
        _recordBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordBut addTarget:self action:@selector(recordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recordBut;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
