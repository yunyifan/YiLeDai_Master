//
//  RepaymentDetialViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/11.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RepaymentDetialViewController.h"
#import "LoanDetialViewController.h"
#import "LoanDetialView.h"

@interface RepaymentDetialViewController ()
@property(nonatomic,strong)UIScrollView *baseScrollView; // 底层scrollview
@property(nonatomic,strong)UIView *contentView;              // scrollview上的容器

@property(nonatomic,strong)UIView *topView; // 顶部视图
@property (nonatomic,strong)UILabel *titLab; // 状态
@property(nonatomic,strong)UILabel *moneyLab;
@property (nonatomic,strong)UILabel *detialLab;  // 提示


@property (nonatomic,strong)UIButton *payMoneyBut; // 去还款

@property (nonatomic,strong)LoanDetialView *loanDetialView;  // 借款明细

@property (nonatomic,strong)LoanDetialView *defultDetialView;  // 违约还款明细


@property (nonatomic,strong)NSDictionary *resultDic;
@property (nonatomic,strong)NSArray *repayAcctListArr;
@end

@implementation RepaymentDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"还款详情";
    
    [self creatDetialUI];
    
    
    [self useGetrepayInfoInsert];
}

-(void)setTopViewData{
    
    self.titLab.text = @"还款金额(元)";  // 违约： 违约还款金额
    self.moneyLab.text = [NSString stringWithFormat:@"%@",EMPTY_IF_NIL(self.resultDic[@"realAmt"])]; ;
    
    
    // 还款
    self.detialLab.text = [NSString stringWithFormat:@"对应%@笔借款",self.resultDic[@"loanCount"]];
    
    [self creatCenterView];

}
-(void)creatDetialUI{
    [self.view addSubview:self.baseScrollView];
    [self.baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.baseScrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.equalTo(self.baseScrollView);
        make.top.equalTo(self.baseScrollView);
        make.width.equalTo(self.baseScrollView);
        make.height.greaterThanOrEqualTo(@0.f);
    }];
    
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(193);
    }];
    
    [self.topView addSubview:self.titLab];
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(42);
        make.centerX.equalTo(self.topView);
    }];
    
    [self.topView addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titLab.mas_bottom).offset(11);
        make.centerX.equalTo(self.topView);
    }];
    
    [self.topView addSubview:self.detialLab];
    [self.detialLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLab.mas_bottom).offset(15);
        make.centerX.equalTo(self.topView);
    }];
    
    
    
    /*   违约还款
    [self.loanDetialView creatDetialUI:@[@"1000.00",@"2018-09-09到2018-11-0",@"公分两期还款"]];
    [self.contentView addSubview:self.loanDetialView];
    [self.loanDetialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.topView.mas_bottom).offset(9);
        
    }];
    
    [self.defultDetialView creatDetialUI:@[@"1000.00",@"300.32",@"0.00"]];
    [self.contentView addSubview:self.defultDetialView];
    [self.defultDetialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.loanDetialView);
        make.top.equalTo(self.loanDetialView.mas_bottom).offset(9);
        
    }];
    
    [self.contentView addSubview:self.payMoneyBut];
    [self.payMoneyBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.contentView);
        make.top.equalTo(self.defultDetialView.mas_bottom).offset(15);
        make.height.mas_equalTo(49);
    }];
     
     */
    
}
-(void)creatCenterView{
    
    UIView *lastView;
    for (int i = 0; i<self.repayAcctListArr.count; i++) {
        
        NSDictionary *dic = self.repayAcctListArr[i];
        
        UIView *centerView = [[UIView alloc] init];
        centerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        centerView.layer.cornerRadius = 4;
           
       [self.contentView addSubview:centerView];
       [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
           if (lastView) {
               make.top.equalTo(lastView.mas_bottom).offset(9);

           }else{
               make.top.equalTo(self.topView.mas_bottom).offset(9);

           }
           make.left.mas_equalTo(10);
           make.right.mas_equalTo(-10);
           
       }];
           
           UILabel *leftPayLab = [[UILabel alloc] init];
           leftPayLab.font = BOLDFONT(14);
           leftPayLab.textColor = Tit_Black_Color;
           leftPayLab.text = @"本次已还";
           [centerView addSubview:leftPayLab];
           [leftPayLab mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(16);
               make.top.mas_equalTo(12);
           }];
           
           UILabel *evenPayLab = [[UILabel alloc] init];
           evenPayLab.font = BOLDFONT(14);
           evenPayLab.textColor = Tit_Black_Color;
           evenPayLab.text = [NSString stringWithFormat:@"%@",dic[@"realAmt"]];
           [centerView addSubview:evenPayLab];
           [evenPayLab mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.mas_equalTo(-16);
               make.centerY.equalTo(leftPayLab);
           }];
           
           UIView *lineVc = [[UIView alloc] initWithFrame:CGRectMake(16, 42, (SCREEN_WIDTH-27*2), 1)];
           [centerView addSubview:lineVc];
           [LYDUtil drawDashLine:lineVc lineLength:10 lineSpacing:5 lineColor:[UIColor colorWithHex:@"#E8E8E8"]];
           
           UILabel *moneyLab = [[UILabel alloc] init];
           moneyLab.font = FONT(14);
           moneyLab.textColor = [UIColor colorWithHex:@"#99A7B8"];
           moneyLab.text = @"借款金额";
           [centerView addSubview:moneyLab];
           [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(leftPayLab.mas_bottom).offset(28);
               make.left.equalTo(leftPayLab);
           }];
           
           UIImageView *arrImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
           [centerView addSubview:arrImg];
           [arrImg mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerY.equalTo(moneyLab);
               make.right.mas_equalTo(-10);
           }];
           
           UIButton *loanDetialBut = [UIButton buttonWithType:UIButtonTypeCustom];
           loanDetialBut.titleLabel.font = FONT(13);
           loanDetialBut.tag = i+1;
           NSMutableAttributedString *string = [LYDUtil LableTextShowInBottom:[NSString stringWithFormat:@"%@   借款详情",dic[@"dueAmt"]] InsertWithString:@"借款详情" InsertSecondStr:@"" InsertStringColor:But_Bg_Color WithInsertStringFont:BOLDFONT(13)];
           [loanDetialBut setAttributedTitle:string forState:UIControlStateNormal];
        [loanDetialBut addTarget:self action:@selector(loanDetialButtonClick:) forControlEvents:UIControlEventTouchUpInside];
           [centerView addSubview:loanDetialBut];
           [loanDetialBut mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.equalTo(arrImg.mas_left).offset(-8);
               make.centerY.equalTo(moneyLab);
           }];
           
           UILabel *timeLab = [[UILabel alloc] init];
           timeLab.font = FONT(14);
           timeLab.textColor = [UIColor colorWithHex:@"#99A7B8"];
           timeLab.text = @"借款时间";
           [centerView addSubview:timeLab];
           [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(moneyLab.mas_bottom).offset(20);
               make.left.equalTo(moneyLab);
               make.bottom.mas_equalTo(-20);
           }];
           
           UILabel *timeDataLab = [[UILabel alloc] init];
           timeDataLab.font = FONT(14);
           timeDataLab.textColor = [UIColor colorWithHex:@"#99A7B8"];
           timeDataLab.text = [NSString stringWithFormat:@"%@",dic[@"createTime"]];
           [centerView addSubview:timeDataLab];
           [timeDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.mas_equalTo(-20);
               make.centerY.equalTo(timeLab);
           }];
        
        lastView = centerView;
    }
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.contentView).offset(-20);

    }];
    
   
}

