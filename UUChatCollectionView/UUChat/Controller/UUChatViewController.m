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
                                    UICollectionViewDelegateFlowLayout,
                                    UITextViewDelegate >


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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - life cycle

- (void)configUI{
    
    if (OSVersionIsAtLeastiOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    self.navigationItem.title = @"Chat Message";
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.toolbarView];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Message"
//                                                                              style:UIBarButtonItemStyleBordered
//                                                                             target:self
//                                                                             action:@selector(receiveMessagePressed:)];


}

- (void)updateConstraint{
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_lessThanOrEqualTo(ScreenHeight -50 -64).priorityHigh();
        make.left.and.right.and.top.equalTo(self.view);
        make.bottom.equalTo(_toolbarView.mas_top);
    }];
    
    [_toolbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.height.mas_equalTo(@50);
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

    [cell setContentWithObject:_messageArray[indexPath.row] indexPath:indexPath.row];
    
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

#pragma mark - UITextView Delegate

- (void)textViewDidChange:(UITextView *)textView{

    [self scrollToBottomAnimated:NO];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [self sendMessageWithContent:textView.text];
        textView.text = @"";
        
        return NO;
    }

    return YES;
}

#pragma mark - Custom Deledate

#pragma mark - Event Response

#pragma mark - Public Methods

#pragma mark - Private Methods

- (void)sendMessageWithContent:(NSString *)message{

    if (message.length == 0) return;

    [_messageArray addObject:[[UUChatMessage alloc] initWithSendMessage:message]];
    
    [self finishSendingMessage];
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
    CGSize finalCellSize = [self.collectionView.collectionViewLayout sizeForItemAtIndexPath:finalIndexPath];
    
    CGFloat maxHeightForVisibleMessage = CGRectGetHeight(_collectionView.bounds) - _collectionView.contentInset.top - CGRectGetHeight(_toolbarView.bounds);
    
    UICollectionViewScrollPosition scrollPosition = (finalCellSize.height > maxHeightForVisibleMessage) ? UICollectionViewScrollPositionBottom : UICollectionViewScrollPositionTop;


    [_collectionView scrollToItemAtIndexPath:finalIndexPath
                                atScrollPosition:scrollPosition
                                        animated:animated];
}

- (void)subscribeToKeyboard {
    
    __weak UUChatViewController *weakSelf = self;
    [self subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {

        if (CGRectIsNull(keyboardRect)) return;
        
        CGFloat offsetHeight = isShowing ? -CGRectGetHeight(keyboardRect) : 0;
        
        if (isShowing) [weakSelf scrollToBottomAnimated:YES];
        
        if (_collectionView.contentSize.height > CGRectGetHeight(_collectionView.frame)) {

//            [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
//                
//                make.bottom.equalTo(self.view).offset(offsetHeight);
//            }];

        }
        
        [_toolbarView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.view).offset(offsetHeight);
        }];
        
        [_collectionView layoutIfNeeded];
        [_toolbarView layoutIfNeeded];
        [self.view layoutIfNeeded];
        
    } completion:nil];
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
        _toolbarView.txtMessage.delegate = self;
    }
    
    return _toolbarView;
}

@end
