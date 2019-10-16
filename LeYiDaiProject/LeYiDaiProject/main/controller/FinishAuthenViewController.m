//
//  FinishAuthenViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/16.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "FinishAuthenViewController.h"

@interface FinishAuthenViewController ()

@property (nonatomic,strong)UIImageView *finishImg;

@property (nonatomic,strong)UILabel *centerLab;

@property (nonatomic,strong)UILabel *detialLab;

@property (nonatomic,strong)UIView *lineView;

@end

@implementation FinishAuthenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = FONT(15);
    [rightBtn setTitleColor:[UIColor colorWithHex:@"#4D56EF"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClip) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.mas_equalTo(1);
    }];

    
    [self.view addSubview:self.finishImg];
    [self.finishImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.centerLab];
    [self.centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.finishImg.mas_bottom).offset(31);
        
    }];
    
    [self.view addSubview:self.detialLab];
    [self.detialLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.centerLab.mas_bottom).offset(10);
    }];
}
-(void)rightBtnClip{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHex:@"#EEEEEE"];
    }
    return _lineView;
}

-(UIImageView *)finishImg{
    if (!_finishImg) {
        _finishImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"finish_bg"]];
    }
    return _finishImg;
}
-(UILabel *)centerLab{
    if (!_centerLab) {
        _centerLab = [[UILabel alloc] init];
        _centerLab.text = @"提交成功";
        _centerLab.font = FONT(16);
        _centerLab.textColor = Tit_Black_Color;
    }
    return _centerLab;
}
-(UILabel *)detialLab{
    if (!_detialLab) {
        _detialLab = [[UILabel alloc] init];
        _detialLab.text = @"请耐心等待！我们将在30分钟内为您完成额度评估。";
        _detialLab.font = FONT(14);
        _detialLab.textColor = [UIColor colorWithHex:@"#666666"];
    }
    return _detialLab;
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
