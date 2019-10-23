//
//  LoanViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "LoanViewController.h"
#import "LoanOningViewController.h"
#import "MyBankViewController.h"

#import "IQKeyboardManager.h"
#import "MainAccationView.h"

#import "RepayDueModel.h"
#import "BankDetialModel.h"

#import "BRPickerView.h"

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
//@property (nonatomic,strong)UILabel *bottomTimeLab;
@property (nonatomic,strong)FSCustomButton *bankButton;
@property (nonatomic,strong)UILabel *tixingLab; // 备注

@property (nonatomic,strong)UIButton *secretImg;
@property (nonatomic,strong)UITextView *secretText;


@property (nonatomic,strong)UIButton *nextBut;

@property (nonatomic,strong)NSMutableArray *repayDueListArray;
@property (nonatomic,strong)NSDictionary *dataDic;

@property (nonatomic,strong)BankDetialModel *firstBankModel;
@end

@implementation LoanViewController
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.repayDueListArray = [NSMutableArray array];
    self.navigationItem.title = @"借款";

    [self initLoanUI];
    [self useGetRepayInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationClick:) name:@"Bank_Model" object:nil];

}
-(void)notificationClick:(NSNotification *)info{
    
    BankDetialModel *detialModl = (BankDetialModel *)info.object;
    
//    self.firstBankModel = [[BankDetialModel alloc] init];
    self.firstBankModel = detialModl;
    [self reloadBankView];
}
-(void)textCLick:(UITextField *)textFi{
    if (STRING_ISNIL(textFi.text)) {
        self.nextBut.enabled = NO;
    }else{
        self.nextBut.enabled = YES;
    }
    
    if ([textFi.text intValue] > [self.creditLeftamtStr intValue]) {
        
        self.bottomLab.text = @"平台最高可借额度20000元";
        self.bottomLab.textColor = [UIColor colorWithHex:@"#FB1A38"];
        
        return;

    }else{
        self.bottomLab.text = [NSString stringWithFormat:@"单比可借%@",self.creditLeftamtStr];
        self.bottomLab.textColor = Tit_Gray_Color;

    }
    
    [self useGetRepayInfo];
   
}
/**
 还款计算
 
 */
-(void)useGetRepayInfo{
    
    NSString *moneyStr = self.moneyText.text ? self.creditLeftamtStr : self.moneyText.text;
    @weakify(self);
    [[RequestAPI shareInstance] useLoanLendTradeGetRepayInfo:@{@"userId":self.loginModel.userId,@"lendAmount":moneyStr} Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self);
           if (succeed) {
               if ([result[@"success"] intValue] == 1) {
                   
                   [self.repayDueListArray removeAllObjects];
                   NSArray *Array = result[@"result"][@"repayDueList"];
                   self.dataDic = result[@"result"];
                   for (NSDictionary *dic in Array) {
                       RepayDueModel *model = [RepayDueModel yy_modelWithDictionary:dic];
                       
                       [self.repayDueListArray addObject:model];
                   }
                   
                   [self relodHuanKuanCenterView];
                   
                   [self useGetBankList];
                  
               }else{
                   
                   [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

               }
           }

       }];
}
/**
 查询可用银行卡
 
 */
-(void)useGetBankList{
        
    @weakify(self);
    [[RequestAPI shareInstance] quryCustBankcardQueryList:@{@"userId":self.loginModel.userId} Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self);
        if (succeed) {
              if ([result[@"success"] intValue] == 1) {
                  
                  NSArray *Array = result[@"result"][@"bankList"];
                  NSDictionary *firstDic = Array[0];
                  self.firstBankModel = [BankDetialModel yy_modelWithDictionary:firstDic];
                  [self reloadBankView];
              }else{
                  
                  [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

              }
          }
    }];

}
/**
 
 申请放款
 */
-(void)useLoanLendTradeUp{
    @weakify(self);
    NSDictionary *praDic = @{@"userId":self.loginModel.userId,@"lendAmount":EMPTY_IF_NIL(self.moneyText.text),@"lendBankid":EMPTY_IF_NIL(self.firstBankModel.cardBankid),@"lendBankname":self.firstBankModel.bankcardName,@"lendCardNo":self.firstBankModel.bankcardNo };
    [[RequestAPI shareInstance] useLoanLendTradeUpInsert:praDic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self);
        if (succeed) {
              if ([result[@"success"] intValue] == 1) {
                  
                 LoanOningViewController *loanVc = [[LoanOningViewController alloc] init];
                  loanVc.dataDic = result[@"result"];
                  loanVc.detailModel = self.firstBankModel;
                 [self.navigationController pushViewController:loanVc animated:YES];
              }else{
                  
                  [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

              }
          }

    }];
}
/*
 刷新银行卡
 
 */
