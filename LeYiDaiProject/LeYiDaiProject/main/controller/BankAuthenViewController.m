//
//  BankAuthenViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "BankAuthenViewController.h"
#import "ApplicationInformationViewController.h"
@interface BankAuthenViewController ()

@property (nonatomic,strong)UIView *lineView;

@property (nonatomic,strong)UIButton *nextBut;

@end

@implementation BankAuthenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    if (self.isAddBank == YES) {
        self.navigationItem.title = @"添加银行卡";

    }else{
        self.navigationItem.title = @"额度评估-银行卡认证";

    }
    
    [self creatUI];
}
-(void)creatUI{
    
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    
    NSArray *leftArray = @[@"持卡人",@"银行卡号",@"预留手机",@"验证码"];
    NSArray *rightArray = @[@"请输入持卡人姓名",@"请输入银行卡号，仅支持储蓄卡",@"请输入银行预留手机号备份",@"请输入验证码"];
    
    UIView *lastView;
    for (int i = 0; i<leftArray.count; i++) {
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(60);
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom);
            }else{
                
                make.top.mas_equalTo(1);
            }
        }];
        
        UILabel *leftLab = [[UILabel alloc] init];
        leftLab.font = FONT(14);
        leftLab.textColor = Tit_Black_Color;
        leftLab.text = leftArray[i];
        [bgView addSubview:leftLab];
        [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.centerY.equalTo(bgView);
        }];
        
        UITextField *textFiled = [[UITextField alloc] init];
        textFiled.placeholder = rightArray[i];
        textFiled.tag = i+1;
        [textFiled addTarget:self action:@selector(textChangeCLick:) forControlEvents:UIControlEventEditingChanged];
        textFiled.font = FONT(14);
        [bgView addSubview:textFiled];
        [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.mas_equalTo(90);
            make.right.equalTo(bgView);
        }];
        
        if (i<leftArray.count-1) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = [UIColor colorWithHex:@"#EEEEEE"];
            [bgView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftLab);
                make.right.equalTo(bgView);
                make.bottom.equalTo(bgView).offset(-1);
                make.height.mas_equalTo(1);
            }];
        }else{
            
            UIButton *codeBut = [UIButton buttonWithType:UIButtonTypeCustom];
            [codeBut setTitle:@"获取验证码" forState:UIControlStateNormal];
            codeBut.titleLabel.font = FONT(12);
            codeBut.backgroundColor = But_Bg_Color;
            //        [_codeBut setTitleColor:Tit_Gray_Color forState:UIControlStateNormal];
            codeBut.timeInterval = TimeInterval;
            codeBut.enabled = NO;
            codeBut.layer.cornerRadius = 15;
            codeBut.layer.shadowOffset = CGSizeMake(0, 2);
            codeBut.layer.shadowOpacity = 1;
            codeBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
            codeBut.layer.shadowRadius = 6;
            [bgView addSubview:codeBut];
            [codeBut mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(bgView);
                make.right.mas_equalTo(-30);
                make.width.mas_equalTo(82);
                make.height.mas_equalTo(30);
            }];
        }
      

        
        lastView = bgView;
    }
    
    
    [self.view addSubview:self.nextBut];
    [self.nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView.mas_bottom).offset(62);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
    }];

    
}
-(void)nextButtonClick{
    
    ApplicationInformationViewController *applicationVc = [[ApplicationInformationViewController alloc] init];
    [self.navigationController pushViewController:applicationVc animated:YES];
    
}
-(void)textChangeCLick:(UITextField *)textField{
    [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",textField.tag]];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHex:@"#EEEEEE"];
    }
    return _lineView;
}
-(UIButton *)nextBut{
    if (!_nextBut) {
        _nextBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBut setBackgroundImage:[UIImage imageNamed:@"but_enable"] forState:UIControlStateNormal];
        _nextBut.titleLabel.font = BOLDFONT(18);
        [_nextBut setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBut addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBut;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
