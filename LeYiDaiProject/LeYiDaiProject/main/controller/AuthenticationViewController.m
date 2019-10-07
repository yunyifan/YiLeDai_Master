//
//  AuthenticationViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/9/15.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "AuthenDetialViewController.h"
#import "TZImagePickerController.h"

#import "MainAccationView.h"
@interface AuthenticationViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)MainAccationView *accationView;

@property (nonatomic,strong)UIView *centerView;

@property (nonatomic,strong)FSCustomButton *nextBut;

@property (nonatomic,assign)NSInteger selectInteger; // 选择正反面

@property (nonatomic,strong)NSData *topData; // 正面
@property (nonatomic,strong)NSData *fanData; // 反面

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"额度评估-身份认证";
    
    [self initDetialUI];
}
-(void)initDetialUI{
    [self.view addSubview:self.accationView];
    [self.accationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.accationView.mas_bottom);
    }];
    
    NSArray *arr = @[@"authon_zheng",@"authon_fan"];
    UIImageView *lastImg;
    for (int i = 0; i<arr.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:arr[i]]];
        img.tag = i+1;
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [img addGestureRecognizer:tap];
        [self.centerView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastImg) {
                make.top.equalTo(lastImg.mas_bottom).offset(84);
                make.bottom.mas_equalTo(-57);
            }else{
                make.top.equalTo(self.accationView.mas_bottom).offset(30);
            }
            make.left.mas_equalTo(110);
            make.right.mas_equalTo(-100);
            make.height.equalTo(img.mas_width).multipliedBy(0.7);
        }];
       
        
        UILabel *titLab = [[UILabel alloc] init];
        titLab.font = FONT(12);
        if (i == 0) {
            titLab.text = @"点击开始识别正面  照片面";

        }else{
            titLab.text = @"点击开始识别背面  国徽面";

        }
        titLab.textColor = [UIColor colorWithHex:@"#666666"];
        [self.centerView addSubview:titLab];
        [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(img.mas_bottom).offset(19);
            make.centerX.equalTo(self.view);
        }];
        
        if (i == 0) {
            UILabel *lineLab = [[UILabel alloc] init];
            lineLab.backgroundColor = [UIColor colorWithHex:@"#EBEBEB"];
            [self.centerView addSubview:lineLab];
            [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titLab.mas_bottom).offset(25);
                make.left.equalTo(self.view);
                make.right.mas_equalTo(-15);
                make.height.mas_equalTo(1);
            }];
        }
        lastImg = img;
    }
    
    [self.view addSubview:self.nextBut];
    [self.nextBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.centerView.mas_bottom).offset(49);
        make.left.mas_equalTo(27);
        make.right.mas_equalTo(-27);
        make.height.mas_equalTo(45);
    }];

    
}
-(void)tapClick:(UIGestureRecognizer *)reconizer{
    self.selectInteger = reconizer.view.tag;
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
         // 添加相机提示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置＞隐私＞相机“选项中，允许壹升升访问您的相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *picAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sureActino = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
            
        }];
        
        [alert addAction:picAction];
        
        [alert addAction:sureActino];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            //从摄像头获取图片
            // 创建UIImagePickerController实例
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            // 设置代理
            imagePickerController.delegate = self;
            // 是否显示裁剪框编辑（默认为NO），等于YES的时候，照片拍摄完成可以进行裁剪
            imagePickerController.allowsEditing = NO;
            // 设置照片来源为相机
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            // 展示选取照片控制器
            imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;

            [self presentViewController:imagePickerController animated:YES completion:nil];
        }

    }


}
#pragma mark --------UIImagePickerControllerDelegate-------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageView *zhengImage = (UIImageView *)[self.centerView viewWithTag:self.selectInteger];
    zhengImage.image = image;
    NSData *imgData  = UIImageJPEGRepresentation(image, 1);
    
    
    if(self.selectInteger == 1){
        self.topData = imgData;
    }else{
        self.fanData = imgData;
    }

    if(self.topData == nil || self.fanData == nil){
        self.nextBut.enabled = NO;
    }else{
        self.nextBut.enabled = YES;
    }
    
        // 创建保存图像时需要传入的选择器对象（回调方法格式固定）
    //    SEL selectorToCall = @selector(image:didFinishSavingWithError:contextInfo:);
    //    // 将图像保存到相册（第三个参数需要传入上面格式的选择器对象）
    //    UIImageWriteToSavedPhotosAlbum(image, self, selectorToCall, NULL);
}
// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)nextButtonClick{
    
//    AuthenDetialViewController *detialVc = [[AuthenDetialViewController alloc] init];
//    [self.navigationController pushViewController:detialVc animated:YES];
    
    [self useCusAuthInsert];
}

/// 身份证信息认证
-(void)useCusAuthInsert{
    
    
    NSDictionary *dic = @{@"idCardImgPositive":@"http://pic26.nipic.com/20121221/9252150_142515375000_2.jpg",@"idCardImgNegative":@"http://pic16.nipic.com/20111006/6239936_092702973000_2.jpg",@"userId":EMPTY_IF_NIL(self.loginModel.userId),@"appId":APPID};
    
    [[RequestAPI shareInstance] useCusAuthInsert:dic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        
    }];
}
-(MainAccationView *)accationView{
    if (!_accationView) {
        _accationView = [[MainAccationView alloc] initWithFrame:CGRectZero];
        _accationView.titleLab.text= @"拍摄时请确保身份证边框完整、字迹清晰、亮";
    };
    return _accationView;
}
-(UIView *)centerView{
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
    }
    return _centerView;
}
-(FSCustomButton *)nextBut{
    if (!_nextBut) {
        _nextBut = [FSCustomButton buttonWithType:UIButtonTypeCustom];
        _nextBut.titleLabel.font = BOLDFONT(18);
        _nextBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];
        [_nextBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBut setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBut addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBut.layer.shadowOffset = CGSizeMake(0, 2);
       _nextBut.layer.shadowOpacity = 1;
       _nextBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
       _nextBut.layer.shadowRadius = 9;
       _nextBut.enabled = NO;
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
