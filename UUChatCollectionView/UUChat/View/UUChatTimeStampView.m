//
//  UUChatTimeStampView.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatTimeStampView.h"
#import "Chat-Macros.h"
#import "Chat-Import.h"

@interface UUChatTimeStampView()

@property (nonatomic, strong, getter = getLabelTimeStamp) UILabel *lblTimestamp;

@end
@implementation UUChatTimeStampView

- (instancetype)init{

    if (self = [super init]) {
        
        [self configUI];
        [self updateConstraint];
    }
    
    return self;
}

- (void)configUI{

    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.backgroundColor = COLOR_WITH_RGB(203,204,210,1);
    
    [self addSubview:self.lblTimestamp];
}

- (void)updateConstraint{

    [_lblTimestamp mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 5, 0, 5)).priorityHigh();
    }];
}

- (void)setContent:(NSString *)string{

    _lblTimestamp.text = string;
}

- (UILabel *)getLabelTimeStamp{

    if (!_lblTimestamp) {
        
        _lblTimestamp = [[UILabel alloc] init];
        _lblTimestamp.font = [UIFont systemFontOfSize:13];
        _lblTimestamp.textColor = [UIColor whiteColor];
    }
    
    return _lblTimestamp;
}

@end
