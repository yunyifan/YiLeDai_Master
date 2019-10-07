//
//  LoanDetialViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/10.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "LoanDetialViewController.h"



#import "RecordDetialLoanView.h"
#import "LoanDetialView.h"

@interface LoanDetialViewController ()<RecordDetialLoanViewDelegate>
@property(nonatomic,strong)UIScrollView *baseScrollView; // 底层scrollview
@property(nonatomic,strong)UIView *contentView;              // scrollview上的容器

@property(nonatomic,strong)UIView *topView; // 顶部视图
@property (nonatomic,strong)UILabel *titLab; // 状态
@property(nonatomic,strong)UILabel *moneyLab;
@property (nonatomic,strong)UIImageView *statueImg;
@property (nonatomic,strong)UILabel *detialLab;  // 提示
/*
  放款中的UI
*/
@property (nonatomic,strong)RecordDetialLoanView *loanView;
@property (nonatomic,strong)LoanDetialView *loanDetialView;  // 借款明细

@property (nonatomic,strong)LoanDetialView *repaymentDetialView;  // 还款明细

@end

@implementation LoanDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"借款详情";
    
    [self creatDetialUI];
    [self setTopViewData];
}
-(void)setTopViewData{
    
    self.titLab.text = @"放款中金额(元)";
    self.moneyLab.text = @"1000.00";
    
    self.statueImg.image = [UIImage imageNamed:@"record_settle"];  // record_loan
    
    // 使用中
    self.detialLab.text = @"好借好还，再借不难"; // 使用中：该笔额度将分两期换完
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
        make.top.mas_equalTo(40);
        make.centerX.equalTo(self.topView);
    }];
    
    [self.topView addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titLab.mas_bottom).offset(10);
        make.centerX.equalTo(self.topView);
    }];
    
    [self.topView addSubview:self.statueImg];
    [self.statueImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.moneyLab.mas_right).offset(5);
        make.top.equalTo(self.titLab.mas_bottom);
        make.height.width.mas_equalTo(109);
    }];
    
    [self.topView addSubview:self.detialLab];
    [self.detialLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLab.mas_bottom).offset(15);
        make.centerX.equalTo(self.topView);
    }];
    
//    放款中
    
    /*
    [self.loanView setRedordViewData];
    [self.contentView addSubview:self.loanView];
    [self.loanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.topView.mas_bottom).offset(9);
        make.height.mas_equalTo(100);
    }];
    
    
    [self.loanDetialView creatDetialUI:@[@"1000.00",@"2018-09-09到2018-11-0"]];
    [self.contentView addSubview:self.loanDetialView];
    [self.loanDetialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.loanView);
        make.top.equalTo(self.loanView.mas_bottom).offset(9);
        make.bottom.equalTo(self.contentView).offset(-10);

    }];
    
    */
    //  已结清金额
    [self.loanDetialView creatDetialUI:@[@"1000.00",@"2018-09-09到2018-11-0",@"公分两期还款"]];
    [self.contentView addSubview:self.loanDetialView];
    [self.loanDetialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.topView.mas_bottom).offset(9);
        
    }];
    
    [self.repaymentDetialView creatDetialUI:@[@"1000.00",@"300.00",@"0.00"]];
    [self.contentView addSubview:self.repaymentDetialView];
    [self.repaymentDetialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.loanDetialView);
        make.top.equalTo(self.loanDetialView.mas_bottom).offset(9);
        make.bottom.equalTo(self.contentView).offset(-10);

    }];
    
}
#pragma ----------------- RecordDetialLoanViewDelegate-----------------
-(void)recordDetialLoanButtonClick:(NSInteger)butTag{
    if (butTag == 1) {
        NSLog(@"查看还款计划");
    }else{
        NSLog(@"去还款");
    }
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
-(UIImageView *)statueImg{
    if (!_statueImg) {
        _statueImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    }
    return _statueImg;
}
-(RecordDetialLoanView *)loanView{
    if (!_loanView) {
        _loanView = [[RecordDetialLoanView alloc] initWithType:RecordTypeUseing];
        _loanView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _loanView.layer.cornerRadius = 4;
        _loanView.delegate = self;
    }
    return _loanView;
}
-(LoanDetialView *)loanDetialView{
    if (!_loanDetialView) {
        _loanDetialView = [[LoanDetialView alloc] initWithType:RecordTypeSettlement];
        _loanDetialView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _loanDetialView.layer.cornerRadius = 4;
    }
    return _loanDetialView;
}
-(LoanDetialView *)repaymentDetialView{
    if (!_repaymentDetialView) {
        _repaymentDetialView = [[LoanDetialView alloc] initWithType:RecordTypeRepayment];
        _repaymentDetialView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _repaymentDetialView.layer.cornerRadius = 4;
    }
    return _repaymentDetialView;
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
