//
//  ViewController.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "ViewController.h"
#import "UUChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"touches";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - life cycle

- (void)configUI{
    
}

- (void)updateConstraint{
    
}

#pragma mark - Delegate

#pragma mark - Custom Deledate

#pragma mark - Event Response

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.navigationController pushViewController:UUChatViewController.new animated:YES];
}

#pragma mark - Public Methods


+(UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size
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

#pragma mark - Private Methods

#pragma mark - Getters And Setters

@end
