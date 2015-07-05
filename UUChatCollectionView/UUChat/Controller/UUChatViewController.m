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

@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation UUChatViewController

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
    
    self.navigationItem.title = @"Chat Message";
    [self.view addSubview:self.collectionView];
}

- (void)updateConstraint{
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - CollectionView DataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;//_messageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UUChatCollectionViewCellIncoming *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UUChatCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    
    //    [cell setContentWithObject:_dataArray[indexPath.row]];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
};

#pragma mark - UICollectionView Delegate FlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(ScreenWidth, 170);
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

#pragma mark - Getters And Setters

- (UUChatCollectionView *)getCollectionView{
    
    if (!_collectionView) {
        
        _messageArray = [NSMutableArray array];
        
        //        [self createDataSoure];
        
        UUChatCollectionViewFlowLayout *flowLayout= [[UUChatCollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UUChatCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //        _collectionView.backgroundColor = COLOR_WITH_RGB(235,235,235,1);
        
        //        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCBWarningHeaderIdentifier];
        //
        //        [_collectionView registerClass:[CBWarningCollectionCell class] forCellWithReuseIdentifier:kCBWarningCollectionCell];
    }
    
    return _collectionView;
}

@end
