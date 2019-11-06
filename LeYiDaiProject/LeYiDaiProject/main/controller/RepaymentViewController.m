//
//  RepaymentViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/15.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RepaymentViewController.h"
#import "RepaymentTableViewCell.h"
#import "RepaymentBottomView.h"
#import "MyBankViewController.h"

#import "RepaySelectBankView.h"
#import "YSSModelDialog.h"
#import "RepayDueModel.h"
#import "BankDetialModel.h"
#import "IQKeyboardManager.h"

@interface RepaymentViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UILabel *topLine;
@property (nonatomic,strong)UILabel *leftLab;
@property (nonatomic,strong)UITextField *moneyText; // 还款金额
@property (nonatomic,strong)UILabel *lineLab;

@property (nonatomic,strong)UITableView *repayTable; // 还款列表

@property (nonatomic,strong)UIButton *sureBut;

@property (nonatomic,strong)RepaymentBottomView *bottomView;

@property (nonatomic,strong)NSMutableArray *selectArray; // 选中的数据
@property (nonatomic,strong)NSMutableArray *dataArray; //总数据

@property (nonatomic,strong) RepaySelectBankView *bankView;

@property (nonatomic,strong)NSDictionary *dataDictt;
@end

@implementation RepaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    if (self.overFlag == 0) {
        self.navigationItem.title = @"逾期还款";

    }else{
        self.navigationItem.title = @"还款";

    }
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F7FB"];
    [self creatDetailUI];
    
    [self useGetRepayInsert];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationClick:) name:@"Bank_Model" object:nil];

}
-(void)notificationClick:(NSNotification *)info{
    
    BankDetialModel *detialModl = (BankDetialModel *)info.object;
    
//    self.firstBankModel = [[BankDetialModel alloc] init];
    NSString *strCar = [detialModl.bankcardNo substringFromIndex:detialModl.bankcardNo.length-4];
    NSString *butStr = [NSString stringWithFormat:@"%@  %@",detialModl.cardBankname,strCar];

    [_bankView.bankNum setTitle:[NSString stringWithFormat:@"%@",butStr] forState:UIControlStateNormal];
}

