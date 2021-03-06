//
//  UUChatCollectionViewCell.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatCollectionViewCell.h"
#import "Chat-Macros.h"
#import "Chat-Import.h"

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

- (void)prepareForReuse{

    [super prepareForReuse];
    
    [self.timeStampView setContent:@""];
    _imgUserAvatar.image = nil;

    _lblMessage.text = nil;
    
    _imgMessage.image = nil;
    _imgBubble.image = nil;
    
    _lblSoundTime.text = nil;
    _imgSound.image = nil;
}

#pragma mark - life cycle

- (void)configUI{
    
    self.chatMessageIncomingInsets = UIEdgeInsetsMake(10, 20, 10, 15);
    self.chatMessageOutgoingInsets = UIEdgeInsetsMake(10, 15, 10, 20);
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.imgUserAvatar];
    [self.contentView addSubview:self.lblUserName];
    [self.contentView addSubview:self.timeStampView];
    [self.contentView addSubview:self.imgBubble];
    
    [_imgBubble addSubview:self.lblMessage];
    
    [_imgBubble addSubview:self.imgMessage];
    
    [_imgBubble addSubview:self.lblSoundTime];
    [_imgBubble addSubview:self.imgSound];
    
    
//    self.contentView.layer.borderColor = [UIColor blueColor].CGColor;
//    self.contentView.layer.borderWidth = 2;
}



#pragma mark - Delegate

#pragma mark - Custom Deledate

#pragma mark - Event Response

#pragma mark - Public Methods

- (void)setContentWithObject:(UUChatMessage *)obj indexPath:(NSInteger )index{

}

- (void)setImageMessageWithBubbleImage:(UIImage *)image imageSize:(CGSize)size{
    
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectMake(0, 0, size.width, size.height);
    
    self.imgMessage.layer.mask = imageViewMask.layer;
}

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
        _imgUserAvatar.layer.cornerRadius = 40 /2;
        _imgUserAvatar.layer.masksToBounds = YES;
        
//        _imgUserAvatar.layer.borderColor = [UIColor blueColor].CGColor;
//        _imgUserAvatar.layer.borderWidth = 2;

        
    }
    
    return _imgUserAvatar;
}


- (UIImageView *)getImageBubble{
    
    if (!_imgBubble) {
        
        _imgBubble = [[UIImageView alloc] init];
        
//        _imgBubble.layer.borderWidth = 2;
//        _imgBubble.layer.borderColor = [UIColor greenColor].CGColor;
    }
    
    return _imgBubble;
}

- (UUChatTimeStampView *)getTimestampView{
    
    if (!_timeStampView) {
        
        _timeStampView = [[UUChatTimeStampView alloc] init];
        
//        _timeStampView.layer.borderColor = [UIColor blueColor].CGColor;
//        _timeStampView.layer.borderWidth = 2;
    }
    
    return _timeStampView;
}


- (UILabel *)getLabelUserName{
    
    if (!_lblUserName) {
        
        _lblUserName = UILabel.new;
        _lblUserName.font = [UIFont systemFontOfSize:14];
        _lblUserName.textColor = COLOR_WITH_RGB(103,103,103,1);
    }
    
    return _lblUserName;
}


- (UILabel *)getLabelMessage{
    
    if (!_lblMessage) {
        
        _lblMessage = UILabel.new;
        _lblMessage.numberOfLines = 0;
         _lblMessage.textColor = COLOR_WITH_RGB(63,63,63,1);
        _lblMessage.preferredMaxLayoutWidth = [UUChatCollectionViewCell maxBubboleWidth];
        
//                _lblMessage.layer.borderWidth = 2;
//                _lblMessage.layer.borderColor = [UIColor greenColor].CGColor;
        
    }
    
    return _lblMessage;
}

- (UIImageView *)getImageMessage{

    if (!_imgMessage) {
        
        _imgMessage = [[UIImageView alloc] init];
        _imgMessage.contentMode = UIViewContentModeScaleAspectFill;
        
//        _imgMessage.layer.borderWidth = 2;
//        _imgMessage.layer.borderColor = [UIColor redColor].CGColor;
    }
    
    return _imgMessage;
}


- (UIImageView *)getImageSound{
    
    if (!_imgSound) {
        
        _imgSound = [[UIImageView alloc] init];
        _imgSound.contentMode = UIViewContentModeScaleAspectFill;
        
        //        _imgMessage.layer.borderWidth = 2;
        //        _imgMessage.layer.borderColor = [UIColor redColor].CGColor;
    }
    
    return _imgSound;
}

- (UILabel *)getLabelSoundTime{
    
    if (!_lblSoundTime) {
        
        _lblSoundTime = UILabel.new;
        _lblSoundTime.numberOfLines = 0;
        _lblSoundTime.textAlignment = NSTextAlignmentRight;
        _lblSoundTime.textColor = COLOR_WITH_RGB(63,63,63,1);
        _lblSoundTime.preferredMaxLayoutWidth = [UUChatCollectionViewCell maxBubboleWidth];
        
        //                _lblMessage.layer.borderWidth = 2;
        //                _lblMessage.layer.borderColor = [UIColor greenColor].CGColor;
        
    }
    
    return _lblSoundTime;
}

@end
