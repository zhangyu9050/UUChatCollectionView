//
//  UUChatCollectionViewLayoutAttributes.h
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUChatCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes <NSCopying>


@property (strong, nonatomic) UIFont *messageFont;


@property (assign, nonatomic) CGFloat messageBubbleMaxWidth;


@property (assign, nonatomic) UIEdgeInsets messageBubbleInsets;

@property (assign, nonatomic) UIEdgeInsets messageFrameInsets;


@property (assign, nonatomic) CGSize incomingAvatarSize;


@property (assign, nonatomic) CGSize outgoingAvatarSize;


@property (assign, nonatomic) CGFloat cellTimeStampHeight;


@property (assign, nonatomic) CGFloat cellUserNameHeight;




@end
