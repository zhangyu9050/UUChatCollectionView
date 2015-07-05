//
//  UUChatCollectionViewCell.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatCollectionViewCell.h"
#import "Chat-Macros.h"

@implementation UUChatCollectionViewCell

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self configUI];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
        
    }
    return self;
}

#pragma mark - life cycle

- (void)configUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.imgUserAvatar];
    [self.contentView addSubview:self.lblUserName];
    [self.contentView addSubview:self.lblTimestamp];
    [self.contentView addSubview:self.imgBubble];
    
    [_imgBubble addSubview:self.lblMessage];
    
    self.contentView.layer.borderColor = [UIColor blueColor].CGColor;
    self.contentView.layer.borderWidth = 2;
}

#pragma mark - Delegate

#pragma mark - Custom Deledate

#pragma mark - Event Response

#pragma mark - Public Methods

+ (NSString *)cellReuseIdentifier{
    
    return NSStringFromClass([self class]);
}

+ (CGFloat)maxBubboleWidth{
    
    return ScreenWidth - 140;
}

#pragma mark - Private Methods

#pragma mark - Getters And Setters

- (UIImageView *)getImageUserAvatar{
    
    if (!_imgUserAvatar) {
        
        _imgUserAvatar = [[UIImageView alloc] init];
    }
    
    return _imgUserAvatar;
}


- (UIImageView *)getImageBubble{
    
    if (!_imgBubble) {
        
        _imgBubble = [[UIImageView alloc] init];
        
        //        _imgBubble.layer.borderWidth = 2;
        //        _imgBubble.layer.borderColor = [UIColor redColor].CGColor;
    }
    
    return _imgBubble;
}

- (UILabel *)getLabelTimestamp{
    
    if (!_lblTimestamp) {
        
        _lblTimestamp = UILabel.new;
        _lblTimestamp.textAlignment = NSTextAlignmentCenter;
    }
    
    return _lblTimestamp;
}

- (UILabel *)getLabelUserName{
    
    if (!_lblUserName) {
        
        _lblUserName = UILabel.new;
    }
    
    return _lblUserName;
}


- (UILabel *)getLabelMessage{
    
    if (!_lblMessage) {
        
        _lblMessage = UILabel.new;
        _lblMessage.numberOfLines = 0;
        _lblMessage.preferredMaxLayoutWidth = [UUChatCollectionViewCell maxBubboleWidth];
        
        //        _lblMessage.layer.borderWidth = 2;
        //        _lblMessage.layer.borderColor = [UIColor greenColor].CGColor;
        
    }
    
    return _lblMessage;
}

@end