-(void)reloadBankView{
   
    [self.view addSubview:self.bankView];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.centerView);
        make.top.equalTo(self.centerView.mas_bottom).offset(9);
        make.height.mas_equalTo(100);
    }];
           
       if (!self.bankIconImg) {
         self.bankIconImg = [[UIImageView alloc] init];
           [self.bankIconImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"bankImage"]];
           self.bankIconImg.layer.cornerRadius = 17;
           self.bankIconImg.clipsToBounds = YES;
       }
           
       [self.bankView addSubview:self.bankIconImg];
       [self.bankIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.bankView.mas_centerY).offset(-15);
           make.height.width.mas_equalTo(34);
           make.left.mas_equalTo(17);
       }];
           
       if (!self.topLab) {
           
           self.topLab = [[UILabel alloc] init];
          self.topLab.font = BOLDFONT(14);
          self.topLab.text = @"收款账户";
          self.topLab.textColor = Tit_Black_Color;
       }
          
       [self.bankView addSubview:self.topLab];
       [self.topLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.bankIconImg);
           make.left.equalTo(self.bankIconImg.mas_right).offset(5);
       }];
//       if (!self.bottomTimeLab) {
//
//          self.bottomTimeLab = [[UILabel alloc] init];
//          self.bottomTimeLab.font = FONT(12);
//          self.bottomTimeLab.text = @"预计30分钟内到账";
//          self.bottomTimeLab.textColor = Tit_Gray_Color;
//       }
          
//       [self.bankView addSubview:self.bottomTimeLab];
//       [self.bottomTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.bottom.equalTo(self.bankIconImg).offset(2);
//           make.left.equalTo(self.topLab);
//
//       }];
        
       if (!self.bankButton) {
           self.bankButton = [FSCustomButton buttonWithType:UIButtonTypeCustom];
           }

          self.bankButton.buttonImagePosition = FSCustomButtonImagePositionRight;
          self.bankButton.titleLabel.font = FONT(12);
          [self.bankButton setTitleColor:Tit_Gray_Color forState:UIControlStateNormal];
          [self.bankButton setImage:[UIImage imageNamed:@"down_arr"] forState:UIControlStateNormal];
           NSString *strCar = [self.firstBankModel.bankcardNo substringFromIndex:self.firstBankModel.bankcardNo.length-4];
           NSString *butStr = [NSString stringWithFormat:@"%@  %@",self.firstBankModel.bankcardName,strCar];
           NSLog(@"*****%@*****",self.firstBankModel.bankcardName);

          [self.bankButton setTitle:butStr forState:UIControlStateNormal];
          self.bankButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
          [self.bankButton addTarget:self action:@selector(chouseCardButtonClick) forControlEvents:UIControlEventTouchUpInside];
          
           [self.bankView addSubview:self.bankButton];
           [self.bankButton mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerY.equalTo(self.bankIconImg);
               make.right.mas_equalTo(-20);
           }];
           
       if (!self.tixingLab) {
           self.tixingLab = [[UILabel alloc] init];
          self.tixingLab.font = FONT(12);
          NSAttributedString *string = [LYDUtil LableTextShowInBottom:@"*当前所选收款账户默认为到期还款账户" InsertWithString:@"*" InsertSecondStr:@"" InsertStringColor:[UIColor colorWithHex:@"#FF0E2E"] WithInsertStringFont:FONT(12)];
          self.tixingLab.attributedText = string;
       }
       [self.bankView addSubview:self.tixingLab];
       [self.tixingLab mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.topLab);
           make.top.equalTo(self.bankIconImg.mas_bottom).offset(10);
       //        make.bottom.mas_equalTo(-12);
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
              make.height.mas_equalTo(45);
          }];
}
/**
 请求刷新银行卡
 */
