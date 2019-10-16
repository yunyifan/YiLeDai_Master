//
//  OperatorViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/15.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "OperatorViewController.h"
#import "BankAuthenViewController.h"

#import "MainAccationView.h"

@interface OperatorViewController ()<UITextViewDelegate>
//@property (nonatomic,strong)MainAccationView *accationView;

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UITextField *phoneText;

@property (nonatomic,strong)UILabel *lineLab;
@property (nonatomic,strong)FSCustomButton *codeBut;

@property (nonatomic,strong)UITextField *secretText;

@property (nonatomic,strong)FSCustomButton *nextBut;

@property (nonatomic,assign)BOOL isGetCodeSuccess; // 是否获取验证码成功 ，获取验证码60s内，获取验证码按钮不高亮

//@property (nonatomic,strong)UIButton *xieYiBut;

//@property (nonatomic,strong)UITextView *secretTextView;

@end

@implementation OperatorViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setShadowImage:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"额度评估-运营商认证";

//    [self creatInitUI];
    
    [self creatOperInsert];
}
-(void)creatInitUI{
//    [self.view addSubview:self.accationView];
//    [self.accationView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.view);
//    }];
    
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(120);
    }];
    
    [self.bgView addSubview:self.phoneText];
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.top.right.equalTo(self.bgView);
        make.height.mas_equalTo(60);
    }];
    
    [self.bgView addSubview:self.lineLab];
    [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.right.equalTo(self.bgView);
        make.top.equalTo(self.phoneText.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.codeBut];
    [self.codeBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-31);
        make.top.equalTo(self.lineLab.mas_top).offset(20);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(30);
    }];

    
    [self.bgView addSubview:self.secretText];
    [self.secretText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneText);
        make.bottom.right.equalTo(self.bgView);
        make.height.mas_equalTo(60);
    }];
    
    [self.view addSubview:self.nextBut];
    [self.nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(42);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(45);
    }];
    
//    [self.view addSubview:self.xieYiBut];
//    [self.xieYiBut mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.nextBut.mas_bottom);
//        make.left.equalTo(self.nextBut.mas_left).offset(10);
//    }];
//    
//    [self.view addSubview:self.secretTextView];
//    [self.secretTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.xieYiBut);
//        make.left.equalTo(self.xieYiBut.mas_right);
//    }];

}
-(void)textDidChange{
    
    [self textFieldDidChange:self.phoneText LimitLength:11];

}
-(void)codeTextClick{
    [self textFieldDidChange:self.secretText LimitLength:6];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(void)nextButtonClick{
    
//    [self useOperatorInsert];
    BankAuthenViewController *bankVc = [[BankAuthenViewController alloc] init];
    [self.navigationController pushViewController:bankVc animated:YES];
}
/// 获取验证码按钮
-(void)codeButtonClick{
    
    if (![LYDUtil isPhoneNumber:self.phoneText.text]) {
        return;
    }
    @weakify(self);
    NSDictionary *pramDic = @{@"phone":EMPTY_IF_NIL(self.phoneText.text),@"appscen":@"other"};
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
    if (textField.tag == 1) {
        if (self.isGetCodeSuccess == NO) {
            if(self.phoneText.text.length == 11){
                    self.codeBut.enabled = YES;
                }else{
                    self.codeBut.enabled = NO;
                }
        }
            

    }
    if (self.phoneText.text.length == 11 && self.secretText.text.length == 6) {
        self.nextBut.enabled = YES;
    }else{
        self.nextBut.enabled = NO;
        

    }
}
/**
 协议按钮
 */
//-(void)xieYiButCLick{
//
//    self.xieYiBut.selected = !self.xieYiBut.selected;
//
//    if (self.xieYiBut.selected) {
//        [self.xieYiBut setImage:[UIImage imageNamed:@"login_no_select"] forState:UIControlStateNormal];  //login_no_select
//
//    }else{
//        [self.xieYiBut setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateNormal];  //login_no_select
//
//    }
//}

-(void)useOperatorInsert{
    
}
-(void)creatOperInsert{
    NSDictionary *dic = @{@"type":@"ios",@"userId":self.loginModel.userId};
    [[RequestAPI shareInstance] useCustAuthOperatorInsert:dic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        if (succeed) {
            if ([result[@"success"] intValue] == 1) {
                
            }else{
                
                [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

            }

        }
    }];

}
//-(MainAccationView *)accationView{
//    if (!_accationView) {
//        _accationView = [[MainAccationView alloc] initWithFrame:CGRectZero];
//        _accationView.titleLab.text= @"服务密码是中国联通、中国移动、中国电信客户的身份识别密码，由6位阿拉伯数字组合（0～9)";
//    };
//    return _accationView;
//}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(UITextField *)phoneText{
    if (!_phoneText) {
        _phoneText = [[UITextField alloc] init];
        _phoneText.font = FONT(14);
        _phoneText.keyboardType = UIKeyboardTypeNumberPad;
        _phoneText.tag = 1;
        _phoneText.placeholder = @"请输入联系人手机号";
        [_phoneText addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];

    }
    return _phoneText;
}
-(UILabel *)lineLab{
    if (!_lineLab) {
        _lineLab = [[UILabel alloc] init];
        _lineLab.backgroundColor = [UIColor colorWithHex:@"#E8E8E8"];
    }
    return _lineLab;
}
-(UITextField *)secretText{
    if (!_secretText) {
        _secretText = [[UITextField alloc] init];
        _secretText.font = FONT(14);
        _secretText.placeholder = @"验证码";
        _secretText.keyboardType = UIKeyboardTypeNumberPad;
        [_secretText addTarget:self action:@selector(codeTextClick) forControlEvents:UIControlEventEditingChanged];


    }
    return _secretText;
}
-(FSCustomButton *)codeBut{
    if (!_codeBut) {
        _codeBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        [_codeBut setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_codeBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _codeBut.titleLabel.font = FONT(12);
        _codeBut.backgroundColor = But_Bg_Color;
        _codeBut.timeInterval = TimeInterval;
        _codeBut.enabled = NO;
        _codeBut.layer.cornerRadius = 15;
        _codeBut.layer.shadowOffset = CGSizeMake(0, 2);
        _codeBut.layer.shadowOpacity = 1;
        _codeBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
        _codeBut.layer.shadowRadius = 6;
        [_codeBut addTarget:self action:@selector(codeButtonClick) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _codeBut;
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

        [_nextBut addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBut.enabled = NO;
    }
    return _nextBut;
}
//-(UIButton *)xieYiBut{
//    if (!_xieYiBut) {
//        _xieYiBut = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_xieYiBut setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateNormal];  //login_no_select
//        [_xieYiBut addTarget:self action:@selector(xieYiButCLick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _xieYiBut;
//}
//-(UITextView *)secretTextView{
//    if (!_secretTextView) {
//        _secretTextView = [[UITextView alloc] init];
//        NSString *strLink = @"已阅读并同意《用户服务密码协议》";
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strLink];
//
//        [attributedString addAttributes:@{NSLinkAttributeName:[NSURL URLWithString:@"http://www.baidu.com"], NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:[UIColor colorWithHex:@"#4D56EF"]} range:[strLink rangeOfString:@"《用户服务密码协议》"]];
//        _secretTextView.attributedText = attributedString;
//        _secretTextView.font = FONT(12);
//        _secretTextView.scrollEnabled = NO;
//        _secretTextView.textColor = [UIColor colorWithHex:@"#999999"];
//        _secretTextView.editable = NO;
//        _secretTextView.delegate = self;
//        _secretTextView.backgroundColor = [UIColor clearColor];
//    }
//    return _secretTextView;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