/**
 借款详情
 */
-(void)loanDetialButtonClick:(UIButton *)but{
    
    NSDictionary *dic = self.repayAcctListArr[but.tag-1];
    
    LoanDetialViewController *loanDeVc = [[LoanDetialViewController alloc] init];
    loanDeVc.dataDic = dic;
    [self.navigationController pushViewController:loanDeVc animated:YES];
}
/**
 去还款
 */
-(void)payMoneyClick{
    [MBProgressHUD showError:@"去还款"];
}
/**
 还款详情
 
 */
-(void)useGetrepayInfoInsert{
    
   @weakify(self);
    [[RequestAPI shareInstance] useRepayListGetrepayInfo:@{@"userId":self.loginModel.userId,@"repayListid":EMPTY_IF_NIL(self.dataDic[@"loanAcctNo"])} Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self);
        if (succeed) {
            if ([result[@"success"] intValue] == 1) {
                self.resultDic = result[@"result"][@"repayInfo"];
                self.repayAcctListArr = result[@"result"][@"repayAcctList"];
                [self setTopViewData];

            }else{
                
                [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

            }
        }
    }];
}
-(UIScrollView *)baseScrollView{
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc]init];
        _baseScrollView.backgroundColor = [UIColor clearColor];
        _baseScrollView.showsVerticalScrollIndicator = NO;
        
    }return _baseScrollView;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor colorWithHex:@"#F6F7FB"];
    }return _contentView;
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
-(UILabel *)titLab{
    if (!_titLab) {
        _titLab = [[UILabel alloc] init];
        _titLab.font = BOLDFONT(16);
        _titLab.textColor = Tit_Black_Color;
    }
    return _titLab;
}
-(UILabel *)moneyLab{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.font = BOLDFONT(30);
        _moneyLab.textColor = But_Bg_Color;
    }
    return _moneyLab;
}
-(UILabel *)detialLab{
    if (!_detialLab) {
        _detialLab = [[UILabel alloc] init];
        _detialLab.font = FONT(13);
        _detialLab.textColor = [UIColor colorWithHex:@"#99A7B8"];
    };
    return _detialLab;
}
-(UIButton *)payMoneyBut{
    if (!_payMoneyBut) {
        _payMoneyBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _payMoneyBut.backgroundColor = [UIColor colorWithHex:@"#FF0E2E"];
        _payMoneyBut.titleLabel.font = BOLDFONT(17);
        [_payMoneyBut setTitle:@"去还款" forState:UIControlStateNormal];
        [_payMoneyBut addTarget:self action:@selector(payMoneyClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payMoneyBut;
}
-(LoanDetialView *)loanDetialView{
    if (!_loanDetialView) {
        _loanDetialView = [[LoanDetialView alloc] initWithType:RecordTypeSettlement];
        _loanDetialView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _loanDetialView.layer.cornerRadius = 4;
    }
    return _loanDetialView;
}
-(LoanDetialView *)defultDetialView{
    if (!_defultDetialView) {
        _defultDetialView = [[LoanDetialView alloc] initWithType:RecordTypeDefault];
        _defultDetialView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _defultDetialView.layer.cornerRadius = 4;
    }
    return _defultDetialView;
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
