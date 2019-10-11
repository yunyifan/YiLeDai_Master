//
//  EvaluationViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/15.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "EvaluationViewController.h"
#import "AuthenticationViewController.h"
#import "BankAuthenViewController.h"
#import "FaceAuthenViewController.h"
#import "OperatorViewController.h"
#import "ApplicationInformationViewController.h"

#import "CustAuthresultMedel.h"
@interface EvaluationViewController ()

@property (nonatomic,strong)UIView *evaluaView;

@property (nonatomic,strong)UIButton *renZhengBut;

@property (nonatomic,strong)FSCustomButton *bottomBut; // 底部button

@property (nonatomic,strong)NSMutableArray *listArray;

@property (nonatomic,assign)int authState; // 0 未认证 1 身份认证通过 2 人脸识别通过 3身份证认证通过 4 基本资料填写 5 银行卡认证

@end

@implementation EvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"额度评估";
    self.listArray = [NSMutableArray array];
    
    [self CustAuthGetCustAuth];
}
-(void)creatDetialUI{
    
    [self.view addSubview:self.evaluaView];
    [self.evaluaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(290);
    }];
    
    UILabel *lastLab;
    for (int i = 0; i<self.listArray.count; i++) {
        
        CustAuthresultMedel *custModel = self.listArray[i];
        if(custModel.authState == 1){
            
            self.authState++;
        }
        UILabel *lable = [[UILabel alloc] init];
        lable.font = FONT(15);
        lable.textColor = Tit_Black_Color;
        lable.backgroundColor = [UIColor whiteColor];
        lable.text = [NSString stringWithFormat:@"     %@",custModel.authContent];
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
        rightlab.text   = custModel.authState_dictText;
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
        make.height.mas_equalTo(45);
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
    
    AuthenticationViewController *authenVc = [[AuthenticationViewController alloc] init];
    [self.navigationController pushViewController:authenVc animated:YES];
    
    return;
    
    for (int i = 0; i<self.listArray.count; i++) {
        CustAuthresultMedel *model = self.listArray[i];
        if (model.authState == 0 || model.authState == 9) {
            
            if ([model.authType isEqualToString:@"auth-tele"]) {
                // 运营商认证
                [self creatOperInsert];
                
//                OperatorViewController *operaVc = [[OperatorViewController alloc] init];
//                [self.navigationController pushViewController:operaVc animated:YES];
            }else if ([model.authType isEqualToString:@"auth-face"]){
                //人脸识别认证
                FaceAuthenViewController *authenVc = [[FaceAuthenViewController alloc] init];
                [self.navigationController pushViewController:authenVc animated:YES];
                
            }else if ([model.authType isEqualToString:@"auth-cert"]){
                //身份认证
                AuthenticationViewController *authenVc = [[AuthenticationViewController alloc] init];
                [self.navigationController pushViewController:authenVc animated:YES];
                
            }else if ([model.authType isEqualToString:@"auth-zx"]){
                //基本资料填写
                ApplicationInformationViewController *appVc = [[ApplicationInformationViewController alloc] init];
                [self.navigationController pushViewController:appVc animated:YES];
                
            }else if ([model.authType isEqualToString:@"auth-card"]){
                // 银行卡认证
                BankAuthenViewController *bankAhthenVc = [[BankAuthenViewController alloc] init];
                [self.navigationController pushViewController:bankAhthenVc animated:YES];
            }
            
            return;
        }
    }
    
}
-(void)creatOperInsert{
    NSDictionary *dic = @{@"type":@"ios",@"userId":self.loginModel.userId};
    [[RequestAPI shareInstance] useCustAuthOperatorInsert:dic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        if (succeed) {
            if ([result[@"success"] intValue] == 1) {
                
            }else{
                
//                [MBProgressHUD showError:result[@"message"]];

            }

        }
    }];

}
/**
 查询认证列表
 
 */
-(void)CustAuthGetCustAuth{
    
    @weakify(self);
    [[RequestAPI shareInstance] useCustAuthGetCustAuth:@{@"userId":self.loginModel.userId} Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self);
        if (succeed) {
            if ([result[@"success"] intValue] == 1) {
                NSArray *Array = result[@"result"][@"custAuthresult"];
                [self.listArray removeAllObjects];
                for (NSDictionary *dic in Array) {
                    CustAuthresultMedel *model = [CustAuthresultMedel yy_modelWithDictionary:dic];
                    
                    [self.listArray addObject:model];
                }
                
                [self creatDetialUI];

               
            }else{
                
                [MBProgressHUD showError:result[@"message"]];

            }
        }
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
        _renZhengBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];
        [_renZhengBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _renZhengBut.layer.shadowOffset = CGSizeMake(0, 2);
        _renZhengBut.layer.shadowOpacity = 1;
        _renZhengBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
        _renZhengBut.layer.shadowRadius = 9;
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
