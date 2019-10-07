//
//  LoanViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "LoanViewController.h"
#import "LoanOningViewController.h"

#import "MainAccationView.h"

@interface LoanViewController ()

@property (nonatomic,strong)MainAccationView *accationView; // 逾期警告
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UILabel *leftLab;
@property (nonatomic,strong)UITextField *moneyText; // 借款金额
@property (nonatomic,strong)UILabel *lineLab;
@property (nonatomic,strong)UILabel *bottomLab; // 单笔可借

@property (nonatomic,strong)UIView *centerView;

@property (nonatomic,strong)UIView *bankView; // 银行view
@property (nonatomic,strong)UIImageView *bankIconImg; // i银行icon
@property (nonatomic,strong)UILabel *topLab;
@property (nonatomic,strong)UILabel *bottomTimeLab;
@property (nonatomic,strong)FSCustomButton *bankButton;
@property (nonatomic,strong)UILabel *tixingLab; // 备注

@property (nonatomic,strong)UIButton *secretImg;
@property (nonatomic,strong)UITextView *secretText;


@property (nonatomic,strong)UIButton *nextBut;

@end

@implementation LoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"借款";
 
    [self initLoanUI];
}
-(void)initLoanUI{
    [self.view addSubview:self.accationView];
    [self.accationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.accationView.mas_bottom);
        make.height.mas_equalTo(90);
    }];

    self.leftLab = [[UILabel alloc] init];
    self.leftLab.font = BOLDFONT(15);
    self.leftLab.text = @"￥";
    self.leftLab.textColor = Tit_Black_Color;
    [self.topView addSubview:self.leftLab];
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.top.mas_equalTo(33);
    }];

    self.moneyText = [[UITextField alloc] init];
    self.moneyText.font = FONT(30);
//    self.moneyText.placeholder = @"请输入还款金额";
    self.moneyText.text = @"1000";
    self.moneyText.keyboardType = UIKeyboardTypePhonePad;
    self.moneyText.clearButtonMode = UITextFieldViewModeAlways;
    [self.topView addSubview:self.moneyText];
    [self.moneyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.leftLab);
        make.left.equalTo(self.leftLab.mas_right);
        make.right.mas_equalTo(-19);
        make.height.mas_equalTo(25);
    }];
    
    self.lineLab = [[UILabel alloc] init];
    self.lineLab.backgroundColor = [UIColor colorWithHex:@"#929292"];
    [self.topView addSubview:self.lineLab];
    [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLab);
        make.right.mas_equalTo(-19);
        make.top.equalTo(self.moneyText.mas_bottom).offset(3);
        make.height.mas_equalTo(1);
    }];

    self.bottomLab = [[UILabel alloc] init];
    self.bottomLab.font = FONT(12);
    self.bottomLab.textColor = Tit_Gray_Color;
    self.bottomLab.text = @"单比可借500-2000";
    [self.topView addSubview:self.bottomLab];
    [self.bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(27);
    }];
    
    self.centerView = [[UIView alloc] init];
    self.centerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.centerView.layer.cornerRadius = 4;
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.right.mas_equalTo(-11);
        make.height.mas_equalTo(140);
        make.top.equalTo(self.topView.mas_bottom).offset(6);
    }];

    NSArray *leftArr = @[@"借款周期",@"还款计划",@"总利息"];
    NSArray *rightArr = @[@"60天",@"首期9月16日应还 550.33",@"200.00"];
    UILabel *lastLab;
    for (int i = 0; i<leftArr.count; i++) {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = FONT(14);
        lable.textColor = Tit_Black_Color;
        lable.text = leftArr[i];
        [self.centerView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            if (lastLab) {
                make.top.equalTo(lastLab.mas_bottom).offset(22);
            }else{
                make.top.mas_equalTo(19);

            }
        }];
        
        FSCustomButton *button = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = FONT(14);
        [button setTitleColor:Tit_Gray_Color forState:UIControlStateNormal];
        if (i == 1) {
            button.buttonImagePosition = FSCustomButtonImagePositionRight;
            [button setImage:[UIImage imageNamed:@"down_arr"] forState:UIControlStateNormal];
            NSAttributedString *string = [LYDUtil LableTextShowInBottom:rightArr[i] InsertWithString:@"550.33" InsertSecondStr:@"" InsertStringColor:[UIColor colorWithHex:@"#4D56EF"] WithInsertStringFont:FONT(14)];
            [button setAttributedTitle:string forState:UIControlStateNormal];
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            [button addTarget:self action:@selector(planButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [button setTitle:rightArr[i] forState:UIControlStateNormal];
        }
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.centerView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lable);
            make.right.mas_equalTo(-19);
        }];
        
        lastLab = lable;
    }
    
    [self.view addSubview:self.bankView];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.centerView);
        make.top.equalTo(self.centerView.mas_bottom).offset(9);
        make.height.mas_equalTo(101);
    }];
    
    self.bankIconImg = [[UIImageView alloc] init];
    self.bankIconImg.backgroundColor = [UIColor redColor];
    self.bankIconImg.layer.cornerRadius = 17;
    self.bankIconImg.clipsToBounds = YES;
    [self.bankView addSubview:self.bankIconImg];
    [self.bankIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bankView);
        make.height.width.mas_equalTo(34);
        make.left.mas_equalTo(17);
    }];
    
    self.topLab = [[UILabel alloc] init];
    self.topLab.font = BOLDFONT(14);
    self.topLab.text = @"收款账户";
    self.topLab.textColor = Tit_Black_Color;
    [self.bankView addSubview:self.topLab];
    [self.topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankIconImg).offset(-5);
        make.left.equalTo(self.bankIconImg.mas_right).offset(5);
    }];
    
    self.bottomTimeLab = [[UILabel alloc] init];
    self.bottomTimeLab.font = FONT(12);
    self.bottomTimeLab.text = @"预计30分钟内到账";
    self.bottomTimeLab.textColor = Tit_Gray_Color;
    [self.bankView addSubview:self.bottomTimeLab];
    [self.bottomTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bankIconImg).offset(2);
        make.left.equalTo(self.topLab);
        
    }];
    
    self.bankButton = [FSCustomButton buttonWithType:UIButtonTypeCustom];
    self.bankButton.buttonImagePosition = FSCustomButtonImagePositionRight;
    self.bankButton.titleLabel.font = FONT(12);
    [self.bankButton setTitleColor:Tit_Gray_Color forState:UIControlStateNormal];
    [self.bankButton setImage:[UIImage imageNamed:@"down_arr"] forState:UIControlStateNormal];
    [self.bankButton setTitle:@"招商银行 8898" forState:UIControlStateNormal];
    self.bankButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.bankButton addTarget:self action:@selector(planButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bankView addSubview:self.bankButton];
    [self.bankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bankView);
        make.right.mas_equalTo(-20);
    }];
    
    self.tixingLab = [[UILabel alloc] init];
    self.tixingLab.font = FONT(12);
    NSAttributedString *string = [LYDUtil LableTextShowInBottom:@"*当前所选收款账户默认为到期还款账户" InsertWithString:@"*" InsertSecondStr:@"" InsertStringColor:[UIColor colorWithHex:@"#FF0E2E"] WithInsertStringFont:FONT(12)];
    self.tixingLab.attributedText = string;

    
    [self.bankView addSubview:self.tixingLab];
    [self.tixingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bankView);
        make.bottom.mas_equalTo(-12);
    }];
    
    
    
    [self.view addSubview:self.secretImg];
    [self.secretImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bankView.mas_bottom).offset(18);
        make.left.equalTo(self.bankView).offset(18);
    }];
    
    [self.view addSubview:self.secretText];
    [self.secretText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.secretImg);
        make.left.equalTo(self.secretImg.mas_right).offset(3);
    }];

    [self.view addSubview:self.nextBut];
    [self.nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.top.equalTo(self.secretText.mas_bottom).offset(60);
    }];

}
-(void)sureButtonClick{
    LoanOningViewController *loanVc = [[LoanOningViewController alloc] init];
    [self.navigationController pushViewController:loanVc animated:YES];
}
/**
 协议按钮
 */
