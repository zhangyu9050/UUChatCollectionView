//
//  UUChatCollectionViewDataSource.h
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/6.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UUChatCollectionView, UUChatMessage;
@protocol UUChatCollectionViewDataSource < UICollectionViewDataSource >

- (UUChatMessage *)collectionView:(UUChatCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath;


@end
