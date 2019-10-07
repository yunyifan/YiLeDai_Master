//
//  RecordViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/6.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "RecordViewController.h"
#import "LoanDetialViewController.h"
#import "RepaymentDetialViewController.h"



#import "RecordTableViewCell.h"
@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UISegmentedControl *segControl;

@property (nonatomic,assign)NSInteger selectSegIndexd;

@property (nonatomic,strong)UITableView *resordTable;
@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"记录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatLabUI];
}
-(void)creatLabUI{
   
    [self.view addSubview:self.segControl];
    [self.segControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(17);
    }];
     
    [self.view addSubview:self.resordTable];
    [self.resordTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segControl.mas_bottom).offset(10);
        make.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
}
-(void)segControlClick:(UISegmentedControl *)sender{
    
    self.selectSegIndexd = sender.selectedSegmentIndex;
    if (sender.selectedSegmentIndex == 0) {
        // 借款记录
        NSLog(@"借款记录");
    }else{
        // 还款记录
        NSLog(@"还款记录");
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecordTableViewCell *recordCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!recordCell) {
        recordCell = [[RecordTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    [recordCell setUIData];
    
    return recordCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectSegIndexd == 0) {
        LoanDetialViewController *loanDeVc = [[LoanDetialViewController alloc] init];
        [self.navigationController pushViewController:loanDeVc animated:YES];
    }else{
        RepaymentDetialViewController *repayDeVc = [[RepaymentDetialViewController alloc] init];
        [self.navigationController pushViewController:repayDeVc animated:YES];
    }

}
-(UISegmentedControl *)segControl{
    if (!_segControl) {
        _segControl = [[UISegmentedControl alloc] initWithItems:@[@"借款记录",@"还款记录"]];
        _segControl.selectedSegmentIndex = 0;
        _segControl.tintColor = But_Bg_Color;
        [_segControl addTarget:self action:@selector(segControlClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segControl;
}
-(UITableView *)resordTable{
    if (!_resordTable) {
        _resordTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _resordTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _resordTable.rowHeight = 66;
        _resordTable.delegate  = self;
        _resordTable.dataSource = self;
        [_resordTable registerClass:[RecordTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _resordTable;
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
