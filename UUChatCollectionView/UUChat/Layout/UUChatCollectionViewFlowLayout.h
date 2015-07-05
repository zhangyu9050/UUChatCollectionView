//
//  UUChatCollectionViewFlowLayout.h
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UUChatCollectionView;
@interface UUChatCollectionViewFlowLayout : UICollectionViewFlowLayout

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
@property (readonly, nonatomic) UUChatCollectionView *collectionView;
#pragma clang diagnostic pop

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
