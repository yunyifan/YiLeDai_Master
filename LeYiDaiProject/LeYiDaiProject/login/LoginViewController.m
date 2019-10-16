//
//  LoginViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/5.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *descLab;

// 电话号
@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UIView *lineVc1;
// 验证码
@property (nonatomic,strong)UITextField *codeText;
@property (nonatomic,strong)FSCustomButton *codeBut;
@property (nonatomic,strong)UIView *lineVc2;

@property (nonatomic,strong)FSCustomButton *loginBut; // 登录按钮
//@property (nonatomic,strong)UIButton *sceretBut; // 密码登录 1.0版本不做

@property (nonatomic,strong)UIButton *xieYiBut;
@property (nonatomic,strong)UITextView *secretText;

@property (nonatomic,assign)BOOL isGetCodeSuccess; // 是否获取验证码成功 ，获取验证码60s内，获取验证码按钮不高亮

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initLoginUI];

}

/**
 协议按钮
 */
-(void)xieYiButCLick{
    
    self.xieYiBut.selected = !self.xieYiBut.selected;
    
    if (self.xieYiBut.selected) {
        [self.xieYiBut setImage:[UIImage imageNamed:@"login_no_select"] forState:UIControlStateNormal];  //login_no_select

    }else{
        [self.xieYiBut setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateNormal];  //login_no_select

    }
}
-(void)initLoginUI{
    
    
    [self.view addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(98);
        make.left.equalTo(self.view).offset(30);
    }];
    
    [self.view addSubview:self.descLab];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(8);
        make.left.equalTo(self.titleLab);
    }];
    
    [self.view addSubview:self.lineVc1];
    [self.lineVc1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.descLab.mas_bottom).offset(75);
    }];
    
    [self.view addSubview:self.phoneText];
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineVc1.mas_top).offset(-10);
        make.left.equalTo(self.lineVc1);
        make.right.equalTo(self.lineVc1).offset(-10);
    }];
    
    
    [self.view addSubview:self.lineVc2];
    [self.lineVc2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineVc1);
        make.right.equalTo(self.lineVc1);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.lineVc1.mas_bottom).offset(60);
    }];
    
    [self.view addSubview:self.codeBut];
    [self.codeBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lineVc2);
        make.bottom.equalTo(self.lineVc2.mas_top).offset(-8);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(30);
    }];
    
    
    [self.view addSubview:self.codeText];
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.right.equalTo(self.codeBut.mas_left).offset(-10);
        make.centerY.equalTo(self.codeBut).offset(3);
    }];
    
//    [self.view addSubview:self.sceretBut];
//    [self.sceretBut mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.lineVc2);
//        make.right.equalTo(self.codeBut);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(30);
//    }];
    
    [self.view addSubview:self.loginBut];
    [self.loginBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.lineVc2.mas_bottom).offset(49);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(45);
    }];
    
    [self.view addSubview:self.xieYiBut];
    [self.xieYiBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBut.mas_bottom).offset(20);
        make.left.equalTo(self.loginBut);
    }];
    
    [self.view addSubview:self.secretText];
    [self.secretText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.xieYiBut);
        make.left.equalTo(self.xieYiBut.mas_right);
    }];
    
}