-(void)selectSecButton{
    
    self.secretImg.selected = !self.secretImg.selected;
    
    if (self.secretImg.selected) {
        [self.secretImg setImage:[UIImage imageNamed:@"login_no_select"] forState:UIControlStateNormal];  //login_no_select
        
    }else{
        [self.secretImg setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateNormal];  //login_no_select
        
    }
}

-(void)planButtonClick{
    
    [MBProgressHUD showError:@"还款计划"];
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
-(MainAccationView *)accationView{
    if (!_accationView) {
        _accationView = [[MainAccationView alloc] initWithFrame:CGRectZero];
        _accationView.titleLab.text= @"切勿向陌生人转账！防范诈骗，保护好银行贷款资产安全";
        _accationView.img.image = [UIImage imageNamed:@"loan_icon"];
    };
    return _accationView;
}
-(UIView *)bankView{
    if (!_bankView) {
        _bankView = [[UIView alloc] init];
        _bankView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _bankView.layer.cornerRadius = 4;
    }
    return _bankView;
}
-(UIButton *)secretImg{
    if (!_secretImg) {
        _secretImg = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secretImg setImage:[UIImage imageNamed:@"login_no_select"] forState:UIControlStateNormal];
        [_secretImg addTarget:self action:@selector(selectSecButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _secretImg;
}
-(UITextView *)secretText{
    if (!_secretText) {
        _secretText = [[UITextView alloc] init];
        NSString *strLink = @"同意《借款协议》《权益服务协议》《委托扣款协议》";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:strLink];
        [attributedString addAttributes:@{NSLinkAttributeName:[NSURL URLWithString:[NSString stringWithFormat:@"www.baidu.com"]], NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:[UIColor blueColor]} range:[strLink rangeOfString:@"《借款协议》"]];
        
        [attributedString addAttributes:@{NSLinkAttributeName:[NSURL URLWithString:[NSString stringWithFormat:@"www.baidu.com"]], NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:[UIColor blueColor]} range:[strLink rangeOfString:@"《权益服务协议》"]];
        
        [attributedString addAttributes:@{NSLinkAttributeName:[NSURL URLWithString:[NSString stringWithFormat:@"www.baidu.com"]], NSFontAttributeName:FONT(12),NSForegroundColorAttributeName:[UIColor blueColor]} range:[strLink rangeOfString:@"《委托扣款协议》"]];
        
        _secretText.attributedText = attributedString;
        _secretText.font = FONT(12);
        _secretText.backgroundColor = [UIColor clearColor];
        _secretText.scrollEnabled = NO;
        _secretText.editable = NO;
//        _secretText.delegate = self;
    }
    return _secretText;
}
-(UIButton *)nextBut{
    if (!_nextBut) {
        _nextBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBut setBackgroundImage:[UIImage imageNamed:@"but_enable"] forState:UIControlStateNormal];
        _nextBut.titleLabel.font = BOLDFONT(18);
        [_nextBut setTitle:@"确认借款" forState:UIControlStateNormal];
        [_nextBut addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
