//
//  UUChatMessage.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatMessage.h"

#define kDefultImagePath @"a3535137dff44727aecd42325b271fce.jpg"

@implementation UUChatMessage

- (instancetype)initWithSendMessage:(NSString *)message{

    if (self = [super init]) {
        
        self.timestamp = [self sendTimeString];
        self.userName = @"zhang";
        self.userAvatar = @"userAvatarIncoming";
        self.message = message;
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
    }
    
    return self;

}


- (NSString *)sendTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate date]];
}


@end