-(void)creatDetailUI{
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(90);
    }];
    
    self.topLine = [[UILabel alloc] init];
    self.topLine.backgroundColor = [UIColor colorWithHex:@"#EEEEEE"];
    [self.topView addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.topView);
        make.height.mas_equalTo(1);
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
    self.moneyText.font = FONT(16);
    self.moneyText.placeholder = @"请输入还款金额";
    [self.topView addSubview:self.moneyText];
    [self.moneyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftLab);
        make.left.equalTo(self.leftLab.mas_right).offset(10);
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
    
    [self.view addSubview:self.repayTable];
    [self.repayTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.mas_equalTo(-45);
    }];
    
    
    [self.view addSubview:self.sureBut];
    [self.sureBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RepaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[RepaymentTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.cellOverFlag = self.overFlag;
    [cell.checkDetialBut addTarget:self action:@selector(detialButCick:) forControlEvents:UIControlEventTouchUpInside];

    [cell.selectBut addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSDictionary *modelDic = self.dataArray[indexPath.row];

    if ([self.selectArray containsObject:modelDic]) {

        [cell.selectBut setImage:[UIImage imageNamed:@"repay_select"] forState:UIControlStateNormal];

    }else{
        [cell.selectBut setImage:[UIImage imageNamed:@"repay_select_no"] forState:UIControlStateNormal];

    }

    RepayDueModel *repayModel = [RepayDueModel yy_modelWithDictionary:modelDic];
    [cell setRepayCellData:repayModel];
    return cell;
}
/**
 多选
 
 */
-(void)selectButtonClick:(UIButton *)button{
    
    UIView *cellVewi = button.superview.superview;
    
    RepaymentTableViewCell *cell = (RepaymentTableViewCell *)[cellVewi superview];
    
    NSIndexPath *indexPath = [self.repayTable indexPathForCell:cell];
    
    NSDictionary *modelDic = self.dataArray[indexPath.row];
    

    if ([self.selectArray containsObject:modelDic]) {
        if (self.selectArray.count == 1) {
            return;
        }else{
            [self.selectArray removeObject:modelDic];
        }
    }else{
        [self.selectArray addObject:modelDic];

    }

    [self.repayTable reloadData];
    
    [self getAllAmutMoney];
}
-(void)detialButCick:(FSCustomButton *)but{
    
    UIView *cellVewi = but.superview.superview;
    
    RepaymentTableViewCell *cell = (RepaymentTableViewCell *)cellVewi;
    
    NSIndexPath *indexPath = [self.repayTable indexPathForCell:cell];
    
    NSDictionary *modelDic  = self.dataArray[indexPath.row];
    
    RepayDueModel *repayModel = [RepayDueModel yy_modelWithDictionary:modelDic];

    
//    @[@"还款总额",@"利息",@"费用",@"违约金"]
    [self.bottomView setDataArray:@[@"还款本金",@"利息",@"费用"] RightDataArray:@[EMPTY_IF_NIL(repayModel.dueCapi),EMPTY_IF_NIL(repayModel.dueInte),EMPTY_IF_NIL(repayModel.dueOtherfee)]];
    [YSSModelDialog showView:self.bottomView andAlpha:0.4];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
    }];
}
-(void)getAllAmutMoney{
    float allMoney = 0.00;
    for (NSDictionary *dic in self.selectArray) {
        NSString *str = [NSString stringWithFormat:@"%@",dic[@"dueAmt"]];
        allMoney = allMoney + [str floatValue];
    }
    
    self.moneyText.text = [NSString stringWithFormat:@"%.2f",allMoney];

    
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}
#pragma mark -------------选择银行卡--------------------
-(void)selectBankViewClick{
    MyBankViewController *bankVc = [[MyBankViewController alloc] init];
    [self.navigationController pushViewController:bankVc animated:YES];
}
-(void)repayButClick{
    
    [self.bankView removeFromSuperview];
    NSMutableArray *repayAccnoArr = [NSMutableArray array];
    for (NSDictionary *dic in self.selectArray) {
        [repayAccnoArr addObject:[NSString stringWithFormat:@"%@",dic[@"repayAccno"]]];
    }
    NSDictionary *dic = @{@"userId":self.loginModel.userId,@"repayaccNo":self.dataDictt[@"bankcardNo"],@"repayAccname":self.dataDictt[@"bankcardName"],@"realAmt":self.moneyText.text,@"loanAcctNos":repayAccnoArr};
    [[RequestAPI shareInstance] useRepayListUpInsert:dic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        if (succeed) {
              if ([result[@"success"] intValue] == 1) {
                  [MBProgressHUD showSuccess:@"还款成功"];
                  [self.navigationController popViewControllerAnimated:YES];
              }else{
                  
                  [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

              }
          }

    }];
    
}
-(void)sureButtonClick{
    
    self.bankView = [[RepaySelectBankView alloc] init];
    NSAttributedString *string = [LYDUtil LableTextShowInBottom:[NSString stringWithFormat:@"￥%@",self.moneyText.text] InsertWithString:@"￥" InsertSecondStr:@"" InsertStringColor:Tit_Black_Color WithInsertStringFont:BOLDFONT(16)];

    [self.bankView.moneyLab setAttributedText:string];
    
    NSString *cardStr = [NSString stringWithFormat:@"%@",self.dataDictt[@"bankcardNo"]];
    NSString *strCar = [cardStr substringFromIndex:cardStr.length-4];
    NSString *butStr = [NSString stringWithFormat:@"%@  %@",self.dataDictt[@"cardBankname"],strCar];

    [self.bankView.bankNum setTitle:[NSString stringWithFormat:@"%@",butStr] forState:UIControlStateNormal];
    [self.view addSubview:self.bankView];
    [self.bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.bankView.bankNum addTarget:self action:@selector(selectBankViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bankView.repayBut addTarget:self action:@selector(repayButClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)useGetRepayInsert{
    
    @weakify(self);
    [[RequestAPI shareInstance] useGetRepayList:@{@"userId":self.loginModel.userId} Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self);
        if (succeed) {
              if ([result[@"success"] intValue] == 1) {
                  [self.dataArray removeAllObjects];
                  [self.selectArray removeAllObjects];
                  NSArray *Array = result[@"result"][@"repayList"];
                  self.dataDictt = result[@"result"];
                  [self.dataArray addObjectsFromArray:Array];
                  
                  NSDictionary *dic = self.dataArray[0];
                  self.moneyText.text = [NSString stringWithFormat:@"%@",dic[@"dueAmt"]];
                                
                  [self.selectArray addObject:dic];
                  
                  [self.repayTable reloadData];
                
              }else{
                  
                  [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

              }
          }

    }];
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
-(UITableView *)repayTable{
    if (!_repayTable) {
        _repayTable = [[UITableView alloc] init];
        _repayTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _repayTable.rowHeight = 114;
        _repayTable.backgroundColor = [UIColor clearColor];
        _repayTable.dataSource = self;
        _repayTable.delegate = self;
        [_repayTable registerClass:[RepaymentTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _repayTable;
}
-(RepaymentBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[RepaymentBottomView alloc] init];

    }
    return _bottomView;
}
-(UIButton *)sureBut{
    if (!_sureBut) {
        _sureBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBut.titleLabel.font = BOLDFONT(18);
        _sureBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];
        [_sureBut setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBut addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBut;
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
