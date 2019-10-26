//
//  MainViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/6.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "MainViewController.h"
#import "RepaymentViewController.h"
#import "EvaluationViewController.h"
#import "LoanViewController.h"


#import "MianTopBlueView.h"
#import "MainCenterView.h"
#import "MainAccationView.h"

#import "MainDetianModel.h"

@interface MainViewController ()

@property (nonatomic,strong)UIImageView *topBgImg;
@property (nonatomic,strong)UIView *whiteNavBg;
@property (nonatomic,strong)UILabel *navTitLab;

@property (nonatomic,strong)MianTopBlueView *blueBgView;

@property (nonatomic,strong)MainCenterView *whiteBgView;

@property (nonatomic,strong)FSCustomButton *bottomBut; // 底部button

@property (nonatomic,strong)MainAccationView *accationView; // 逾期警告

@property (nonatomic,strong)MainDetianModel *detialModel;
@end

@implementation MainViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.translucent = NO;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.translucent = YES;
    
    [self useMainInsert];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self creatMianUI];
    
}
-(void)creatInitNoAuthonUI{
        //  没有借过
    [self.view addSubview:self.topBgImg];
    [self.topBgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);

    }];

//    self.whiteBgView.creaditInfoModel = self.detialModel;
    [self.view addSubview:self.whiteBgView];
    [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.topBgImg.mas_bottom).offset(-20);
    }];
}
-(void)creatMianUI{
    
    
    [self.view addSubview:self.whiteNavBg];
    [self.whiteNavBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(Height_NavBar);
    }];
    
    [self.whiteNavBg addSubview:self.navTitLab];
    [self.navTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(15);
    }];
    
    if(self.detialModel.loanRepayDue.overFlag == 1){
        // 未逾期
    }else{
        [self.view addSubview:self.accationView];
        [self.accationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.whiteNavBg.mas_bottom);
            make.height.mas_equalTo(30);
        }];

    }
    
    [self.blueBgView setBlueViewData:self.detialModel];
    [self.view addSubview:self.blueBgView];
    [self.blueBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(self.detialModel.loanRepayDue.overFlag == 1){
            // 未逾期
            make.top.mas_equalTo(Height_NavBar+9);

        }else{
            make.top.equalTo(self.accationView.mas_bottom).offset(Height_NavBar+39);


        }

        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(110);
    }];
    
    [self.view addSubview:self.whiteBgView];
    [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.blueBgView);
        make.top.equalTo(self.blueBgView.mas_bottom).offset(11);
    }];
     
     
    
    [self.view addSubview:self.bottomBut];
    [self.bottomBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(-18);
    }];
}

/**
 去还款
 */
-(void)payButtonClick{
    
    
    RepaymentViewController *repVc = [[RepaymentViewController alloc] init];
    repVc.overFlag = self.detialModel.loanRepayDue.overFlag;
    [self.navigationController pushViewController:repVc animated:YES];
}
-(void)whiteBgViewButtonClick{
    
    if (self.detialModel.userState == 1 || self.detialModel.userState == 2) {
//        未认证
       EvaluationViewController *evaluaVc = [[EvaluationViewController alloc] init];
       [self.navigationController pushViewController:evaluaVc animated:YES];
    }else if (self.detialModel.userState == 4){
        if ([self.detialModel.creditInfo.creditAppstate intValue] == 1) {
            
            LoanViewController *loanVc = [[LoanViewController alloc] init];
            loanVc.creditLeftamtStr = self.detialModel.creditInfo.creditLimit;
            [self.navigationController pushViewController:loanVc animated:YES];
        }
    }
    
}

/// 首页接口
-(void)useMainInsert{
    
    @weakify(self);
    [[RequestAPI shareInstance] useMainInsert:@{@"userId":EMPTY_IF_NIL(self.loginModel.userId)} Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self);
        if (succeed) {
            if ([result[@"success"] intValue] == 1) {
                self.detialModel = [MainDetianModel yy_modelWithDictionary:result[@"result"]];
                if (self.detialModel.userState == 1 || self.detialModel.userState == 2 || self.detialModel.userState == 3 ||self.detialModel.userState == 4 || self.detialModel.userState == 5) {
                    [self creatInitNoAuthonUI];
                }else if(self.detialModel.userState == 6){
                    
                    if (self.topBgImg) {
                        [self.topBgImg removeFromSuperview];
                    }
                    if(self.whiteBgView){
                        [self.whiteBgView removeFromSuperview];
                    }
                   
                    [self creatMianUI];
                    
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Main_data" object:self.detialModel];
            }else{
                
                
                [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];
            }
        }
    }];
}
-(UIImageView *)topBgImg{
    if (!_topBgImg) {
        _topBgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_top_blue"]];
    }
    return _topBgImg;
}
-(UIView *)whiteNavBg{
    if (!_whiteNavBg) {
        _whiteNavBg = [[UIView alloc] init];
        _whiteNavBg.backgroundColor = [UIColor whiteColor];
    }
    return _whiteNavBg;
}
-(UILabel *)navTitLab{
    if (!_navTitLab) {
        _navTitLab = [[UILabel alloc] init];
        _navTitLab.font = BOLDFONT(18);
        _navTitLab.text = @"借款中...";
        _navTitLab.textColor = Tit_Black_Color;
    }
    return _navTitLab;
}
-(MianTopBlueView *)blueBgView{
    if (!_blueBgView) {
        _blueBgView = [[MianTopBlueView alloc] init];
        [_blueBgView.payBut addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _blueBgView;
}
-(MainCenterView *)whiteBgView{
    if (!_whiteBgView) {
        _whiteBgView = [[MainCenterView alloc] initWithMainType:self.detialModel];
        _whiteBgView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _whiteBgView.layer.cornerRadius = 4;
        [_whiteBgView.statueBut addTarget:self action:@selector(whiteBgViewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _whiteBgView;
}
-(MainAccationView *)accationView{
    if (!_accationView) {
        _accationView = [[MainAccationView alloc] initWithFrame:CGRectZero];
        _accationView.titleLab.text= @"请按照借款条约及时还款，逾期还款将会影响";
    };
    return _accationView;
}
-(FSCustomButton *)bottomBut{
    if (!_bottomBut) {
        _bottomBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        _bottomBut.buttonImagePosition = FSCustomButtonImagePositionLeft;
        _bottomBut.titleLabel.font = FONT(11);
        [_bottomBut setTitleColor:[UIColor colorWithHex:@"#666666"] forState:UIControlStateNormal];
        [_bottomBut setTitle:@"本平台拒绝向学生提供服务" forState:UIControlStateNormal];
        [_bottomBut setImage:[UIImage imageNamed:@"icon_slices"] forState:UIControlStateNormal];
        _bottomBut.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    }
    return _bottomBut;
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
