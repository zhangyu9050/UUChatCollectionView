//
//  UUChatCollectionViewFlowLayout.h
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UUChatMessage;
@interface UUChatCollectionViewFlowLayout : UICollectionViewFlowLayout

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath message:(UUChatMessage *)message;

@end
