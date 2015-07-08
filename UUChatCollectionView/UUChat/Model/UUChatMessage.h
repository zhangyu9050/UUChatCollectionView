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

@property (nonatomic, strong) NSString *localPath;

@property (nonatomic, strong) NSString *originalImagePath;

@property (nonatomic, strong) NSNumber *status;

@property (nonatomic, strong) NSNumber *unRead;



- (instancetype)initWithSendMessage:(NSString *)message;

- (instancetype)initWithSendImagePath:(NSString *)path;

@end
