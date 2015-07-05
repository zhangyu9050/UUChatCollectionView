//
//  UUChatCollectionView.h
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUChatCollectionViewDataSource.h"

@class UUChatCollectionViewFlowLayout;
@interface UUChatCollectionView : UICollectionView

@property (nonatomic, strong) UUChatCollectionViewFlowLayout *collectionViewLayout;

@property (weak, nonatomic) id<UUChatCollectionViewDataSource> dataSource;

@end
