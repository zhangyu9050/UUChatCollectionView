//
//  UUChatImageFactory.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/8.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatImageFactory.h"

@implementation UUChatImageFactory

+(UIImage*)originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

//////计算图片的frame
+ (CGSize)calcImageScaleSize:(CGSize)imgSize maxWidth:(CGFloat)maxwidth maxHeight:(CGFloat)maxheight
{
    CGSize scaleSize = CGSizeMake(0, 0);
    CGFloat hrate = imgSize.height / maxheight;
    CGFloat wrate = imgSize.width / maxwidth;
    if (hrate <= 1.0 && wrate <= 1.0) {
        scaleSize.width = imgSize.width;
        scaleSize.height = imgSize.height;
    }
    if (hrate > 1.0 && wrate <= 1.0)
    {
        scaleSize.width = imgSize.width/hrate;
        scaleSize.height = maxheight;
        
    }
    if (hrate <= 1.0 && wrate > 1.0) {
        scaleSize.width = maxwidth;
        scaleSize.height = imgSize.height/wrate;
    }
    if (hrate > 1.0 && wrate > 1.0) {
        if (hrate > wrate) {
            scaleSize.width = imgSize.width / hrate;
            scaleSize.height = imgSize.height/hrate;
        }else
        {
            scaleSize.width = imgSize.width / wrate;
            scaleSize.height = imgSize.height/wrate;
        }
    }
    return scaleSize;
}

@end
