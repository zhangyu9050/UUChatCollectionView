//
//  UUChatSmileView.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/8.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatSmileView.h"
#import "Chat-Import.h"
#import "Chat-Macros.h"

#import "Emoji.h"


@interface UUChatSmileView()

@property (nonatomic, strong) NSArray *emojiArray;

@end

@implementation UUChatSmileView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        [self configUI];
        [self updateConstraint];
    }
    return self;
}

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
    
    _emojiArray = [Emoji allEmoji];
    
    [self loadFacialView:2 size:CGSizeZero];
}

- (void)updateConstraint{
    
   
}

- (void)dealloc{
    
    
}


#pragma mark - Custom Deledate

-(void)selectedFacialView:(NSString*)str{
    if (_delegate) {
        [_delegate selectedSmileView:str isDelete:NO];
    }
}

-(void)deleteSelected:(NSString *)str{
    if (_delegate) {
        [_delegate selectedSmileView:str isDelete:YES];
    }
}

#pragma mark - Event Response

-(void)selected:(UIButton*)bt
{
    if (bt.tag == 10000 && _delegate) {
        [self deleteSelected:nil];
    }else{
        NSString *str = [_emojiArray objectAtIndex:bt.tag];

        [self selectedFacialView:str];
    }
}

#pragma mark - Public Methods

- (BOOL)isSmileString:(NSString *)string{
    
    if ([_emojiArray containsObject:string]) {
        
        return YES;
    }
    
    return NO;
}


#pragma mark - Private Methods

//给faces设置位置
-(void)loadFacialView:(int)page size:(CGSize)size{
    
    int maxRow = 5;
    int maxCol = 8;
    
    CGFloat itemWidth = self.frame.size.width / maxCol;
    CGFloat itemHeight = self.frame.size.height / maxRow;
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setBackgroundColor:[UIColor clearColor]];
    [deleteButton setFrame:CGRectMake((maxCol - 1) * itemWidth, (maxRow - 1) * itemHeight, itemWidth, itemHeight)];
    [deleteButton setImage:[UIImage imageNamed:@"ic_delete"] forState:UIControlStateNormal];
    [deleteButton setImage:[UIImage imageNamed:@"ic_delete_pressed"] forState:UIControlStateHighlighted];
    deleteButton.tag = 10000;
    [deleteButton addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    
    for (int row = 0; row < maxRow; row++) {
        
        for (int col = 0; col < maxCol; col++) {
            
            int index = row * maxCol + col;
            
            if (index < [_emojiArray count]) {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setBackgroundColor:[UIColor clearColor]];
                [button setFrame:CGRectMake(col * itemWidth, row * itemHeight, itemWidth, itemHeight)];
                [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
                [button setTitle: [_emojiArray objectAtIndex:(row * maxCol + col)] forState:UIControlStateNormal];
                button.tag = row * maxCol + col;
                [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
            }
            else{
                break;
            }
        }
    }
}


#pragma mark - Getters And Setters


@end
