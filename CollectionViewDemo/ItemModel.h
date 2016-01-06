//
//  ItemModel.h
//  CollectionViewDemo
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 lizhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, assign) NSInteger itemType;
@property (nonatomic, strong) NSString *itemImage;
@property (nonatomic, strong) NSString *skipNum;


+(NSMutableArray *)shareModelWithData;
+(NSMutableArray *)shareModelWithUnselectedData;


@end
