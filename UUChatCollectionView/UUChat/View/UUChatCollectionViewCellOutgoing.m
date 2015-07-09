//
//  UUChatCollectionViewCellOutgoing.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatCollectionViewCellOutgoing.h"
#import "Chat-Import.h"
#import "Chat-Macros.h"

@interface UUChatCollectionViewCellOutgoing(){

    CGFloat Offset;
}

@end

@implementation UUChatCollectionViewCellOutgoing

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
    
    self.lblUserName.textAlignment = NSTextAlignmentRight;

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
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        [self.lblUserName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(@20).priorityHigh();
            make.top.equalTo(self.imgUserAvatar);
            make.right.equalTo(self.imgUserAvatar.mas_left).offset(-10);
            
        }];
        
        [self.imgBubble mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.lblUserName.mas_bottom).offset(0);
            make.right.equalTo(self.imgUserAvatar.mas_left).offset(-5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
        
        [self.lblMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.imgBubble).with.insets(self.chatMessageOutgoingInsets);
        }];
        
        [self.imgMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.imgBubble).with.insets(UIEdgeInsetsZero);
        }];
        
        [self.lblSoundTime mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.imgBubble).with.insets(self.chatMessageOutgoingInsets);
        }];
        
        [self.imgSound mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(5, 20));
            make.centerY.equalTo(self.imgBubble);
            make.left.equalTo(self.imgBubble).offset(20);
        }];
        
        self.didSetupConstraints = YES;
    }
    
    [self.timeStampView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(Offset);
    }];
    
    [self.imgUserAvatar mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeStampView.mas_bottom).offset(Offset == 0 ? 10 :20);
    }];
    
    if (self.lblSoundTime.text.length > 0) {

        [self.lblSoundTime mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(@100);
        }];

    }
    
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
    self.imgSound.hidden = self.lblSoundTime.hidden = YES;
    
    UIImage *bubbleImage = [UUChatImageFactory bubbleImageOutgoing];
    
    self.imgBubble.image= bubbleImage;
    
    if (obj.messageType == kUUChatMessage) {
        
        self.lblMessage.hidden = NO;
        self.lblMessage.text = obj.message;
        
    }else if (obj.messageType == kUUChatImage){
        
        self.imgMessage.hidden = NO;
        
        UIImage *image = [UIImage imageNamed:obj.localPath];
        CGSize size = [UUChatImageFactory calcImageScaleSize:image.size maxWidth:200 maxHeight:200];
        
        self.imgMessage.image = [UUChatImageFactory originImage:image scaleToSize:size];
        [self setImageMessageWithBubbleImage:bubbleImage imageSize:size];
        
    }else if (obj.messageType == kUUChatSound){
        
        self.imgSound.hidden = self.lblSoundTime.hidden = NO;
        
        self.lblSoundTime.text = @"12'";
        self.imgSound .image = [UIImage imageNamed:@"wave3_w"];
    }
}

#pragma mark - Private Methods

#pragma mark - Getters And Setters

@end
