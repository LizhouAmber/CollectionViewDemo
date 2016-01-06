//
//  ThirdViewController.h
//  CollectionViewDemo
//
//  Created by qianfeng on 16/1/5.
//  Copyright (c) 2016年 lizhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ItemModel.h"

@protocol ThirdViewControllerProtocol <NSObject>


-(void)returnSelectedItemModel:(ItemModel *)model;

@end

@interface ThirdViewController : UIViewController


@property (nonatomic, strong) void (^MyBackBlock)(ItemModel *model);

@property (nonatomic, strong) NSArray *reDeleteCellArr;

-(void)setMyBackBlock:(void (^)(ItemModel *))MyBackBlock;


@property (nonatomic, strong) id<ThirdViewControllerProtocol>delegate;

@end
