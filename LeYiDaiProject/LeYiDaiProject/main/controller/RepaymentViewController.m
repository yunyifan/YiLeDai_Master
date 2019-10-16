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

@interface RepaymentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UILabel *topLine;
@property (nonatomic,strong)UILabel *leftLab;
@property (nonatomic,strong)UITextField *moneyText; // 还款金额
@property (nonatomic,strong)UILabel *lineLab;

@property (nonatomic,strong)UITableView *repayTable; // 还款列表

@property (nonatomic,strong)UIButton *sureBut;

@property (nonatomic,strong)RepaymentBottomView *bottomView;
@end

@implementation RepaymentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"还款";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F7FB"];
    [self creatDetailUI];
    
    [self useGetRepayInsert];
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
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
}
-(void)useGetRepayInsert{
    
    @weakify(self);
    [[RequestAPI shareInstance] useGetRepayList:@{@"userId":self.loginModel.userId} Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self);
        if (succeed) {
              if ([result[@"success"] intValue] == 1) {
                  
                
              }else{
                  
                  [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

              }
          }

    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RepaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[RepaymentTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    [cell.checkDetialBut addTarget:self action:@selector(detialButCick:) forControlEvents:UIControlEventTouchUpInside];

    [cell.selectBut addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)selectButtonClick:(UIButton *)button{
    [MBProgressHUD showError:@"选择"];
}
-(void)detialButCick:(FSCustomButton *)but{
    
//    @[@"还款总额",@"利息",@"费用",@"违约金"]
    [self.bottomView setDataArray:@[@"还款本金",@"利息",@"费用"] RightDataArray:@[@"500.00",@"50.00",@"10.00"]];
    [YSSModelDialog showView:self.bottomView andAlpha:0.4];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
    }];
}
-(void)sureButtonClick{
    [MBProgressHUD showError:@"确定"];
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
