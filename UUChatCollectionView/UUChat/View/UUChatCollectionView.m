//
//  UUChatCollectionView.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatCollectionView.h"
#import "Chat-Import.h"

@implementation UUChatCollectionView

@dynamic dataSource;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        [self configUI];
    }
    
    return self;
}

#pragma mark - life cycle

- (void)configUI{
    
    self.backgroundColor      = [UIColor whiteColor];
    self.keyboardDismissMode  = UIScrollViewKeyboardDismissModeNone;
    self.alwaysBounceVertical = YES;
    self.bounces              = YES;
    
    [self registerClass:[UUChatCollectionViewCellIncoming class] forCellWithReuseIdentifier:[UUChatCollectionViewCellIncoming cellReuseIdentifier]];
    [self registerClass:[UUChatCollectionViewCellOutgoing class] forCellWithReuseIdentifier:[UUChatCollectionViewCellOutgoing cellReuseIdentifier]];
    
    
    
}


#pragma mark - Delegate

#pragma mark - Custom Deledate

#pragma mark - Event Response

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Getters And Setters


@end
