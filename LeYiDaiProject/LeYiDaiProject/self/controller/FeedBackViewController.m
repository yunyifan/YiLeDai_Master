//
//  FeedBackViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/24.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UITextView+Placeholder.h"
#import "YSSfbCollectionViewCell.h"
#import "SDPhotoBrowser.h"
#import "TZImagePickerController.h"

#define itemWidth 70

@interface FeedBackViewController ()<UITextViewDelegate,SDPhotoBrowserDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UILabel *titDesLab;

@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UILabel *allLienceLab;

@property (nonatomic,strong)UIView *centerView;
@property (nonatomic,strong)UILabel *centerTopLab;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)NSMutableArray *pubPicAssetArr;


@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *bottomLable;
@property (nonatomic,strong)UILabel *phoneLab;

@property (nonatomic,strong)NSMutableArray *srcStringArray;

@property (nonatomic,strong)UIButton *commitBut;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.srcStringArray = [NSMutableArray array];

    self.title = @"意见反馈";
    
    [self creatDetialUI];

}
-(void)creatDetialUI{
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(188);
    }];
    
    NSAttributedString *string = [LYDUtil LableTextShowInBottom:@"*请描述你遇到的问题" InsertWithString:@"*" InsertSecondStr:@"" InsertStringColor:[UIColor colorWithHex:@"#FF0E2E"] WithInsertStringFont:FONT(12)];
    [self.titDesLab setAttributedText:string];
    [self.topView addSubview:self.titDesLab];
    [self.titDesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(20);
    }];
    
    [self.topView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titDesLab.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
    }];
    
    [self.topView addSubview:self.allLienceLab];
    [self.allLienceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textView);
        make.bottom.mas_equalTo(-10);
    }];
    
    
    self.centerView = [[UIView alloc] init];
    self.centerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(113);
    }];
    
    self.centerTopLab = [[UILabel alloc] init];
    NSAttributedString *centerString = [LYDUtil LableTextShowInBottom:@"上传凭证（不超过三张）" InsertWithString:@"（不超过三张）" InsertSecondStr:@"" InsertStringColor:Tit_Gray_Color WithInsertStringFont:FONT(13)];
    self.centerTopLab.font = FONT(13);
    self.centerTopLab.textColor = Tit_Black_Color;
    [self.centerTopLab setAttributedText:centerString];
    [self.centerView addSubview:self.centerTopLab];
    [self.centerTopLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titDesLab);
        make.top.equalTo(self.centerView);
        make.height.mas_equalTo(30);
    }];
    
    [self.centerView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerTopLab);
        make.top.equalTo(self.centerTopLab.mas_bottom);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(70);
    }];
    
    
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(56);
    }];
    
    NSAttributedString *botttomString = [LYDUtil LableTextShowInBottom:@"*联系方式" InsertWithString:@"*" InsertSecondStr:@"" InsertStringColor:[UIColor colorWithHex:@"#FF0E2E"] WithInsertStringFont:FONT(13)];
    self.bottomLable = [[UILabel alloc] init];
    self.bottomLable.font = FONT(14);
    self.bottomLable.textColor = Tit_Black_Color;
    [self.bottomLable setAttributedText:botttomString];
    [self.bottomView addSubview:self.bottomLable];
    [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(self.titDesLab);
        make.width.mas_equalTo(64);
    }];
    
    self.phoneLab = [[UILabel alloc] init];
    self.phoneLab.font = FONT(14);
    self.phoneLab.textColor = Tit_Black_Color;
    [self.phoneLab setText:[NSString stringWithFormat:@"%@",self.loginModel.servicetele]];
    [self.bottomView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(self.bottomLable.mas_right).offset(45);
    }];

    [self.view addSubview:self.commitBut];
    [self.commitBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.right.mas_equalTo(-23);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.bottomView.mas_bottom).offset(30);
    }];


}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.imageArray.count == 3) {
        return 3;
    }else{
        return self.imageArray.count+1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSSfbCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
  
    [cell.detBut addTarget:self action:@selector(detImgButton:) forControlEvents: UIControlEventTouchUpInside];
    if (indexPath.row == self.imageArray.count) {
        cell.img.image = [UIImage imageNamed:@"self_fb_photo"];
        cell.detBut.hidden = YES;

    }else{
        NSLog(@"**********%@",self.imageArray);
//        NSString *cellImg = self.imageArray[indexPath.item];
        cell.img.image = self.imageArray[indexPath.item];
//        [cell.img sd_setImageWithURL:[NSURL URLWithString:cellImg]];
        cell.detBut.hidden = NO;
    }

    return cell;
    
}
-(void)detImgButton:(UIButton *)but{
    
    UIView *contentView = [but superview];
    
    YSSfbCollectionViewCell *cell =(YSSfbCollectionViewCell *)[contentView superview];
    NSIndexPath *index = [self.collectionView indexPathForCell:cell];
//    NSString *cellImg = self.imageArray[index.item];

    [self.imageArray removeObject:self.imageArray[index.item]];
    [self.pubPicAssetArr removeObjectAtIndex:index.item];
    [self.collectionView reloadData];

}
#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){itemWidth,itemWidth};
    
}
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

