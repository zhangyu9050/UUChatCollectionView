//
//  UUChatCollectionViewLayoutAttributes.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatCollectionViewLayoutAttributes.h"

@implementation UUChatCollectionViewLayoutAttributes

#pragma mark - Setters

- (void)setMessageFont:(UIFont *)messageFont{

    _messageFont = messageFont;
}


- (void)setMessageBubbleMaxWidth:(CGFloat)messageBubbleMaxWidth{

    _messageBubbleMaxWidth = messageBubbleMaxWidth;
}

- (void)setMessageBubbleInsets:(UIEdgeInsets)messageBubbleInsets{

    _messageBubbleInsets = messageBubbleInsets;
}

- (void)setMessageFrameInsets:(UIEdgeInsets)messageFrameInsets{

    _messageFrameInsets = messageFrameInsets;
}

- (void)setIncomingAvatarSize:(CGSize)incomingAvatarSize{

    _incomingAvatarSize = incomingAvatarSize;
}

- (void)setOutgoingAvatarSize:(CGSize)outgoingAvatarSize{

    _outgoingAvatarSize = outgoingAvatarSize;
}

- (void)setCellTimeStampHeight:(CGFloat)cellTimeStampHeight{

    _cellTimeStampHeight = cellTimeStampHeight;
}

- (void)setCellUserNameHeight:(CGFloat)cellUserNameHeight{

    _cellUserNameHeight = cellUserNameHeight;
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    UUChatCollectionViewLayoutAttributes *copy = [super copyWithZone:zone];
    
    if (copy.representedElementCategory != UICollectionElementCategoryCell) {
        return copy;
    }
    
    copy.messageFont = self.messageFont;
    copy.messageBubbleMaxWidth = self.messageBubbleMaxWidth;
    copy.messageBubbleInsets = self.messageBubbleInsets;
    copy.messageFrameInsets = self.messageFrameInsets;
    copy.incomingAvatarSize = self.incomingAvatarSize;
    copy.outgoingAvatarSize = self.outgoingAvatarSize;
    copy.cellTimeStampHeight = self.cellTimeStampHeight;
    copy.cellUserNameHeight = self.cellUserNameHeight;
//    copy.cellBottomLabelHeight = self.cellBottomLabelHeight;
    
    return copy;
}

@end
