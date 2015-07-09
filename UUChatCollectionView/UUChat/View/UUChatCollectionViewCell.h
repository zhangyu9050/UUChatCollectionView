//
//  UUChatCollectionViewCell.h
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kUserAvatarSize CGSizeMake(40,40)

#define kTimeStempOffsetTop  15

@class UUChatMessage, UUChatTimeStampView;
@interface UUChatCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, getter = getImageUserAvatar) UIImageView *imgUserAvatar;
@property (nonatomic, strong, getter = getImageBubble) UIImageView *imgBubble;
@property (nonatomic, strong, getter = getTimestampView) UUChatTimeStampView *timeStampView;
@property (nonatomic, strong, getter = getLabelUserName) UILabel *lblUserName;

@property (nonatomic, strong, getter = getLabelMessage) UILabel *lblMessage;
@property (nonatomic, strong, getter = getImageMessage) UIImageView *imgMessage;

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, assign) UIEdgeInsets timeStampInsets;

@property (nonatomic, assign) UIEdgeInsets chatMessageIncomingInsets;

@property (nonatomic, assign) UIEdgeInsets chatMessageOutgoingInsets;

- (void)configUI;
- (void)setContentWithObject:(UUChatMessage *)obj indexPath:(NSInteger )index;
- (void)setImageMessageWithBubbleImage:(UIImage *)image imageSize:(CGSize)size;

+ (NSString *)cellReuseIdentifier;

+ (CGFloat)maxBubboleWidth;

@end
