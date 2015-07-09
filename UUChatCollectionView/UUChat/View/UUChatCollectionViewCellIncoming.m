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

@interface UUChatCollectionViewCellIncoming(){

    CGFloat Offset;
    CALayer *_contentLayer;
}

@end

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
    
    
    UIImage* img=[UIImage imageNamed:@"bg_bubble_nor"];//原图
    UIEdgeInsets edge=UIEdgeInsetsMake(15, 15, 15 ,15);
    
    self.imgBubble.image= [img resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
}

- (void)updateConstraints{
    
    if (!self.didSetupConstraints) {
        
        [self.timeStampView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_lessThanOrEqualTo(@20);
            make.top.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
        }];
        
        [self.imgUserAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(kUserAvatarSize);
            make.top.equalTo(self.timeStampView.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(10);
        }];
        
        [self.lblUserName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(@20).priorityHigh();
            make.top.equalTo(self.imgUserAvatar);
            make.left.equalTo(self.imgUserAvatar.mas_right).offset(10);
            
        }];
        
        [self.imgBubble mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.lblUserName.mas_bottom).offset(0);
            make.left.equalTo(self.imgUserAvatar.mas_right).offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
        
        [self.lblMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.imgBubble).with.insets(self.chatMessageIncomingInsets);
        }];
        
        self.didSetupConstraints = YES;
    }
    
    [self.timeStampView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(Offset);
    }];
    
    [self.imgUserAvatar mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeStampView.mas_bottom).offset(Offset == 0 ? 10 :20);
    }];
    

    
    [super updateConstraints];
}

#pragma mark - Delegate

#pragma mark - Custom Deledate

#pragma mark - Event Response

#pragma mark - Public Methods

- (void)setContentWithObject:(UUChatMessage *)obj indexPath:(NSInteger )index{
    
    if (index % 5 == 0) {
        
        [self.timeStampView setContent:obj.timestamp];
        Offset = kTimeStempOffsetTop;
        
    }else{
        
        [self.timeStampView setContent:@""];
        Offset = 0;
    }
    
    self.lblUserName.text = obj.userName;
    self.imgUserAvatar.image = [UIImage imageNamed:obj.userAvatar];
    
    self.imgMessage.hidden = self.lblMessage.hidden = YES;
    
    UIImage* img=[UIImage imageNamed:@"bg_bubble_nor"];//原图
    UIEdgeInsets edge=UIEdgeInsetsMake(15, 15, 15 ,15);
    UIImage *bubbleImage = [img resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    
    self.imgBubble.image= bubbleImage;

    if (obj.messageType == kUUChatMessage) {

        self.lblMessage.hidden = NO;
        self.lblMessage.text = obj.message;
    }
}

#pragma mark - Private Methods

- (void)setImageMessageWithBubbleImage:(UIImage *)image imageSize:(CGSize)size{

    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(self.imgMessage.frame, 0, 0);

    self.imgMessage.layer.mask = imageViewMask.layer;
    self.imgBubble.layer.masksToBounds = YES;
}

#pragma mark - Getters And Setters

@end
