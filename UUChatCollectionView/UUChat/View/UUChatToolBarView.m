//
//  UUChatToolBarView.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatToolBarView.h"
#import "Chat-Macros.h"
#import "Chat-Import.h"

@interface UUChatToolBarView()

@property (nonatomic, strong, getter = getButtonMicroPhone) UIButton *btnMicroPhone;
@property (nonatomic, strong, getter = getButtonAdd) UIButton *btnAdd;

@end

@implementation UUChatToolBarView

- (instancetype)init{

    if (self = [super init]) {
        
        [self configUI];
        [self updateConstraint];
    }
    
    return self;
}

#pragma mark - life cycle

- (void)configUI{
    
    self.backgroundColor = COLOR_WITH_RGB(217,219,225,1);
    
    [self addSubview:self.btnAdd];
    [self addSubview:self.txtMessage];
    [self addSubview:self.btnMicroPhone];

}

- (void)updateConstraint{
    
    [_btnMicroPhone mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.equalTo(self).offset(12);
        make.top.equalTo(self).offset(12.5);
    }];
    
    [_btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(_btnMicroPhone);
        make.right.equalTo(self).offset(-12);
        make.top.equalTo(self).offset(12.5);
    }];
    
    [_txtMessage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(7);
        make.left.equalTo(_btnMicroPhone.mas_right).offset(10);
        make.right.equalTo(_btnAdd.mas_left).offset(-10);
        make.bottom.equalTo(self).offset(-7);
    }];
}

- (void)dealloc{

    [_txtMessage removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - Observe KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (object == _txtMessage) {

        __block CGFloat offsetHeight = _txtMessage.contentSize.height;
//        if (offsetHeight < 74)
            [self updateMessageOffsetHeight:offsetHeight];
        
        CGFloat topCorrect = (_txtMessage.frame.size.height - _txtMessage.contentSize.height);
        topCorrect = (topCorrect <0.0 ?0.0 : topCorrect);
        _txtMessage.contentOffset = (CGPoint){.x =0, .y = -topCorrect/2};

    }
    
}

#pragma mark - Custom Deledate

#pragma mark - Event Response

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)updateMessageOffsetHeight:(CGFloat)offsetHeight{

    [_txtMessage mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(offsetHeight).priorityHigh();
    }];
    
    [_txtMessage setNeedsUpdateConstraints];
    [_txtMessage layoutIfNeeded];
}

#pragma mark - Getters And Setters

- (UIButton *)getButtonMicroPhone{

    if (!_btnMicroPhone) {
        
        _btnMicroPhone = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnMicroPhone setImage:[UIImage imageNamed:@"ic_voice_bar"] forState:UIControlStateNormal];
        [_btnMicroPhone setImage:[UIImage imageNamed:@"ic_voice_bar_pressed"] forState:UIControlStateHighlighted];
    }
    
    return _btnMicroPhone;
}


- (UIButton *)getButtonAdd{
    
    if (!_btnAdd) {
        
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAdd setImage:[UIImage imageNamed:@"ic_add_bar"] forState:UIControlStateNormal];
        [_btnAdd setImage:[UIImage imageNamed:@"ic_add_bar_pressed"] forState:UIControlStateHighlighted];
    }
    
    return _btnAdd;
}

- (UITextView *)getTextMessageView{

    if (!_txtMessage) {
        
        _txtMessage = [[UITextView alloc] init];
        _txtMessage.layer.cornerRadius = 6;
        _txtMessage.layer.masksToBounds = YES;
        _txtMessage.font = [UIFont systemFontOfSize:16];

        _txtMessage.scrollsToTop = NO;
        _txtMessage.userInteractionEnabled = YES;
        _txtMessage.contentMode = UIViewContentModeRedraw;
        _txtMessage.returnKeyType = UIReturnKeySend;
        
        [_txtMessage addObserver:self forKeyPath:@"contentSize"options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return _txtMessage;
}
@end
