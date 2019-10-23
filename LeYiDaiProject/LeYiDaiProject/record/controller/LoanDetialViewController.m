//
//  LoanDetialViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/10.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "LoanDetialViewController.h"
#import "RepaymentViewController.h"
#import "RepayRecordDetialViewController.h"


#import "RecordDetialLoanView.h"
#import "LoanDetialView.h"
#import "BRPickerView.h"
#import "CheckRepayDetialView.h"

#import "LoanDetialInfoModel.h"

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


@property (nonatomic,strong)LoanDetialInfoModel *detialInfoModel;

@property (nonatomic,assign)RecordType cordType;

@property (nonatomic,strong)FSCustomButton *bottomBbut; //还款
@end

@implementation LoanDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"借款详情";
    
    [self creatDetialUI];
    
    [self useGetLoanAccountInfoInsert];
    
}
-(void)setTopViewData{
    
    if (self.detialInfoModel.lendState == 2) {
        self.titLab.text = @"放款中金额(元)";
        self.statueImg.image = [UIImage imageNamed:@"record_loan"];  // record_loan
        
        self.cordType = RecordTypeLoanning;
        
        [self loadMoneyInfoOning];

    }else if (self.detialInfoModel.lendState == 3){
        self.titLab.text = @"使用中金额(元)";
        self.detialLab.text = EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.retuKind_dictText);
        self.cordType = RecordTypeUseing;
        [self useMoneyNoRepaty];
        
    }else if (self.detialInfoModel.lendState == 5){
        self.titLab.text = @"已结清金额(元)";
        self.detialLab.text = @"好借好还，再借不难"; // 使用中：该笔额度将分两期换完
        self.statueImg.image = [UIImage imageNamed:@"record_settle"];  //
        self.cordType = RecordTypeSettlement;
        [self moneyIsClear];
    }else if (self.detialInfoModel.lendState == 4){
        // 逾期
        self.moneyLab.textColor = [UIColor colorWithHex:@"#FF0E2E"];
        self.titLab.text = @"逾期还款金额(元)";
        self.detialLab.text = @"请及时还款，保证信用良好！"; // 使用中：该笔额度将分两期换完
        self.cordType = RecordTypeDefault;
        
        [self creatBeyoundRepayTime];
    }
    self.moneyLab.text = EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.loanAmount);
    
    
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
    

 
    
}
/**
 放款中
 
 */
-(void)loadMoneyInfoOning{
    
    [self.loanView setRedordViewData:self.detialInfoModel];
    [self.contentView addSubview:self.loanView];
    [self.loanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.topView.mas_bottom).offset(9);
        make.height.mas_equalTo(100);
        make.bottom.equalTo(self.contentView).offset(-10);

    }];
    
    
    
}
/**
 使用中
 
 */
-(void)useMoneyNoRepaty{
    
    [self.loanView setRedordViewData:self.detialInfoModel];
    [self.contentView addSubview:self.loanView];
    [self.loanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.topView.mas_bottom).offset(9);
        make.height.mas_equalTo(100);
    }];

    
    [self.loanDetialView creatDetialUI:@[EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.loanAmount),[NSString stringWithFormat:@"%@到%@",self.detialInfoModel.loanAccountInfo.beginDate,self.detialInfoModel.loanAccountInfo.endDate]]];

    [self.contentView addSubview:self.loanDetialView];
    [self.loanDetialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.loanView);
        make.top.equalTo(self.loanView.mas_bottom).offset(9);
        make.bottom.equalTo(self.contentView).offset(-10);

    }];

}
/**
 已结清
 
 */
-(void)moneyIsClear{
    //  已结清金额
    [self.loanDetialView creatDetialUI:@[EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.loanAmount),[NSString stringWithFormat:@"%@到%@",self.detialInfoModel.loanAccountInfo.beginDate,self.detialInfoModel.loanAccountInfo.endDate],EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.retuKind_dictText)]];

     [self.contentView addSubview:self.loanDetialView];
     [self.loanDetialView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(10);
         make.right.mas_equalTo(-10);
         make.top.equalTo(self.topView.mas_bottom).offset(9);
         
     }];
     
    [self.repaymentDetialView.recordBut addTarget:self action:@selector(recordButtonClick) forControlEvents:UIControlEventTouchUpInside];

    self.repaymentDetialView.detialRecordType =RecordTypeRepayment;
     [self.repaymentDetialView creatDetialUI:@[EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.realCapiSum),EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.realInte),EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.realFeeSum)]];
     [self.contentView addSubview:self.repaymentDetialView];
     [self.repaymentDetialView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.equalTo(self.loanDetialView);
         make.top.equalTo(self.loanDetialView.mas_bottom).offset(9);
         make.bottom.equalTo(self.contentView).offset(-10);

     }];
}
/**
 逾期还款
 
 */
