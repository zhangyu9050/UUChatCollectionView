//
//  UUChatMessage.h
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUChatMessage : NSObject

@property (nonatomic, strong) NSString *fromId;

@property (nonatomic, strong) NSString *timestamp;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *userAvatar;

@property (nonatomic, strong) NSString *message;


- (instancetype)initWithSendMessage:(NSString *)message;

@end
