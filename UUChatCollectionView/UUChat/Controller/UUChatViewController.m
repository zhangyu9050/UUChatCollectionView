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

@interface UUChatViewController() < UUChatCollectionViewDataSource,
                                    UICollectionViewDelegate,
                                    UICollectionViewDelegateFlowLayout >


@property (nonatomic, strong, getter = getCollectionView) UUChatCollectionView *collectionView;
@property (nonatomic, strong, getter = getToolBarView) UUChatToolBarView *toolbarView;

@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation UUChatViewController

- (void)viewWillAppear:(BOOL)animated {

    
    [self subscribeToKeyboard];
//    [self.view layoutIfNeeded];
//    [self.collectionView.collectionViewLayout invalidateLayout];
    
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
//    [self createDataSoure];
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Message"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(receiveMessagePressed:)];


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

- (UUChatMessage *)collectionView:(UUChatCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath{

    return _messageArray[indexPath.row];
}


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

    [cell setContentWithObject:_messageArray[indexPath.row]];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
};

#pragma mark - UICollectionView Delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    //  disable menu for media messages
//    id<JSQMessageData> messageItem = [collectionView.dataSource collectionView:collectionView messageDataForItemAtIndexPath:indexPath];
//    if ([messageItem isMediaMessage]) {
//        return NO;
//    }
//    
//    self.selectedIndexPathForMenu = indexPath;
//    
//    //  textviews are selectable to allow data detectors
//    //  however, this allows the 'copy, define, select' UIMenuController to show
//    //  which conflicts with the collection view's UIMenuController
//    //  temporarily disable 'selectable' to prevent this issue
//    UUChatCollectionViewCell *selectedCell = (UUChatCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    selectedCell.textView.selectable = NO;
    
    return YES;
}


#pragma mark - UICollectionView Delegate FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UUChatCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    return CGSizeMake(ScreenWidth -20, 200);
    return [collectionViewLayout sizeForItemAtIndexPath:indexPath];
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

- (void)receiveMessagePressed:(id)sender{

    UUChatMessage *model = [[UUChatMessage alloc] init];
    model.timestamp = [self sendTimeString];
    model.userName = @"zhang";
    model.userAvatar = @"userAvatarIncoming";
    model.message = @"IPv4地址即将告罄 美国已摇号限购 仅非洲能按需申请";
    
    [_messageArray addObject:model];
    
    [self finishSendingMessage];
}

#pragma mark - Public Methods

#pragma mark - Private Methods

- (NSString *)sendTimeString{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void)finishSendingMessage{
    
    [self finishSendingMessageAnimated:YES];
}

- (void)finishSendingMessageAnimated:(BOOL)animated {
    
//    UITextView *textView = self.inputToolbar.contentView.textView;
//    textView.text = nil;
//    [textView.undoManager removeAllActions];
//    
//    [self.inputToolbar toggleSendButtonEnabled];
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:textView];
//    
//    [self.collectionView.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
    [_collectionView reloadData];
    
    [self scrollToBottomAnimated:animated];
}


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
        
        CGFloat offsetHeight = isShowing ? -CGRectGetHeight(keyboardRect) : 0;
        
        if (isShowing) [weakSelf scrollToBottomAnimated:NO];
        [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.view).offset(offsetHeight);
        }];
        
        [_toolbarView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.view).offset(offsetHeight);
        }];
        
        [_collectionView layoutIfNeeded];
        [_toolbarView layoutIfNeeded];
        [self.view layoutIfNeeded];
        
    } completion:nil];
}


- (void)createDataSoure{

    for (int i = 0; i < 1; i++) {
        
        UUChatMessage *message = [[UUChatMessage alloc] init];
        message.timestamp = [self sendTimeString];
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
    
//    [_collectionView reloadData];
}

#pragma mark - Getters And Setters

- (UUChatCollectionView *)getCollectionView{
    
    if (!_collectionView) {
        
        _messageArray = [[NSMutableArray alloc] init];
        
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
