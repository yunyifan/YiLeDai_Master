//
//  RepaymentDetialViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/11.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RepaymentDetialViewController.h"
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

@property (nonatomic,strong)UIView *centerView;
@property (nonatomic,strong)UILabel *leftPayLab;
@property (nonatomic,strong)UILabel *evenPayLab; // 已还款
@end

@implementation RepaymentDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"还款详情";
    
    [self creatDetialUI];
    
    [self setTopViewData];
}

-(void)setTopViewData{
    
    self.titLab.text = @"还款金额(元)";  // 违约： 违约还款金额
    self.moneyLab.text = @"1000.00"; //
    
    
    // 还款
    self.detialLab.text = @"对应1笔借款"; // 违约：请及时还款，保证信用良好！
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
    
    [self creatCenterView];
}
-(void)creatCenterView{
    
    [self.contentView addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(9);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.equalTo(self.contentView).offset(-20);
        
    }];
    
    self.leftPayLab = [[UILabel alloc] init];
    self.leftPayLab.font = BOLDFONT(14);
    self.leftPayLab.textColor = Tit_Black_Color;
    self.leftPayLab.text = @"本次已还";
    [self.centerView addSubview:self.leftPayLab];
    [self.leftPayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(12);
    }];
    
    self.evenPayLab = [[UILabel alloc] init];
    self.evenPayLab.font = BOLDFONT(14);
    self.evenPayLab.textColor = Tit_Black_Color;
    self.evenPayLab.text = @"1000.00";
    [self.centerView addSubview:self.evenPayLab];
    [self.evenPayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.centerY.equalTo(self.leftPayLab);
    }];
    
    UIView *lineVc = [[UIView alloc] initWithFrame:CGRectMake(16, 42, (SCREEN_WIDTH-27*2), 1)];
    [self.centerView addSubview:lineVc];
    [LYDUtil drawDashLine:lineVc lineLength:10 lineSpacing:5 lineColor:[UIColor colorWithHex:@"#E8E8E8"]];
    
    UILabel *moneyLab = [[UILabel alloc] init];
    moneyLab.font = FONT(14);
    moneyLab.textColor = [UIColor colorWithHex:@"#99A7B8"];
    moneyLab.text = @"借款金额";
    [self.centerView addSubview:moneyLab];
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftPayLab.mas_bottom).offset(28);
        make.left.equalTo(self.leftPayLab);
    }];
    
    UIImageView *arrImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
    [self.centerView addSubview:arrImg];
    [arrImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyLab);
        make.right.mas_equalTo(-10);
    }];
    
    UIButton *loanDetialBut = [UIButton buttonWithType:UIButtonTypeCustom];
    loanDetialBut.titleLabel.font = FONT(13);
    NSMutableAttributedString *string = [LYDUtil LableTextShowInBottom:@"1000.00  借款详情" InsertWithString:@"借款详情" InsertSecondStr:@"" InsertStringColor:But_Bg_Color WithInsertStringFont:BOLDFONT(13)];
    [loanDetialBut setAttributedTitle:string forState:UIControlStateNormal];
    [loanDetialBut addTarget:self action:@selector(loanDetialButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.centerView addSubview:loanDetialBut];
    [loanDetialBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrImg.mas_left).offset(-8);
        make.centerY.equalTo(moneyLab);
    }];
    
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.font = FONT(14);
    timeLab.textColor = [UIColor colorWithHex:@"#99A7B8"];
    timeLab.text = @"借款金额";
    [self.centerView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLab.mas_bottom).offset(20);
        make.left.equalTo(moneyLab);
        make.bottom.mas_equalTo(-20);
    }];
    
    UILabel *timeDataLab = [[UILabel alloc] init];
    timeDataLab.font = FONT(14);
    timeDataLab.textColor = [UIColor colorWithHex:@"#99A7B8"];
    timeDataLab.text = @"2019年07月12日";
    [self.centerView addSubview:timeDataLab];
    [timeDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.equalTo(timeLab);
    }];
}

/**
 借款详情
 */
-(void)loanDetialButtonClick{
    [MBProgressHUD showError:@"借款详情"];
}
/**
 去还款
 */
-(void)payMoneyClick{
    [MBProgressHUD showError:@"去还款"];
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
-(UIView *)centerView{
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _centerView.layer.cornerRadius = 4;
    }
    return _centerView;
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
