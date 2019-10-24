//
//  YSSfbCollectionViewCell.m
//  YSSProject-master
//
//  Created by 貟一凡 on 2019/5/27.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "YSSfbCollectionViewCell.h"
#import "Masonry.h"
@implementation YSSfbCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self creatDetialUI];
    }
    
    return self;
}
-(void)creatDetialUI{
    
    [self.contentView addSubview:self.img];
    
    [self.contentView addSubview:self.detBut];
    [self.detBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.img.mas_right);
        make.centerY.equalTo(self.img.mas_top);
        make.width.and.height.mas_equalTo(30);
    }];

}
-(UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 56, 56)];
        _img.layer.cornerRadius = 5;
        _img.clipsToBounds = YES;
    }
    return _img;
}
-(UIButton *)detBut{
    if (!_detBut) {
        _detBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detBut setImage:[UIImage imageNamed:@"img_delt"] forState:UIControlStateNormal];
    }
    return _detBut;
}
@end
