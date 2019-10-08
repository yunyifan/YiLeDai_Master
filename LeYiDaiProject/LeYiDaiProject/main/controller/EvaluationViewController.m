//
//  EvaluationViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/15.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "EvaluationViewController.h"
#import "AuthenticationViewController.h"


#import "OperatorViewController.h"
@interface EvaluationViewController ()

@property (nonatomic,strong)UIView *evaluaView;

@property (nonatomic,strong)UIButton *renZhengBut;

@property (nonatomic,strong)FSCustomButton *bottomBut; // 底部button

@end

@implementation EvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"额度评估";
    
    [self creatDetialUI];
    
    [self CustAuthGetCustAuth];
}
-(void)creatDetialUI{
    
    NSArray *array = @[@"     身份认证",@"      人脸识别",@"      运营商认证",@"     银行卡认证",@"     基本资料填写"];
    [self.view addSubview:self.evaluaView];
    [self.evaluaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(290);
    }];
    
    UILabel *lastLab;
    for (int i = 0; i<array.count; i++) {
        UILabel *lable = [[UILabel alloc] init];
        lable.font = FONT(15);
        lable.textColor = Tit_Black_Color;
        lable.backgroundColor = [UIColor whiteColor];
        lable.text = array[i];
        [self.evaluaView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.evaluaView);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(50);
            if (lastLab) {
                make.top.equalTo(lastLab.mas_bottom).offset(10);
            }else{
                make.top.mas_equalTo(0);
            }
        }];
        
        UILabel *rightlab = [[UILabel alloc] init];
        rightlab.textColor = Tit_Red_Color;
//        rightlab.text   = @"已认证";
        rightlab.font = FONT(13);
        [self.evaluaView addSubview:rightlab];
        [rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lable);
            make.right.mas_equalTo(-20);
        }];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i+1;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.evaluaView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(lable);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(50);
        }];
        
        lastLab = lable;
    }
    
    [self.view addSubview:self.renZhengBut];
    [self.renZhengBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.evaluaView.mas_bottom).offset(62);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
    }];
    
    [self.view addSubview:self.bottomBut];
    [self.bottomBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(-18);
    }];

}
-(void)buttonClick:(UIButton *)but{
//    [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",but.tag]];
}
/**
 去认证
 */
-(void)renZhengButtonClick{
    
    OperatorViewController *operaVc = [[OperatorViewController alloc] init];
    [self.navigationController pushViewController:operaVc animated:YES];
//    AuthenticationViewController *authenVc = [[AuthenticationViewController alloc] init];
//    [self.navigationController pushViewController:authenVc animated:YES];
}
/**
 查询认证列表
 
 */
-(void)CustAuthGetCustAuth{
    
    [[RequestAPI shareInstance] useCustAuthGetCustAuth:@{@"userId":self.loginModel.userId} Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        
    }];
    
}
-(UIView *)evaluaView{
    if (!_evaluaView) {
        _evaluaView = [[UIView alloc] init];
        _evaluaView.backgroundColor = [UIColor colorWithHex:@"#FBFBFB"];
    }
    return _evaluaView;
}
-(UIButton *)renZhengBut{
    if (!_renZhengBut) {
        _renZhengBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_renZhengBut setBackgroundImage:[UIImage imageNamed:@"but_able"] forState:UIControlStateNormal];
        _renZhengBut.titleLabel.font = BOLDFONT(18);
        [_renZhengBut setTitle:@"开始认证" forState:UIControlStateNormal];
        [_renZhengBut addTarget:self action:@selector(renZhengButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _renZhengBut;
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
