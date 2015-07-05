//
//  UIViewController+KeyboardAnimation.m
//  CBChatMessage
//
//  Created by zhangyu on 15/7/4.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UIViewController+KeyboardAnimation.h"
#import <objc/runtime.h>

static void *UUAnimationsBlockAssociationKey           = &UUAnimationsBlockAssociationKey;
static void *UUBeforeAnimationsBlockAssociationKey     = &UUBeforeAnimationsBlockAssociationKey;
static void *UUAnimationsCompletionBlockAssociationKey = &UUAnimationsCompletionBlockAssociationKey;

@implementation UIViewController (KeyboardAnimation)

#pragma mark -- Public Methods

- (void)subscribeKeyboardWithAnimations:(UUAnimationsWithKeyboardBlock)animations
                             completion:(UUCompletionKeyboardAnimations)completion{

    
    [self subscribeKeyboardWithBeforeAnimations:nil animations:animations completion:completion];
}


- (void)subscribeKeyboardWithBeforeAnimations:(UUBeforeAnimationsWithKeyboardBlock)beforeAnimations
                                   animations:(UUAnimationsWithKeyboardBlock)animations
                                   completion:(UUCompletionKeyboardAnimations)completion{
    
    objc_setAssociatedObject(self, UUBeforeAnimationsBlockAssociationKey, beforeAnimations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, UUAnimationsBlockAssociationKey, animations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, UUAnimationsCompletionBlockAssociationKey, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillShowKeyboardNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillHideKeyboardNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}


- (void)unsubscribeKeyboard{

    objc_setAssociatedObject(self, UUAnimationsBlockAssociationKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, UUAnimationsCompletionBlockAssociationKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark -- Private Methods


- (void)handleWillShowKeyboardNotification:(NSNotification *)notification {
    
    [self keyboardWillShowHide:notification isShowing:YES];
}


- (void)handleWillHideKeyboardNotification:(NSNotification *)notification {
    
    [self keyboardWillShowHide:notification isShowing:NO];
}

- (void)keyboardWillShowHide:(NSNotification *)notification isShowing:(BOOL)isShowing {
    
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    UUAnimationsWithKeyboardBlock animationsBlock = objc_getAssociatedObject(self, UUAnimationsBlockAssociationKey);
    UUBeforeAnimationsWithKeyboardBlock beforeAnimationsBlock = objc_getAssociatedObject(self, UUBeforeAnimationsBlockAssociationKey);
    UUCompletionKeyboardAnimations completionBlock = objc_getAssociatedObject(self, UUAnimationsCompletionBlockAssociationKey);
    
    if (beforeAnimationsBlock) beforeAnimationsBlock(keyboardRect, duration, isShowing);

    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         [UIView setAnimationCurve:curve];
                         if (animationsBlock) animationsBlock(keyboardRect, duration, isShowing);
                         
                     }completion:completionBlock];
}


@end
