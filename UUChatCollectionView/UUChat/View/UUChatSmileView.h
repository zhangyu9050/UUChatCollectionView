//
//  UUChatSmileView.h
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/8.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UUChatSmileViewDelegate < NSObject >

- (void)selectedSmileView:(NSString *)str isDelete:(BOOL)isDelete;

@end

@interface UUChatSmileView : UIView

@property (nonatomic, weak) id<UUChatSmileViewDelegate> delegate;

- (BOOL)isSmileString:(NSString *)string;

@end
