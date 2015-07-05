//
//  UUChatCollectionViewCellIncoming.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatCollectionViewCellIncoming.h"
#import "Chat-Import.h"
#import "Chat-Macros.h"

@implementation UUChatCollectionViewCellIncoming

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self configUI];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
        
    }
    return self;
}

#pragma mark - life cycle

- (void)configUI{
    
    [super configUI];
    
//    self.lblTimestamp.text = @"2015-0704";
//    self.lblUserName.text = @"zhangyu";
//    self.imgUserAvatar.image = [UIImage imageNamed:@"userAvatarIncoming"];
//    
//    self.lblMessage.text = @"However, when we rotate from portrait to landscape we get the following complaint";
    
    
    UIImage* img=[UIImage imageNamed:@"bg_bubble_nor"];//原图
    UIEdgeInsets edge=UIEdgeInsetsMake(15, 15, 15 ,15);
    
    self.imgBubble.image= [img resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
}

- (void)updateConstraints{
    
    if (!self.didSetupConstraints) {
        
        [self.timeStampView mas_makeConstraints:^(MASConstraintMaker *make) {
            
//            make.height.mas_lessThanOrEqualTo(@20);
            make.top.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
        }];
        
        [self.imgUserAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(kUserAvatarSize);
            make.top.equalTo(self.timeStampView.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(10);
        }];
        
        [self.lblUserName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(@25);
            make.width.mas_equalTo([UUChatCollectionViewCell maxBubboleWidth]);
            make.top.equalTo(self.imgUserAvatar);
            make.left.equalTo(self.imgUserAvatar.mas_right).offset(10);
            
        }];
        
        [self.imgBubble mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //            make.width.mas_equalTo([CBChatCollectionCell maxBubboleWidth]);
            make.top.equalTo(self.lblUserName.mas_bottom).offset(5);
            make.left.equalTo(self.imgUserAvatar.mas_right).offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
        
        [self.lblMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.imgBubble).with.insets(UIEdgeInsetsMake(10, 20, 10, 15));
        }];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - Delegate

#pragma mark - Custom Deledate

#pragma mark - Event Response

#pragma mark - Public Methods

- (void)setContentWithObject:(UUChatMessage *)obj{

    [self.timeStampView setContent:obj.timestamp];
    self.lblUserName.text = obj.userName;
    self.imgUserAvatar.image = [UIImage imageNamed:obj.userAvatar];

    self.lblMessage.text = obj.message;
}

#pragma mark - Private Methods

#pragma mark - Getters And Setters

@end
