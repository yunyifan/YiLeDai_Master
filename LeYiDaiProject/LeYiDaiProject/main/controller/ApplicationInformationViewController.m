//
//  ApplicationInformationViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "ApplicationInformationViewController.h"
#import "FinishAuthenViewController.h"

#import "ApplyInfoTableViewCell.h"

@interface ApplicationInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *applyTable;

@property (nonatomic,strong)NSArray *leftArray;

@property (nonatomic,strong)NSArray *placehodelArray;

@property (nonatomic,strong)FSCustomButton *nextBut;


@end

@implementation ApplicationInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"额度评估-申请资料";
    self.leftArray = @[@[@"*最高学历",@"*婚姻状况",@"*住宅地址",@"*紧急联系人1",@"*紧急联系人1"],@[@"单位名称",@"单位地址",@"从事职业",@"职务级别",@"月收入"]] ;
    self.placehodelArray = @[@[@"本科",@"未婚",@"江苏省 南京市 玄武区",@"通讯录添加",@"通讯录添加"],@[@"南京XXX科技公司",@"江苏省 南京市 玄武区",@"请选择",@"普通员工",@"请选择"]];
    
    [self.view addSubview:self.applyTable];
    [self.applyTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.applyTable.tableFooterView = [self footerView];
    
}
-(void)nextButtonClick{
    FinishAuthenViewController *finishVc = [[FinishAuthenViewController alloc] init];
    [self.navigationController pushViewController:finishVc animated:YES];
}
-(UIView *)footerView{
    
    UIView *footView = [[UIView alloc] init];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    
    [footView addSubview:self.nextBut];
    [self.nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footView);
        make.centerX.equalTo(footView);
        make.width.mas_equalTo(SCREEN_WIDTH-27*2);
        make.height.mas_equalTo(45);
        
    }];
    
    
    return footView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40.f;
    }else{
        return 8.f;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"基本信息";
    }else{
        return @"";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ApplyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ApplyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    cell.leftLab.text = self.leftArray[indexPath.section][indexPath.row];
    cell.textFiled.placeholder = self.placehodelArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            cell.bottomTextFiled.placeholder = @"详细地址填写";
            cell.bottomTextFiled.hidden = NO;
            cell.botttomTextIsHide = NO;
        }else{
            cell.bottomTextFiled.hidden = YES;
            cell.botttomTextIsHide = YES;
        }
    }else{
        if (indexPath.row == 1) {
            cell.bottomTextFiled.placeholder = @"详细地址如: 道路、门牌号、小区、楼栋号";
            cell.bottomTextFiled.hidden = NO;
            cell.botttomTextIsHide = NO;
        }else{
            cell.bottomTextFiled.hidden = YES;
            cell.botttomTextIsHide = YES;

        }
    }
    cell.textBack = ^(NSString * _Nonnull textStr) {
        [MBProgressHUD showError:textStr];
    };
    
    
    return cell;
}
-(UITableView *)applyTable{
    if (!_applyTable) {
        _applyTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _applyTable.estimatedRowHeight = 50;
        _applyTable.rowHeight = UITableViewAutomaticDimension;
        _applyTable.sectionFooterHeight = 0.1;

        _applyTable.dataSource = self;
        _applyTable.delegate = self;
    }
    return _applyTable;
}

-(FSCustomButton *)nextBut{
    if (!_nextBut) {
        _nextBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        _nextBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];
       [_nextBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       _nextBut.layer.shadowOffset = CGSizeMake(0, 2);
       _nextBut.layer.shadowOpacity = 1;
       _nextBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
       _nextBut.layer.shadowRadius = 9;
        _nextBut.enabled = NO;
        _nextBut.titleLabel.font = BOLDFONT(18);
        [_nextBut setTitle:@"提交审核" forState:UIControlStateNormal];
        [_nextBut addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
