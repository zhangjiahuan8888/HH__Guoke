//
//  HomeCell.m
//  HH__Guoke
//
//  Created by 张家欢 on 16/7/25.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#import "HomeCell.h"
#import "UIImageView+AFNetworking.h"
@interface HomeCell()

@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *imgView;
@end
@implementation HomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 2;
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(kSCREEN_WIDTH-30-25-75);
        }];
        
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.width.mas_equalTo(75);
            make.height.mas_equalTo(60);
        }];
    }
    return self;
}

- (void)setModel:(HomeModel *)model{
    _model = model;
    _contentLabel.text = _model.title;
    [_imgView setImageWithURL:[NSURL URLWithString:_model.headline_img_tb]];
}

@end