-(void)creatBeyoundRepayTime{
    
    [self.loanDetialView creatDetialUI:@[EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.loanAmount),[NSString stringWithFormat:@"%@到%@",self.detialInfoModel.loanAccountInfo.beginDate,self.detialInfoModel.loanAccountInfo.endDate],EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.retuKind_dictText)]];

     [self.contentView addSubview:self.loanDetialView];
     [self.loanDetialView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(10);
         make.right.mas_equalTo(-10);
         make.top.equalTo(self.topView.mas_bottom).offset(9);
         
     }];
     
    [self.repaymentDetialView.recordBut addTarget:self action:@selector(recordButtonClick) forControlEvents:UIControlEventTouchUpInside];

    self.repaymentDetialView.detialRecordType =RecordTypeDefault;
     [self.repaymentDetialView creatDetialUI:@[EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.realCapiSum),EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.realInte),EMPTY_IF_NIL(self.detialInfoModel.loanAccountInfo.realFeeSum)]];
     [self.contentView addSubview:self.repaymentDetialView];
     [self.repaymentDetialView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.equalTo(self.loanDetialView);
         make.top.equalTo(self.loanDetialView.mas_bottom).offset(9);
         make.bottom.equalTo(self.contentView).offset(-59);

     }];

    
    [self.view addSubview:self.bottomBbut];
    [self.bottomBbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
}
/**
 还款记录
 */
-(void)recordButtonClick{
    
    RepayRecordDetialViewController *vc = [[RepayRecordDetialViewController alloc] init];
    vc.dataArray = self.detialInfoModel.LoanRepayTermList;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma ----------------- RecordDetialLoanViewDelegate-----------------
-(void)recordDetialLoanButtonClick:(NSInteger)butTag{
    if (butTag == 1) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in self.detialInfoModel.LoanRepayTermList) {
            NSAttributedString *string = [LYDUtil LableTextShowInBottom:[NSString stringWithFormat:@"第一期%@应还 %@",dic[@"dueDate"],dic[@"realAmt"]] InsertWithString:[NSString stringWithFormat:@"%@",dic[@"realAmt"]] InsertSecondStr:@"" InsertStringColor:[UIColor colorWithHex:@"#4D56EF"] WithInsertStringFont:FONT(14)];
            [array addObject:string];
            
            

        }
        
        CheckRepayDetialView *detialVc = [[CheckRepayDetialView alloc] init];
        [detialVc creatArrayLable:array];
        [YSSModelDialog showView:detialVc andAlpha:0.3];
        [detialVc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
        }];
        

    }else{
        RepaymentViewController *repVc = [[RepaymentViewController alloc] init];
        repVc.overFlag = 1;
        [self.navigationController pushViewController:repVc animated:YES];
    }
}
-(void)bottomBUttonclick{
    
    RepaymentViewController *repVc = [[RepaymentViewController alloc] init];
    repVc.overFlag = 0;
    [self.navigationController pushViewController:repVc animated:YES];
}
/**
 借款详情
 
 */
-(void)useGetLoanAccountInfoInsert{
    
    @weakify(self);
    NSDictionary *dic = @{@"userId":EMPTY_IF_NIL(self.loginModel.userId),@"lendTransno":EMPTY_IF_NIL(self.dataDic[@"loanAcctNo"])};
    [[RequestAPI shareInstance] useGetLoanAccountInfo:dic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self);
        if (succeed) {
            if ([result[@"success"] intValue] == 1) {
                self.detialInfoModel = [LoanDetialInfoModel yy_modelWithDictionary:result[@"result"]];
                
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
-(UIImageView *)statueImg{
    if (!_statueImg) {
        _statueImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    }
    return _statueImg;
}
-(RecordDetialLoanView *)loanView{
    if (!_loanView) {
        _loanView = [[RecordDetialLoanView alloc] initWithType:self.cordType];
        _loanView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _loanView.layer.cornerRadius = 4;
        _loanView.delegate = self;
    }
    return _loanView;
}
-(LoanDetialView *)loanDetialView{
    if (!_loanDetialView) {
        _loanDetialView = [[LoanDetialView alloc] initWithType:self.cordType];
        _loanDetialView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _loanDetialView.layer.cornerRadius = 4;
    }
    return _loanDetialView;
}
-(LoanDetialView *)repaymentDetialView{
    if (!_repaymentDetialView) {
        _repaymentDetialView = [[LoanDetialView alloc] initWithType:self.cordType];
        _repaymentDetialView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _repaymentDetialView.layer.cornerRadius = 4;
    }
    return _repaymentDetialView;
}
-(FSCustomButton *)bottomBbut{
    if (!_bottomBbut) {
        _bottomBbut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        _bottomBbut.backgroundColor = [UIColor colorWithHex:@"#FF0E2E"];
        _bottomBbut.titleLabel.font = BOLDFONT(17);
        [_bottomBbut setTitle:@"去还款" forState:UIControlStateNormal];
        [_bottomBbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomBbut addTarget:self action:@selector(bottomBUttonclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBbut;
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
