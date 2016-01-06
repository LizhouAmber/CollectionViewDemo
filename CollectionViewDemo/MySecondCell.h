//
//  MySecondCell.h
//  CollectionViewDemo
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 lizhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemModel.h"

@class MySecondCell;

@protocol MySecondCellProtocl <NSObject>

//-(void)theDeleteTagOfCell:(NSInteger)

@optional

-(void)removeAnimationOfCell:(MySecondCell *)cell;

-(void)appearDeleteBtu:(MySecondCell *)cell andDeleteBtu:(UIButton *)but;

-(void)backToForeViewControl:(MySecondCell *)cell;

@end

@interface MySecondCell : UICollectionViewCell

@property (nonatomic, strong) ItemModel *model;

@property (nonatomic, strong) id<MySecondCellProtocl>delegate;

@property (nonatomic, assign) BOOL isAllowDelete;

@end
