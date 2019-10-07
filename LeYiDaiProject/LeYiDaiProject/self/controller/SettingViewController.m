//
//  SettingViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/7.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@property (nonatomic,strong)UIView *setView;
@property (nonatomic,strong)UIButton *loginOut; // 退出

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"设置";
    
    [self creatSetUI];
}
-(void)creatSetUI{
    
    [self.view addSubview:self.setView];
    [self.setView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(162);
    }];
    
    [self.view addSubview:self.loginOut];
    [self.loginOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.setView.mas_bottom).offset(46);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(45);
    }];
    
    UIView *lastView;
    for (int i = 0; i<3; i++) {
        
        UIView *cellBgView = [[UIView alloc] init];
        cellBgView.backgroundColor = [UIColor whiteColor];
        [self.setView addSubview:cellBgView];
        [cellBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.setView);
            make.height.mas_equalTo(53);
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom).offset(7);
            }else{
                make.top.equalTo(self.setView);
            }
        }];
        
        UILabel *titlab = [[UILabel alloc] init];
        titlab.font = FONT(15);
        titlab.textColor = Tit_Black_Color;
        titlab.text = @"清除缓存";
        [cellBgView addSubview:titlab];
        [titlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cellBgView);
            make.left.mas_equalTo(20);
        }];
        if (i == 0) {
            UILabel *desLab = [[UILabel alloc] init];
            desLab.text = @"90M";
            desLab.font = FONT(15);
            desLab.textColor = Tit_Black_Color;
            [cellBgView addSubview:desLab];
            [desLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-15);
                make.centerY.equalTo(cellBgView);
            }];
        }else{
            UIImageView *arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
            [cellBgView addSubview:arrowImg];
            [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cellBgView);
                make.right.mas_equalTo(-15);
            }];
        }
        
        
        
        
        lastView = cellBgView;
    }
}
-(UIView *)setView{
    if (!_setView) {
        _setView = [[UIView alloc] init];
        _setView.backgroundColor = [UIColor colorWithHex:@"#FBFBFB"];
    }
    return _setView;
}
-(UIButton *)loginOut{
    if (!_loginOut) {
        _loginOut = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginOut.backgroundColor = But_Bg_Color;
        _loginOut.titleLabel.font = BOLDFONT(18);
        [_loginOut setTitle:@"退出" forState:UIControlStateNormal];
    }
    return _loginOut;
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
