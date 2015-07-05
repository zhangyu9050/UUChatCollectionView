//
//  UUChatCollectionViewCellOutgoing.h
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatCollectionViewCell.h"

@class UUChatMessage;
@interface UUChatCollectionViewCellOutgoing : UUChatCollectionViewCell

- (void)setContentWithObject:(UUChatMessage *)obj;

@end
