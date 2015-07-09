//
//  UUChatMessage.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatMessage.h"

#define kDefultImagePath @"u=4070476623,1398118108&fm=21&gp=0.jpg"

@implementation UUChatMessage

- (instancetype)initWithSendMessage:(NSString *)message{

    if (self = [super init]) {
        
        self.timestamp = [self sendTimeString];
        self.userName = @"zhang";
        self.userAvatar = @"userAvatarIncoming";
        self.message = message;
        self.messageType = kUUChatMessage;
    }
    
    return self;
}

- (instancetype)initWithSendImagePath:(NSString *)path{

    if (self = [super init]) {
        
        self.timestamp = [self sendTimeString];
        self.userName = @"zhang";
        self.userAvatar = @"userAvatarIncoming";
        self.message = @"";
        self.localPath = kDefultImagePath;
        self.originalImagePath = @"";
        self.messageType = kUUChatImage;
    }
    
    return self;

}


- (NSString *)sendTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate date]];
}


@end
