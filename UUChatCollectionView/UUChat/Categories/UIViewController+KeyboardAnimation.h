//
//  UIViewController+KeyboardAnimation.h
//  CBChatMessage
//
//  Created by zhangyu on 15/7/4.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KeyboardAnimation)

typedef void(^UUCompletionKeyboardAnimations)(BOOL finished);

typedef void(^UUAnimationsWithKeyboardBlock)(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing);

typedef void(^UUBeforeAnimationsWithKeyboardBlock)(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing);

- (void)subscribeKeyboardWithAnimations:(UUAnimationsWithKeyboardBlock)animations
                                completion:(UUCompletionKeyboardAnimations)completion;


- (void)subscribeKeyboardWithBeforeAnimations:(UUBeforeAnimationsWithKeyboardBlock)beforeAnimations
                                      animations:(UUAnimationsWithKeyboardBlock)animations
                                      completion:(UUCompletionKeyboardAnimations)completion;


- (void)unsubscribeKeyboard;

@end
