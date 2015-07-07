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

@interface UUChatToolBarView() < UUChatSmileViewDelegate >

@property (nonatomic, strong, getter = getSmileView) UUChatSmileView *smileView;

@property (nonatomic, strong, getter = getButtonMicroPhone) UIButton *btnMicroPhone;
@property (nonatomic, strong, getter = getButtonSend) UIButton *btnSend;
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
//    [self addSubview:self.btnSend];
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
    
//    [_btnSend mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.size.mas_equalTo(_btnMicroPhone);
//        make.right.equalTo(self).offset(-12);
//        make.top.equalTo(self).offset(12.5);
//    }];
}

- (void)dealloc{


}


#pragma mark - Custom Deledate

- (void)selectedSmileView:(NSString *)str isDelete:(BOOL)isDelete{
    
    NSString *chatText = _txtMessage.text;
    
    if (!isDelete && str.length > 0) {
        
        _txtMessage.text = [NSString stringWithFormat:@"%@%@",chatText,str];
        
    }else {
        
        if (chatText.length >= 2){
            
            NSString *subStr = [chatText substringFromIndex:chatText.length-2];
            if ([_smileView isSmileString:subStr]) {
                
                _txtMessage.text = [chatText substringToIndex:chatText.length-2];
                return;
            }
        }
        
        if (chatText.length > 0) {
            
            _txtMessage.text = [chatText substringToIndex:chatText.length-1];
        }
    }
}


#pragma mark - Event Response

- (void)onClickSmilies:(UIButton *)sender{
    
    if (![_txtMessage isFirstResponder]) [_txtMessage becomeFirstResponder];
    
    if ([_txtMessage.inputView isEqual:self.smileView]){
        
        _txtMessage.inputView = nil;
        [sender setImage:[UIImage imageNamed:@"ic_add_bar"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"ic_add_bar_pressed"] forState:UIControlStateHighlighted];
        
    }else{
        
        _txtMessage.inputView = self.smileView;
        [sender setImage:[UIImage imageNamed:@"ic_send"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"ic_send_pressed"] forState:UIControlStateHighlighted];
    }
    
    [_txtMessage reloadInputViews];
}


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


- (UIButton *)getButtonSend{
    
    if (!_btnSend) {
        
        _btnSend = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSend setImage:[UIImage imageNamed:@"ic_send"] forState:UIControlStateNormal];
        [_btnSend setImage:[UIImage imageNamed:@"ic_send_pressed"] forState:UIControlStateHighlighted];
    }
    
    return _btnSend;
}


- (UIButton *)getButtonAdd{
    
    if (!_btnAdd) {
        
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAdd setImage:[UIImage imageNamed:@"ic_add_bar"] forState:UIControlStateNormal];
        [_btnAdd setImage:[UIImage imageNamed:@"ic_add_bar_pressed"] forState:UIControlStateHighlighted];
        
        [_btnAdd addTarget:self action:@selector(onClickSmilies:) forControlEvents:UIControlEventTouchUpInside];
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
    }
    
    return _txtMessage;
}

- (UUChatSmileView *)getSmileView{
    
    if (!_smileView) {
        
        _smileView = [[UUChatSmileView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 216, ScreenWidth, 216)];
        _smileView.delegate = self;
    }
    
    return _smileView;
}
@end
