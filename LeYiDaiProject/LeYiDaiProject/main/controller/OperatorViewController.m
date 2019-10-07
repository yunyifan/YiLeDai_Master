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
@property (nonatomic,strong)MainAccationView *accationView;

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UITextField *phoneText;

@property (nonatomic,strong)UILabel *lineLab;
@property (nonatomic,strong)UITextField *secretText;

@property (nonatomic,strong)UIButton *nextBut;

@property (nonatomic,strong)UIButton *xieYiBut;

@property (nonatomic,strong)UITextView *secretTextView;

@end

@implementation OperatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"额度评估-运营商认证";

    [self creatInitUI];
}
-(void)creatInitUI{
    [self.view addSubview:self.accationView];
    [self.accationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.accationView.mas_bottom);
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
    }];
    
    [self.view addSubview:self.xieYiBut];
    [self.xieYiBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nextBut.mas_bottom);
        make.left.equalTo(self.nextBut.mas_left).offset(10);
    }];
    
    [self.view addSubview:self.secretTextView];
    [self.secretTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.xieYiBut);
        make.left.equalTo(self.xieYiBut.mas_right);
    }];

}
-(void)nextButtonClick{
    
    BankAuthenViewController *bankVc = [[BankAuthenViewController alloc] init];
    [self.navigationController pushViewController:bankVc animated:YES];
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

-(MainAccationView *)accationView{
    if (!_accationView) {
        _accationView = [[MainAccationView alloc] initWithFrame:CGRectZero];
        _accationView.titleLab.text= @"服务密码是中国联通、中国移动、中国电信客户的身份识别密码，由6位阿拉伯数字组合（0～9)";
    };
    return _accationView;
}
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
        _phoneText.placeholder = @"请输入联系人手机号";
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
        _secretText.placeholder = @"服务密码";
    }
    return _secretText;
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
-(UIButton *)xieYiBut{
    if (!_xieYiBut) {
        _xieYiBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_xieYiBut setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateNormal];  //login_no_select
        [_xieYiBut addTarget:self action:@selector(xieYiButCLick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _xieYiBut;
}
-(UITextView *)secretTextView{
    if (!_secretTextView) {
        _secretTextView = [[UITextView alloc] init];
        NSString *strLink = @"已阅读并同意《用户服务密码协议》";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strLink];
        
        [attributedString addAttributes:@{NSLinkAttributeName:[NSURL URLWithString:@"http://www.baidu.com"], NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:[UIColor colorWithHex:@"#4D56EF"]} range:[strLink rangeOfString:@"《用户服务密码协议》"]];
        _secretTextView.attributedText = attributedString;
        _secretTextView.font = FONT(12);
        _secretTextView.scrollEnabled = NO;
        _secretTextView.textColor = [UIColor colorWithHex:@"#999999"];
        _secretTextView.editable = NO;
        _secretTextView.delegate = self;
        _secretTextView.backgroundColor = [UIColor clearColor];
    }
    return _secretTextView;
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
