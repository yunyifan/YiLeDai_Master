//
//  FaceAuthenViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/15.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "FaceAuthenViewController.h"
#import "OperatorViewController.h"
#import "DetectionViewController.h"

#import "LivenessViewController.h"
#import "LivingConfigModel.h"
#import "IDLFaceSDK/IDLFaceSDK.h"
#import "FaceParameterConfig.h"


#import "MainAccationView.h"

@interface FaceAuthenViewController ()

@property (nonatomic,strong)MainAccationView *accationView;

@property (nonatomic,strong)UIView *whiteBgView;
@property (nonatomic,strong)UIView *grayBgView;
@property (nonatomic,strong)UIButton *faceBut;
@property (nonatomic,strong)UILabel *desLab;

@property (nonatomic,strong)UIButton *nextBut;

@end

@implementation FaceAuthenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"额度评估-人脸识别";
    
    [self initUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationClick:) name:@"IDFACELIVE" object:nil];
}
-(void)notificationClick:(NSNotification *)info{
    UIImage *img = info.object;
    NSData *imgData  = UIImageJPEGRepresentation(img, 0.4);
    UIImage *faceImg = [UIImage imageWithData:imgData];
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        [self.faceBut setImage:faceImg forState:UIControlStateNormal];
        self.nextBut.enabled = YES;
        
    });

}
-(void)initUI{
    [self.view addSubview:self.accationView];
    [self.accationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
//        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.whiteBgView];
    [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(206);
    }];
    
    [self.whiteBgView addSubview:self.grayBgView];
    [self.grayBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.right.mas_equalTo(-26);
        make.top.mas_equalTo(12);
        make.height.mas_equalTo(112);
    }];
    
    [self.grayBgView addSubview:self.faceBut];
    [self.faceBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.grayBgView);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.whiteBgView addSubview:self.desLab];
    [self.desLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.whiteBgView);
        make.top.equalTo(self.grayBgView.mas_bottom).offset(23);
    }];
    
    [self.view addSubview:self.nextBut];
    [self.nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteBgView.mas_bottom).offset(70);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(45);
    }];

}

/**
 下一步
 */
-(void)nextButtonClick{
    
    OperatorViewController *operaVc = [[OperatorViewController alloc] init];
    [self.navigationController pushViewController:operaVc animated:YES];
}

/**
 人脸识别
 */
-(void)faceButClick{
//    [MBProgressHUD showError:@"人脸识别"];
    
   if ([[FaceSDKManager sharedInstance] canWork]) {
        NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
        [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    }
    LivenessViewController* lvc = [[LivenessViewController alloc] init];
    LivingConfigModel* model = [LivingConfigModel sharedInstance];
    [lvc livenesswithList:model.liveActionArray order:model.isByOrder numberOfLiveness:model.numOfLiveness];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:lvc];
    navi.navigationBarHidden = true;
    [self presentViewController:navi animated:YES completion:nil];
}
-(MainAccationView *)accationView{
    if (!_accationView) {
        _accationView = [[MainAccationView alloc] initWithFrame:CGRectZero];
        _accationView.titleLab.text= @"拍摄时请确保身份证边框完整、字迹清晰、亮";
    };
    return _accationView;
}
-(UIView *)whiteBgView{
    if (!_whiteBgView) {
        _whiteBgView = [[UIView alloc] init];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBgView;
}
-(UIView *)grayBgView{
    if (!_grayBgView) {
        _grayBgView = [[UIView alloc] init];
        _grayBgView.layer.backgroundColor = [UIColor colorWithHex:@"#F3F3F3"].CGColor;
        _grayBgView.layer.cornerRadius = 4;
    }
    return _grayBgView;
}
-(UIButton *)faceBut{
    if (!_faceBut) {
        _faceBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_faceBut setImage:[UIImage imageNamed:@"face_but"] forState:UIControlStateNormal];
        [_faceBut addTarget:self action:@selector(faceButClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceBut;
}
-(UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
        _desLab.font = FONT(12);
        _desLab.textColor = [UIColor colorWithHex:@"#666666"];
        _desLab.text = @"点击开始进行人脸识别";
    }
    return _desLab;
}
-(UIButton *)nextBut{
    if (!_nextBut) {
        _nextBut = [UIButton buttonWithType:UIButtonTypeCustom];
         _nextBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];
         [_nextBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         [_nextBut setTitle:@"下一步" forState:UIControlStateNormal];
         _nextBut.layer.shadowOffset = CGSizeMake(0, 2);
        _nextBut.layer.shadowOpacity = 1;
        _nextBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
        _nextBut.layer.shadowRadius = 9;
        _nextBut.enabled = NO;
        _nextBut.titleLabel.font = BOLDFONT(18);
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
