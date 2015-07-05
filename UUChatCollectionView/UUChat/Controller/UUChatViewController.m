//
//  UUChatViewController.m
//  UUChatCollectionView
//
//  Created by zhangyu on 15/7/5.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUChatViewController.h"
#import "Chat-Import.h"
#import "Chat-Macros.h"

@interface UUChatViewController() < UICollectionViewDataSource,
                                    UICollectionViewDelegate,
                                    UICollectionViewDelegateFlowLayout >


@property (nonatomic, strong, getter = getCollectionView) UUChatCollectionView *collectionView;
@property (nonatomic, strong, getter = getToolBarView) UUChatToolBarView *toolbarView;

@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation UUChatViewController

- (void)viewWillAppear:(BOOL)animated {

    
    [self subscribeToKeyboard];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToBottomAnimated:NO];
//        [self.collectionView.collectionViewLayout invalidateLayoutWithContext:[UUChatCollectionViewFlowLayoutInvalidationContext context]];
    });

}

- (void)viewWillDisappear:(BOOL)animated {

    [self unsubscribeKeyboard];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configUI];
    [self updateConstraint];
    [self createDataSoure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - life cycle

- (void)configUI{
    
    self.navigationItem.title = @"Chat Message";
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.toolbarView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"1"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(receiveMessagePressed:)];


}

- (void)receiveMessagePressed:(id)sender{

//    [self scrollToBottomAnimated:NO];
    
//    [_collectionView setNeedsUpdateConstraints];
//    [_collectionView updateConstraintsIfNeeded];
//    
//    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
//        
//        
//        make.top.equalTo(self.view).offset(-256);
//    }];
    
    CGRect frame = _collectionView.frame;
    frame.origin.y = -256;
    [UIView animateWithDuration:10 animations:^{
       
        _collectionView.frame = frame;
//        [_collectionView layoutIfNeeded];
    }];

}

- (void)updateConstraint{
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.height.mas_equalTo(ScreenHeight -64 -50);
        make.left.and.right.and.top.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-50);
        make.bottom.equalTo(_toolbarView.mas_top);
    }];
    
    [_toolbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(@50);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
}

#pragma mark - CollectionView DataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _messageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UUChatCollectionViewCell *cell;
    if (indexPath.row % 2 == 0) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UUChatCollectionViewCellOutgoing cellReuseIdentifier] forIndexPath:indexPath];
    }else{
    
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UUChatCollectionViewCellIncoming cellReuseIdentifier] forIndexPath:indexPath];
    }
//    
//    UUChatCollectionViewCellIncoming *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UUChatCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    
    [cell setContentWithObject:_messageArray[indexPath.row]];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
};

#pragma mark - UICollectionView Delegate FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UUChatCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    return CGSizeMake(ScreenWidth, 200);
    return [collectionViewLayout sizeForItemAtIndexPath:indexPath message:_messageArray[indexPath.row]];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

#pragma mark - Custom Deledate

#pragma mark - Event Response

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)scrollToBottomAnimated:(BOOL)animated
{
    if ([_collectionView numberOfSections] == 0) return;
    
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    
    if (items == 0) return;
    
    CGFloat collectionViewContentHeight = [_collectionView.collectionViewLayout collectionViewContentSize].height;
    BOOL isContentTooSmall = (collectionViewContentHeight < CGRectGetHeight(_collectionView.bounds));
    
    if (isContentTooSmall) {

        [_collectionView scrollRectToVisible:CGRectMake(0.0, collectionViewContentHeight - 1.0f, 1.0f, 1.0f)
                                        animated:animated];
        return;
    }

    NSUInteger finalRow = MAX(0, [_collectionView numberOfItemsInSection:0] - 1);
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathForItem:finalRow inSection:0];

    [_collectionView scrollToItemAtIndexPath:finalIndexPath
                                atScrollPosition:UICollectionViewScrollPositionBottom
                                        animated:animated];
}

- (void)subscribeToKeyboard {
    
    __weak UUChatViewController *weakSelf = self;
    [self subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {

        if (CGRectIsNull(keyboardRect)) return;
        
        
        __block CGFloat offsetHeight = 0;
        offsetHeight = isShowing ? -CGRectGetHeight(keyboardRect) : 0;
        
        [weakSelf scrollToBottomAnimated:NO];
        [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.view).offset(offsetHeight);
        }];
        
        [_toolbarView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.view).offset(offsetHeight);
        }];
        
//        CGRect frame = _collectionView.frame;
//        frame.origin.y = offsetHeight -50;
//        _collectionView.frame = frame;
        
        [_collectionView setNeedsUpdateConstraints];
        [_collectionView updateConstraintsIfNeeded];

//        [UIView animateWithDuration:duration animations:^{
        
            [_collectionView layoutIfNeeded];
            [_toolbarView layoutIfNeeded];
//        }];
        
    } completion:nil];
}


- (void)createDataSoure{

    for (int i = 0; i < 6; i++) {
        
        UUChatMessage *message = [[UUChatMessage alloc] init];
        message.timestamp = @"2015-09";
        message.userName = @"zhangyu";
        message.userAvatar = @"userAvatarIncoming";
        
        switch (i) {
            case 0:
                message.message = @"IPv4地址即将告罄 美国已摇号限购 仅非洲能按需申请";
                break;
            case 1:
                message.message = @"现在负责给美国，加拿大，北大西洋地区";
                break;
            case 2:
                message.message = @"农产品O2O销售平台开通仪式现场";
                break;
            case 3:
                message.message = @"中新社北京7月5日电 (记者 彭大伟)“不好意思，我们这几天实在太忙了。";
                break;
            case 4:
                message.message = @"秦楚网讯 特约记者 杨洪霞 通讯员 王文勤 报道";
                break;
            case 5:
                message.message = @"中新网7月4日电 近年来";
                break;
            case 6:
                message.message = @"如何看小米最新公布的3470万台销量";
                break;
            case 7:
                message.message = @"However, when we rotate from portrait to landscape we get the following complaint";
                break;
            case 8:
                message.message = @"However, when we rotate from portrait to landscape we get the following complaint";
                break;
            case 9:
                message.message = @"However, when we rotate from portrait to landscape we get the following complaint";
                break;
                
            default:
                message.message = @"However, when we rotate from portrait to landscape we get the following complaint";
                break;
        }
        
        [_messageArray addObject:message];
    }
    
    [_collectionView reloadData];
}

#pragma mark - Getters And Setters

- (UUChatCollectionView *)getCollectionView{
    
    if (!_collectionView) {
        
        _messageArray = [NSMutableArray array];
        
        UUChatCollectionViewFlowLayout *flowLayout= [[UUChatCollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UUChatCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
}

- (UUChatToolBarView *)getToolBarView{

    if (!_toolbarView) {
        
        _toolbarView = [[UUChatToolBarView alloc] init];
    }
    
    return _toolbarView;
}

@end