//    return (SCREEN_WIDTH-40-itemWidth*4)/3;
    return 5.f;
}
 // 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return (SCREEN_WIDTH-40-itemWidth*4)/3;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.imageArray.count == 3){
        [self showBigImage:indexPath];
    }else{
        if (indexPath.item ==  self.imageArray.count) {
            [self chousePiack];
            
        }else{
//            [self showBigImage:indexPath];
        }

    }
}
-(void)showBigImage:(NSIndexPath *)index{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = index.item;
    photoBrowser.imageCount = self.imageArray.count;
    photoBrowser.sourceImagesContainerView = self.collectionView;
    
    [photoBrowser show];
}
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已    http://image-demo.oss-cn-hangzhou.aliyuncs.com/example.jpg?x-oss-process=image/resize,m_fixed,h_100,w_100 OSS缩放功能
    YSSfbCollectionViewCell *cell = (YSSfbCollectionViewCell *)[self collectionView:self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    
    return cell.img.image;
    
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [self.srcStringArray[index] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}
-(void)chousePiack{
    @weakify(self);
    TZImagePickerController *imagePick = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
    imagePick.selectedAssets = self.pubPicAssetArr;
    imagePick.allowTakeVideo = NO;
    [imagePick setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        @strongify(self);
        self.pubPicAssetArr = [assets mutableCopy];

//        [[YSSUploadImageManger aliyunInit] uploadImage:photos WithFilePath:@"feedback" Success:^(NSMutableArray * _Nonnull obj) {
            
            [self.srcStringArray setArray:photos];
            [self.imageArray setArray:photos];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
//                [self updataSelectImgUI];

            });

//            NSLog(@"上传图片 %@",obj);
//        }];

        
    }];
    imagePick.modalPresentationStyle = UIModalPresentationFullScreen;

    [self presentViewController:imagePick animated:YES completion:nil];
}
-(void)textViewDidChange:(UITextView *)textView{
    
    //字数限制
    if (textView.text.length > 200) {
        textView.text = [textView.text substringToIndex:200];
    }
    
    self.allLienceLab.text = [NSString stringWithFormat:@"%ld/200",textView.text.length];
    
}
-(void)sureButtonClick{
    
    
    [[RequestAPI shareInstance] feedBackUploadMoreImage:@{@"userId":self.loginModel.userId,@"custComplaint":self.textView.text} :self.imageArray Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        if (succeed) {
              if ([result[@"success"] intValue] == 1) {
                  
                  NSDictionary *dataDic = result[@"result"];
                  [MBProgressHUD showSuccess:EMPTY_IF_NIL(dataDic[@"feedback"])];
                  
                  [self.navigationController popViewControllerAnimated:YES];
              }else{
                  
                  [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];

              }
          }

    }];
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
-(UILabel *)titDesLab{
    if (!_titDesLab) {
        _titDesLab = [[UILabel alloc] init];
        _titDesLab.font = FONT(14);
        _titDesLab.textColor = Tit_Black_Color;
    }
    return _titDesLab;
}
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = FONT(13);
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.placeholder = @"请输入问题";
        _textView.delegate = self;
    }
    return _textView;
}

-(UILabel *)allLienceLab{
    if (!_allLienceLab) {
        _allLienceLab = [[UILabel alloc] init];
        _allLienceLab.font = FONT(13);
        _allLienceLab.textColor = Tit_Gray_Color;
        _allLienceLab.text = @"0/200";

    }
    return _allLienceLab;
}
-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableArray *)pubPicAssetArr{
    if (!_pubPicAssetArr) {
        _pubPicAssetArr = [NSMutableArray array];
    }return _pubPicAssetArr;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[YSSfbCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}
-(UIButton *)commitBut{
    if (!_commitBut) {
        _commitBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBut.backgroundColor = [UIColor colorWithHex:@"#4D56EF"];
        [_commitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitBut.layer.shadowOffset = CGSizeMake(0, 2);
        _commitBut.layer.shadowOpacity = 1;
        _commitBut.layer.shadowColor = [UIColor colorWithHex:@"#B5B8FF"].CGColor;
        _commitBut.layer.shadowRadius = 9;
        _commitBut.titleLabel.font = BOLDFONT(18);
        _commitBut.timeInterval = 5;
        [_commitBut setTitle:@"提交" forState:UIControlStateNormal];
        [_commitBut addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBut;
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
