//
//  UUChatCollectionViewFlowLayout.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatCollectionViewFlowLayout.h"

@implementation UUChatCollectionViewFlowLayout

- (instancetype)init{
    
    if (self = [super init]) {
        
        //        _weakSuper = weakSuper;
        [self configUI];
    }
    
    return self;
}

#pragma mark - life cycle

- (void)configUI{
    
    self.scrollDirection    = UICollectionViewScrollDirectionVertical;
    self.sectionInset       = UIEdgeInsetsMake(10.0f, 4.0f, 10.0f, 4.0f);
    self.minimumLineSpacing = 4.0f;
    
    //    _outgoingAvatarSize     = _incomingAvatarSize = kUserAvatarSize;
    //    _timestampInsets        = UIEdgeInsetsMake(15, 0, 0, 0);
    //    _usernameInsets         = UIEdgeInsetsMake(10, 0, 0, 0);
    //    _messageBubbleInsets    = UIEdgeInsetsMake(5, 0, 0, 0);
    //    _messageInsets          = UIEdgeInsetsMake(10, 20, 10, 15);
}


- (void)prepareLayout{
    
    [super prepareLayout];
}


@end
