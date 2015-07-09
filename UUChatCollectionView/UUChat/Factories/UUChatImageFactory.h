//
//  UUChatImageFactory.h
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/8.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UUChatImageFactory : NSObject

+(UIImage *)bubbleImageIncoming;

+(UIImage *)bubbleImageOutgoing;

+(UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (CGSize)calcImageScaleSize:(CGSize)imgSize maxWidth:(CGFloat)maxwidth maxHeight:(CGFloat)maxheight;
@end