-(void)textDidChange{
    
    [self textFieldDidChange:self.phoneText LimitLength:11];

}
-(void)codeTextClick{
    [self textFieldDidChange:self.codeText LimitLength:6];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
/// 获取验证码按钮
-(void)codeButtonClick{
    
    if (![LYDUtil isPhoneNumber:self.phoneText.text]) {
        return;
    }
    @weakify(self);
    NSDictionary *pramDic = @{@"phone":EMPTY_IF_NIL(self.phoneText.text),@"appscen":@"login"};
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
// 登录
-(void)loginButClick{
    NSDictionary *pramDic = @{@"accountType":@"mobile",@"account":self.phoneText.text,@"password":self.codeText.text};
    @weakify(self);
    [[RequestAPI shareInstance] useLoginInsert:pramDic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        if (succeed) {
            @strongify(self);
            if ([result[@"success"] intValue] == 1) {
                NSMutableDictionary *dic = [LYDUtil nullDicToDic:result[@"result"]];
                [self.loginModel setLogonData:dic];
                
                [[AppDelegate shareAppDelegate] initCustomWindow];
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
    if (self.phoneText.text.length == 11 && self.codeText.text.length == 6) {
        self.loginBut.enabled = YES;
    }else{
        self.loginBut.enabled = NO;
        

    }
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = BOLDFONT(20);
        _titleLab.text = @"登录";
    }
    return _titleLab;
}
-(UILabel *)descLab{
    if (!_descLab) {
        _descLab = [[UILabel alloc] init];
        _descLab.font = BOLDFONT(13);
        _descLab.text = @"欢迎使用***贷";
    }
    return _descLab;
}
-(UITextField *)phoneText{
    if (!_phoneText) {
        _phoneText = [[UITextField alloc] init];
        _phoneText.placeholder = @"请输入联系人手机号";
        _phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneText.font = FONT(14);
        _phoneText.keyboardType = UIKeyboardTypeNumberPad;
        _phoneText.tag = 1;
        [_phoneText addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];

    }
    return _phoneText;
}
-(UIView *)lineVc1{
    if (!_lineVc1) {
        _lineVc1 = [[UIView alloc] init];
        _lineVc1.backgroundColor = Line_Color;
    }
    return _lineVc1;
}
-(UITextField *)codeText{
    if (!_codeText) {
        _codeText = [[UITextField alloc] init];
        _codeText.placeholder = @"请输入验证码";
        _codeText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeText.font = FONT(14);
        _codeText.keyboardType = UIKeyboardTypeNumberPad;
        _codeText.tag = 2;
        _codeText.delegate = self;
        [_codeText addTarget:self action:@selector(codeTextClick) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeText;
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
-(UIView *)lineVc2{
    if (!_lineVc2) {
        _lineVc2 = [[UIView alloc] init];
        _lineVc2.backgroundColor = Line_Color;
    }
    return _lineVc2;
}
-(FSCustomButton *)loginBut{
    if (!_loginBut) {
        _loginBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        _loginBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];
        [_loginBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBut.titleLabel.font = BOLDFONT(18);
        [_loginBut setTitle:@"登录" forState:UIControlStateNormal];
        _loginBut.layer.shadowOffset = CGSizeMake(0, 2);
        _loginBut.layer.shadowOpacity = 1;
        _loginBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
        _loginBut.layer.shadowRadius = 9;
        _loginBut.enabled = NO;
        [_loginBut addTarget:self action:@selector(loginButClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginBut;
}
//-(UIButton *)sceretBut{
//    if (!_sceretBut) {
//        _sceretBut = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_sceretBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _sceretBut.titleLabel.font = FONT(12);
//        [_sceretBut setTitle:@"密码登录" forState:UIControlStateNormal];
//
//    }
//    return _sceretBut;
//}
-(UIButton *)xieYiBut{
    if (!_xieYiBut) {
        _xieYiBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_xieYiBut setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateNormal];  //login_no_select
        [_xieYiBut addTarget:self action:@selector(xieYiButCLick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _xieYiBut;
}
-(UITextView *)secretText{
    if (!_secretText) {
        _secretText = [[UITextView alloc] init];
        NSString *strLink = @"我已阅读并同意《用户协议》";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strLink];
        
        [attributedString addAttributes:@{NSLinkAttributeName:[NSURL URLWithString:@"http://www.baidu.com"], NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:[UIColor colorWithHex:@"#4D56EF"]} range:[strLink rangeOfString:@"《用户协议》"]];
        _secretText.attributedText = attributedString;
        _secretText.font = FONT(12);
        _secretText.scrollEnabled = NO;
        _secretText.textColor = [UIColor colorWithHex:@"#999999"];
        _secretText.editable = NO;
        _secretText.delegate = self;
        _secretText.backgroundColor = [UIColor clearColor];
    }
    return _secretText;
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
