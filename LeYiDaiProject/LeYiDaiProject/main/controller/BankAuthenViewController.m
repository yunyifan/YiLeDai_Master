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

@property (nonatomic,strong)FSCustomButton *nextBut;

@property (nonatomic,assign)BOOL isGetCodeSuccess; // 是否获取验证码成功 ，获取验证码60s内，获取验证码按钮不高亮

@property (nonatomic,strong)FSCustomButton *codeBut;

@property (nonatomic,strong)NSString *nameStr; // 姓名
@property (nonatomic,strong)NSString *bankCardStr; // 银行卡号
@property (nonatomic,strong)NSString *phoneStr; //手机号
@property (nonatomic,strong)NSString *codeStr; //验证码
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
        if (i!=0) {
            textFiled.keyboardType = UIKeyboardTypeNumberPad;
        }
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
            
            self.codeBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
            [self.codeBut setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.codeBut.titleLabel.font = FONT(12);
            [self.codeBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.codeBut.backgroundColor = But_Bg_Color;
            self.codeBut.timeInterval = TimeInterval;
            self.codeBut.enabled = NO;
            [self.codeBut addTarget:self action:@selector(bankClick) forControlEvents:UIControlEventTouchUpInside];
            self.codeBut.layer.cornerRadius = 15;
            self.codeBut.layer.shadowOffset = CGSizeMake(0, 2);
            self.codeBut.layer.shadowOpacity = 1;
            self.codeBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
            self.codeBut.layer.shadowRadius = 6;
            [bgView addSubview:self.codeBut];
            [self.codeBut mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.height.mas_equalTo(45);
    }];

    
}

///获取验证码
-(void)bankClick{
    
    UITextField *textFiled = (UITextField *)[self.view viewWithTag:3];
    if (![LYDUtil isPhoneNumber:textFiled.text]) {
           return;
       }
       @weakify(self);
       NSDictionary *pramDic = @{@"phone":EMPTY_IF_NIL(textFiled.text),@"appscen":@"auth"};
       [[RequestAPI shareInstance] getSysCode:pramDic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
           @strongify(self);
           if (succeed) {
               if ([result[@"success"] intValue] == 1) {
                   self.isGetCodeSuccess = YES;

                    [MBProgressHUD showSuccess:@"验证码已发送"];
                   __block int timeout=60; //倒计时时间
                   dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                   dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                   dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                   dispatch_source_set_event_handler(_timer, ^{
                       if(timeout<=0){ //倒计时结束，关闭
                           dispatch_source_cancel(_timer);
                           dispatch_async(dispatch_get_main_queue(), ^{
                               //设置界面的按钮显示 根据自己需求设置
                               self.codeBut.enabled = YES;
                               [self.codeBut setTitle:@"获取验证码" forState:UIControlStateNormal];
                           });
                       }else{
                           int seconds = timeout ;//% 60;
                           NSString *strTime = [NSString stringWithFormat:@"%dS", seconds];
                           dispatch_async(dispatch_get_main_queue(), ^{
                               //设置界面的按钮显示 根据自己需求设置
                               self.codeBut.enabled = NO;

                               [self.codeBut setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                               self.isGetCodeSuccess = NO;

                           });
                           timeout--;
                       }
                   });
                   dispatch_resume(_timer);
               }else{
                   
                   [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

               }
           }
       }];
}
-(void)nextButtonClick{
    
    NSDictionary *dic = @{@"accNo":EMPTY_IF_NIL(self.bankCardStr),@"idHolder":EMPTY_IF_NIL(self.nameStr),@"mobile":EMPTY_IF_NIL(self.phoneStr),@"userId":self.loginModel.userId,@"smsCode":self.codeStr};
    [[RequestAPI shareInstance] useCustAuthBankInsert:dic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        if (succeed) {
            if ([result[@"success"] intValue] == 1) {
                NSLog(@"银行卡认证%@",result[@"result"][@"desc"]);
                ApplicationInformationViewController *applicationVc = [[ApplicationInformationViewController alloc] init];
                [self.navigationController pushViewController:applicationVc animated:YES];
            }else{
                
                [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

            }

        }

    }];
    

    
}
-(void)textChangeCLick:(UITextField *)textField{
    
    if (textField.tag == 2) {
        self.bankCardStr = textField.text;
    }else if (textField.tag == 3){
        self.phoneStr = textField.text;
        [self textFieldDidChange:textField LimitLength:11];

    }else if (textField.tag == 4){
        self.codeStr = textField.text;
        [self textFieldDidChange:textField LimitLength:6];

    }else{
        self.nameStr = textField.text;
    }
    
}
#pragma mark UITextFilDelagete

-(void)textFieldDidChange:(UITextField *)textField LimitLength:(int)length{
    CGFloat maxLength = length;
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position || !selectedRange)
    {
        if (toBeString.length > maxLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:maxLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    if (textField.tag == 3) {
        if (self.isGetCodeSuccess == NO) {
            if(textField.text.length == 11){
                    self.codeBut.enabled = YES;
                }else{
                    self.codeBut.enabled = NO;
                }
        }
            

    }
    if (STRING_ISNIL(self.nameStr) || STRING_ISNIL(self.bankCardStr) || STRING_ISNIL(self.phoneStr) || STRING_ISNIL(self.codeStr)) {
        self.nextBut.enabled = NO;
    }else{
        self.nextBut.enabled = YES;
    }

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
-(FSCustomButton *)nextBut{
    if (!_nextBut) {
        _nextBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        _nextBut.titleLabel.font = BOLDFONT(18);
        _nextBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];

        [_nextBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBut setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBut.layer.shadowOffset = CGSizeMake(0, 2);
        _nextBut.layer.shadowOpacity = 1;
        _nextBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
        _nextBut.layer.shadowRadius = 9;

        _nextBut.enabled = NO;

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
