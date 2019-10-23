//
//  MyBankViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/7.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "MyBankViewController.h"
#import "BankAuthenViewController.h"

#import "BankTableViewCell.h"

#import "BankDetialModel.h"
@interface MyBankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *bankTableView;

@property (nonatomic,strong)NSMutableArray *modelArray;
@end

@implementation MyBankViewController
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self useQuryBankInsert];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.modelArray = [NSMutableArray array];
    self.navigationItem.title = @"银行卡";
    
    self.bankTableView.tableFooterView = [self tableFootView];
    [self.view addSubview:self.bankTableView];
    [self.bankTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(UIView *)tableFootView{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    
    FSCustomButton *addBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
    addBut.buttonImagePosition = FSCustomButtonImagePositionLeft;
    addBut.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    addBut.titleLabel.font = FONT(16);
    [addBut setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [addBut addTarget:self action:@selector(addBankClick) forControlEvents:UIControlEventTouchUpInside];
    [addBut setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    [footView addSubview:addBut];
    [addBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
    }];
    
    UIView *lingView = [[UIView alloc] init];
    lingView.backgroundColor = Line_Color;
    [footView addSubview:lingView];
    [lingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.equalTo(addBut.mas_bottom).offset(10);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(1);
    }];
    
    
    return footView;
}
-(void)addBankClick{
    BankAuthenViewController *bankAuthVc = [[BankAuthenViewController alloc] init];
    bankAuthVc.isAddBank = YES;
    [self.navigationController pushViewController:bankAuthVc animated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[BankTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    BankDetialModel *model = self.modelArray[indexPath.row];
    [cell setCellData:model];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BankDetialModel *model = self.modelArray[indexPath.row];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"Bank_Model" object:model];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)useQuryBankInsert{
    
    @weakify(self);
    [[RequestAPI shareInstance] quryCustBankcardQueryList:@{@"custId":EMPTY_IF_NIL(self.loginModel.custId),@"userId":self.loginModel.userId} Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self);
        if (succeed) {
            if ([result[@"success"] intValue] == 1) {
                [self.modelArray removeAllObjects];
                NSArray *array = result[@"result"][@"bankList"];
                for (NSDictionary *dic in array) {
                    BankDetialModel *model = [BankDetialModel yy_modelWithDictionary:dic];
                    [self.modelArray addObject:model];
                }
                
                [self.bankTableView reloadData];
              
            }else{
                
                [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

            }
        }
    }];
}
-(UITableView *)bankTableView{
    if (!_bankTableView) {
        _bankTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _bankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bankTableView.rowHeight = 120;
//        _bankTableView.estimatedRowHeight = 110;
        _bankTableView.dataSource = self;
        _bankTableView.delegate = self;
        [_bankTableView registerClass:[BankTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _bankTableView;
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
