//
//  LoanOningViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/17.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "LoanOningViewController.h"

@interface LoanOningViewController ()

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIImageView *topImg;
@property (nonatomic,strong)UILabel *topLab;
@property (nonatomic,strong)UILabel *moneyLab;

@property (nonatomic,strong)UIView *bottomView;
@end

@implementation LoanOningViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setShadowImage:[LYDUtil imageWithColor:[UIColor colorWithHex:@"#EEEEEE"]]];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"放款中";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = FONT(15);
    [rightBtn setTitleColor:[UIColor colorWithHex:@"#4D56EF"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClip) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;

    [self creatDetailUI];
}
-(void)creatDetailUI{
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(263);
    }];
    
    self.topImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loan_oning"]];
    [self.topView addSubview:self.topImg];
    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.top.mas_equalTo(54);
    }];
    
    self.topLab = [[UILabel alloc] init];
    self.topLab.font = FONT(16);
    self.topLab.textColor = Tit_Black_Color;
    self.topLab.text = @"放款中";
    [self.topView addSubview:self.topLab];
    [self.topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topImg);
        make.top.equalTo(self.topImg.mas_bottom).offset(13);
    }];
    
    self.moneyLab = [[UILabel alloc] init];
    self.moneyLab.font = BOLDFONT(30);
    self.moneyLab.textColor = Tit_Black_Color;
    NSAttributedString *string = [LYDUtil LableTextShowInBottom:@"1000元" InsertWithString:@"元" InsertSecondStr:@"" InsertStringColor:Tit_Black_Color WithInsertStringFont:FONT(16)];
    [self.moneyLab setAttributedText:string];
    [self.topView addSubview:self.moneyLab];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topImg);
        make.top.equalTo(self.topLab.mas_bottom);
    }];

    self.bottomView = [[UIView alloc] init];
    self.bottomView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.bottomView.layer.cornerRadius = 4;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(9);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(102);
    }];
    
    NSArray *leftArr = @[@"收款账户",@"预计到账时间"];
    UILabel *lastLab;
    for (int i = 0; i<2; i++) {
        UILabel *leftLab = [[UILabel alloc] init];
        leftLab.font = FONT(14);
        leftLab.text = leftArr[i];
        leftLab.textColor = Tit_Black_Color;
        [self.bottomView addSubview:leftLab];
        [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastLab) {
                make.top.equalTo(lastLab.mas_bottom).offset(17);
            }else{
                make.top.mas_equalTo(26);
            }
            make.left.mas_equalTo(13);
        }];
        
        UILabel *rightLab = [[UILabel alloc] init];
        rightLab.font = FONT(14);
        rightLab.textAlignment = NSTextAlignmentRight;
        rightLab.textColor = Tit_Gray_Color;
        [self.bottomView addSubview:rightLab];
        [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftLab);
            make.right.mas_equalTo(-16);
            
        }];
        
        if (i == 0) {
            rightLab.text = @"招商银行 8898";
            
            UIImageView *bottomImg = [[UIImageView alloc] init];
            bottomImg.backgroundColor = [UIColor redColor];
            bottomImg.layer.cornerRadius = 10;
            bottomImg.clipsToBounds = YES;
            [self.bottomView addSubview:bottomImg];
            [bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(leftLab);
                make.right.equalTo(rightLab.mas_left).offset(-9);
                make.width.height.mas_equalTo(20);
            }];
            
            
        }else{
            rightLab.text = @"预计等待1~2小时";
        }
        
        lastLab = leftLab;
    }
    
    
}
-(void)rightBtnClip{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
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