-(void)relodHuanKuanCenterView{
    
    if (!self.centerView) {
        self.centerView = [[UIView alloc] init];
        self.centerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.centerView.layer.cornerRadius = 4;

    }
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.right.mas_equalTo(-11);
        make.height.mas_equalTo(140);
        make.top.equalTo(self.topView.mas_bottom).offset(6);
    }];
    for (UIView *subView in self.centerView.subviews) {
        if (subView.tag>=1000) {
            [subView removeFromSuperview];
        }
    }
        RepayDueModel *dueModel = [self.repayDueListArray firstObject];
        NSArray *leftArr = @[@"借款周期",@"还款计划",@"总利息"];
        NSArray *rightArr = @[[NSString stringWithFormat:@"%@天",self.dataDic[@"term"]],[NSString stringWithFormat:@"首期%@应还 %@",dueModel.dueDate,dueModel.dueSum] ,self.dataDic[@"dueSum"]];
        UILabel *lastLab;
        for (int i = 0; i<leftArr.count; i++) {
            UILabel *lable = [[UILabel alloc] init];
            lable.font = FONT(14);
            lable.textColor = Tit_Black_Color;
            lable.tag = 1000+i;
            lable.text = [NSString stringWithFormat:@"%@",leftArr[i]];
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
            button.tag = 1200+i;
            [button setTitleColor:Tit_Gray_Color forState:UIControlStateNormal];
            if (i == 1) {
                button.buttonImagePosition = FSCustomButtonImagePositionRight;
                [button setImage:[UIImage imageNamed:@"down_arr"] forState:UIControlStateNormal];
                NSAttributedString *string = [LYDUtil LableTextShowInBottom:rightArr[i] InsertWithString:[NSString stringWithFormat:@"%@",dueModel.dueSum] InsertSecondStr:@"" InsertStringColor:[UIColor colorWithHex:@"#4D56EF"] WithInsertStringFont:FONT(14)];
                [button setAttributedTitle:string forState:UIControlStateNormal];
                button.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
                [button addTarget:self action:@selector(planButtonClick) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [button setTitle:[NSString stringWithFormat:@"%@",rightArr[i]] forState:UIControlStateNormal];
            }
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [self.centerView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(lable);
                make.right.mas_equalTo(-19);
            }];
            
            lastLab = lable;
        }
        
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
    self.moneyText.placeholder = @"请输入借款金额";
    self.moneyText.text = self.creditLeftamtStr;
    self.moneyText.keyboardType = UIKeyboardTypePhonePad;
    self.moneyText.clearButtonMode = UITextFieldViewModeAlways;

    [self.moneyText addTarget:self action:@selector(textCLick:) forControlEvents:UIControlEventEditingChanged];
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
    self.bottomLab.text = [NSString stringWithFormat:@"单比可借%@",self.creditLeftamtStr];
    [self.topView addSubview:self.bottomLab];
    [self.bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(27);
    }];
    
   

}
-(void)sureButtonClick{
    
    [self useLoanLendTradeUp];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/**
 协议按钮
 */
-(void)selectSecButton{
    
//    self.secretImg.selected = !self.secretImg.selected;
//
//    if (self.secretImg.selected) {
//        [self.secretImg setImage:[UIImage imageNamed:@"login_no_select"] forState:UIControlStateNormal];  //login_no_select
//
//    }else{
//        [self.secretImg setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateNormal];  //login_no_select
//
//    }
}
/**
 选择银行卡
 
 */
-(void)chouseCardButtonClick{
    
    MyBankViewController *bankVc = [[MyBankViewController alloc] init];
    [self.navigationController pushViewController:bankVc animated:YES];
}
/**
 还款计划
 
 */
-(void)planButtonClick{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<self.repayDueListArray.count; i++) {
        RepayDueModel *dueModel = self.repayDueListArray[i];
        [array addObject:[NSString stringWithFormat:@"第%d期%@应还%@",i+1,dueModel.dueDate,dueModel.dueSum]];

    }
    [BRStringPickerView showStringPickerWithTitle:@"还款计划" dataSource:array defaultSelValue:@"" isAutoSelect:NO themeColor:[UIColor colorWithHex:@"#4D56EF"] resultBlock:^(id selectValue) {
       

    }];

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
        [_secretImg setImage:[UIImage imageNamed:@"login_select"] forState:UIControlStateNormal];
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
        _nextBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];
        [_nextBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBut.layer.shadowOffset = CGSizeMake(0, 2);
        _nextBut.layer.shadowOpacity = 1;
        _nextBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
        _nextBut.layer.shadowRadius = 9;
        _nextBut.titleLabel.font = BOLDFONT(18);
        _nextBut.timeInterval = 5;
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
