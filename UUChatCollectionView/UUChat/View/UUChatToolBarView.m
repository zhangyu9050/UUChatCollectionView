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

@interface UUChatToolBarView() < UITextViewDelegate >

@property (nonatomic, strong, getter = getButtonMicroPhone) UIButton *btnMicroPhone;
@property (nonatomic, strong, getter = getTextMessageView) UITextView *txtMessage;
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

#pragma mark - UITextView Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
//    self.inputPlaceholder.hidden = text.length || range.location > 0;
    
    return YES;
}

#pragma mark - Custom Deledate

#pragma mark - Event Response

#pragma mark - Public Methods

#pragma mark - Private Methods

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
        _txtMessage.delegate = self;
        _txtMessage.layer.cornerRadius = 6;
        _txtMessage.layer.masksToBounds = YES;
        _txtMessage.font = [UIFont systemFontOfSize:16];
    }
    
    return _txtMessage;
}
@end
