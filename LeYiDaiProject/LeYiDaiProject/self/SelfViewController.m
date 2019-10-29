//
//  SelfViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/6.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "SelfViewController.h"
#import "SettingViewController.h"
#import "MyBankViewController.h"
#import "FeedBackViewController.h"
#import "SelfTableViewCell.h"

#import "MainDetianModel.h"
@interface SelfViewController ()<UITableViewDelegate,UITableViewDataSource>

// 头部UI
@property (nonatomic,strong)UIImageView *topView;
@property (nonatomic,strong)UILabel *nameLab; //
@property (nonatomic,strong)UILabel *descLab;

// 认证
@property (nonatomic,strong)UIView *certifiView;
@property (nonatomic,strong)UIImageView *cerImage;
@property (nonatomic,strong)UILabel *cerLab;
@property (nonatomic,strong)UILabel *statueLab; // 认证状态
@property (nonatomic,strong)UIImageView *arrowImage;

// table数据
@property (nonatomic,strong)UIView *centerView;
@property (nonatomic,strong)UITableView *selfTable;

@property (nonatomic,strong)NSArray *imageArr;
@property (nonatomic,strong)NSArray *titArr;
@end

@implementation SelfViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];

    self.navigationController.navigationBar.translucent = NO;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.imageArr = @[@"self_bank",@"self_sever",@"self_feedback",@"self_setting"];
    self.titArr = @[@"我的银行卡",@"客服电话",@"意见反馈",@"设置"];
    [self creatTopView];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfNotificationCLick:) name:@"Main_data" object:nil];
    

    
}
-(void)selfNotificationCLick:(NSNotification *)info{
    
    MainDetianModel *detialModel = info.object;
    
    if (detialModel.userState >3) {
        self.statueLab.text = @"已认证";
    }else{
        self.statueLab.text = @"未认证";

    }
}
-(void)creatTopView{
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(170);
    }];
    
    if(STRING_ISNIL(self.loginModel.userName)){
        self.nameLab.text = [NSString stringWithFormat:@"%@",self.loginModel.account];
    }else{
        self.nameLab.text = [NSString stringWithFormat:@"%@",self.loginModel.userName];

    }
    [self.topView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_equalTo(20);
    }];
        
    [self.topView addSubview:self.descLab];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(6);
        make.left.equalTo(self.nameLab);
    }];
    
    [self.view addSubview:self.certifiView];
    [self.certifiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topView).offset(30);
        make.left.mas_equalTo(13);
        make.right.mas_equalTo(-13);
        make.height.mas_equalTo(60);
    }];
    
    [self.certifiView addSubview:self.cerImage];
    [self.cerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.certifiView);
        make.left.mas_equalTo(12);
    }];
    
    [self.certifiView addSubview:self.cerLab];
    [self.cerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.certifiView);
        make.left.equalTo(self.cerImage.mas_right).offset(10);
    }];
    
    [self.certifiView addSubview:self.statueLab];
    [self.statueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.certifiView);
        make.right.mas_equalTo(-32);
    }];
    
    [self.certifiView addSubview:self.arrowImage];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.certifiView);
        make.right.mas_equalTo(-15);
    }];
    
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.certifiView.mas_bottom).offset(10);
        make.left.mas_equalTo(13);
        make.right.mas_equalTo(-13);
        make.height.mas_equalTo(280);
    }];
    
    [self.centerView addSubview:self.selfTable];
    [self.selfTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        make.right.left.equalTo(self.centerView);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[SelfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.leftImg.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    cell.titLab.text = self.titArr[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            MyBankViewController *bankVc = [[MyBankViewController alloc] init];
            [self.navigationController pushViewController:bankVc animated:YES];
        }
            break;
        case 1:
        {
            if (STRING_ISNIL(self.loginModel.servicetele)) {
                   return;
               }
               NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.loginModel.servicetele];
               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 2:
        {
            FeedBackViewController *feedVc = [[FeedBackViewController alloc] init];
            [self.navigationController pushViewController:feedVc animated:YES];
        }
            break;
        case 3:
        {
            SettingViewController *setvc = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:setvc animated:YES];
        }
            break;
        default:
            break;
    }
}
-(UIImageView *)topView{
    if (!_topView) {
        _topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"self_bg"]];
    }
    return _topView;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = BOLDFONT(20);
        _nameLab.textColor = [UIColor whiteColor];
    }
    return _nameLab;
}
-(UILabel *)descLab{
    if (!_descLab) {
        _descLab = [[UILabel alloc] init];
        _descLab.font = FONT(13);
        _descLab.textColor = [UIColor whiteColor];
        _descLab.text = @"诚信赢天下";
    }
    return _descLab;
}
-(UIView *)certifiView{
    if (!_certifiView) {
        _certifiView = [[UIView alloc] init];
        _certifiView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _certifiView.layer.cornerRadius = 4;
    }
    return _certifiView;
}
-(UIImageView *)cerImage{
    if (!_cerImage) {
        _cerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"self_certifi"]];
    }
    return _cerImage;
}
-(UILabel *)cerLab{
    if (!_cerLab) {
        _cerLab = [[UILabel alloc] init];
        _cerLab.font = FONT(15);
        _cerLab.textColor = [UIColor colorWithHex:@"#333333"];
        _cerLab.text = @"认证中心";
    }
    return _cerLab;
}
-(UILabel *)statueLab{
    if (!_statueLab) {
        _statueLab = [[UILabel alloc] init];
        _statueLab.font = FONT(13);
        _statueLab.textColor = [UIColor colorWithHex:@"#FF52A5"];
    }
    return _statueLab;
}
-(UIImageView *)arrowImage{
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
    }
    return _arrowImage;
}
-(UIView *)centerView{
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _centerView.layer.cornerRadius = 4;
    }
    return _centerView;
}
-(UITableView *)selfTable{
    if (!_selfTable) {
        _selfTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _selfTable.rowHeight = 60;
        _selfTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _selfTable.scrollEnabled = NO;
        _selfTable.dataSource = self;
        _selfTable.delegate = self;
        [_selfTable registerClass:[SelfTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _selfTable;
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
