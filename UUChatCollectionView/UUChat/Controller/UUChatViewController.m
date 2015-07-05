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

- (void)viewWillAppear:(BOOL)animated{

    [self.view layoutIfNeeded];
    [self.collectionView.collectionViewLayout invalidateLayout];
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
    
    self.navigationItem.title = @"Chat Message";
    [self.view addSubview:self.collectionView];
    
    [self createDataSoure];
}

- (void)updateConstraint{
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
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

- (void)createDataSoure{

    for (int i = 0; i < 20; i++) {
        
        UUChatMessage *message = [[UUChatMessage alloc] init];
        message.timestamp = @"20150705";
        message.userName = @"zhangyu";
        message.userAvatar = @"userAvatarIncoming";
        
        switch (i) {
            case 0:
                message.message = @"IPv4地址即将告罄 美国已摇号限购 仅非洲能按需申请";
                break;
            case 1:
                message.message = @"现在负责给美国，加拿大，北大西洋地区，和加勒比群岛区域的ARIN也宣称新IP申请将需要排队等候。只剩下非洲那边还能按需申请IPv4地址了";
                break;
            case 2:
                message.message = @"农产品O2O销售平台开通仪式现场 新华网四川频道7月5日电（刘晴 李杰）“从前吃崇州...";
                break;
            case 3:
                message.message = @"中新社北京7月5日电 (记者 彭大伟)“不好意思，我们这几天实在太忙了。”穿行在堆积如山、等待封装发出的包裹海洋中，郑志伟不时停...";
                break;
            case 4:
                message.message = @"秦楚网讯 特约记者 杨洪霞 通讯员 王文勤 报道： “看到佩戴党徽的党员干部为我们发展电子商务做了很多好事，我也希望自己成为一...";
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
        //        _collectionView.backgroundColor = COLOR_WITH_RGB(235,235,235,1);
        
        //        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCBWarningHeaderIdentifier];
        //
        //        [_collectionView registerClass:[CBWarningCollectionCell class] forCellWithReuseIdentifier:kCBWarningCollectionCell];
    }
    
    return _collectionView;
}

@end
