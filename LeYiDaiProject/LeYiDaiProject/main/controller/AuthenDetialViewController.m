//
//  AuthenDetialViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/15.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "AuthenDetialViewController.h"
#import "FaceAuthenViewController.h"


#import "MainAccationView.h"

@interface AuthenDetialViewController ()
@property (nonatomic,strong)MainAccationView *accationView;
@property (nonatomic,strong)UIButton *nextBut;

@end

@implementation AuthenDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"额度评估-身份认证";
    
    [self creatAuthonUI];
}
-(void)nextButtonClick{
    FaceAuthenViewController *faceVc  = [[FaceAuthenViewController alloc] init];
    [self.navigationController pushViewController:faceVc animated:YES];
}
-(void)creatAuthonUI{
    [self.view addSubview:self.accationView];
    [self.accationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
//        make.height.mas_equalTo(30);
    }];
    
    UIView *lastBg;
    for (int i = 0; i<2; i++) {
        UIView *whiteBg = [[UIView alloc] init];
        whiteBg.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:whiteBg];
        [whiteBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(100);
            if (lastBg) {
                make.top.mas_equalTo(lastBg.mas_bottom);
            }else{
                make.top.mas_equalTo(30);
            }
        }];
        
        UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBut.backgroundColor = [UIColor blackColor];
        [leftBut setTitle:@"重拍" forState:UIControlStateNormal];
        [leftBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        leftBut.titleLabel.font = BOLDFONT(12);
        [whiteBg addSubview:leftBut];
        [leftBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(whiteBg);
            make.left.mas_equalTo(18);
            make.width.height.mas_equalTo(50);
        }];
        
        UILabel *nameLab = [[UILabel alloc] init];
        nameLab.font = FONT(14);
        nameLab.text = @"姓名";
        nameLab.textColor = Tit_Gray_Color;
        [whiteBg addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftBut.mas_right).offset(18);
            make.top.equalTo(leftBut);
        }];
        
        UILabel *numberLab = [[UILabel alloc] init];
        numberLab.font = FONT(14);
        numberLab.text = @"身份证号";
        numberLab.textColor = Tit_Gray_Color;
        [whiteBg addSubview:numberLab];
        [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftBut.mas_right).offset(18);
            make.bottom.equalTo(leftBut);
        }];
        
        UILabel *nameLabData = [[UILabel alloc] init];
        nameLabData.font = FONT(14);
        nameLabData.text = @"小明";
        nameLabData.textColor = Tit_Black_Color;
        [whiteBg addSubview:nameLabData];
        [nameLabData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numberLab.mas_right).offset(24);
            make.centerY.equalTo(nameLab);
        }];
        
        UILabel *numberLabData = [[UILabel alloc] init];
        numberLabData.font = FONT(14);
        numberLabData.text = @"393838398938938938";
        numberLabData.textColor = Tit_Black_Color;
        [whiteBg addSubview:numberLabData];
        [numberLabData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numberLab.mas_right).offset(24);
            make.centerY.equalTo(numberLab);
        }];
        
        
        if (i == 0) {
            UILabel *lineLab = [[UILabel alloc] init];
            lineLab.backgroundColor = [UIColor colorWithHex:@"#EBEBEB"];
            [whiteBg addSubview:lineLab];
            [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(whiteBg.mas_bottom).offset(-1);
                make.left.mas_equalTo(15);
                make.right.mas_equalTo(0);
                make.height.mas_equalTo(1);
            }];
        }
        
        
        
        
        lastBg = whiteBg;
        
    }
    
    [self.view addSubview:self.nextBut];
    [self.nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastBg.mas_bottom).offset(53);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
    }];
    
    
}
-(MainAccationView *)accationView{
    if (!_accationView) {
        _accationView = [[MainAccationView alloc] initWithFrame:CGRectZero];
        _accationView.titleLab.text= @"请核对自动识别结果，如有误请更正";
    };
    return _accationView;
}
-(UIButton *)nextBut{
    if (!_nextBut) {
        _nextBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBut setBackgroundImage:[UIImage imageNamed:@"but_able"] forState:UIControlStateNormal];
        _nextBut.titleLabel.font = BOLDFONT(18);
        [_nextBut setTitle:@"下一步" forState:UIControlStateNormal];
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
