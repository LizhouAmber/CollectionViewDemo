//
//  ItemModel.m
//  CollectionViewDemo
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 lizhou. All rights reserved.
//

#import "ItemModel.h"

/*
    在自己做的过程中,和原版不同的地方以及不理解的地方:
        1.在传递的数据中,为什么字典要设计4个属性,3个不就够了吗
        2.同时在设计model的时候,我考虑的是在该类中自定义3个属性,最好是另开一个model.所以原版的做法是什么??原因是?
 */

@implementation ItemModel

//我直接就传字典.但是这样的做法会让这个方法十分的单一.

+(NSMutableArray *)shareModelWithData
{
    
    NSArray *nameArray  =  [NSArray arrayWithObjects:@"收款",@"发卡",@"会员管理",@"账本",@"预约",@"反馈",@"小黑板",@"发优惠券",@"会员卡设置",@"发信息",@"商家二维码",@"商家信息",@"账号信息",@"",nil];
    NSArray *imageArray = [NSArray arrayWithObjects:@"home_icon_03.png",@"home_icon_05.png",@"home_icon_07.png",@"home_icon_14.png",@"home_icon_12.png",@"home_icon_13.png",@"home_icon_19.png",@"home_icon_20.png",@"home_icon_18.png",@"home_icon_25.png",@"home_icon_26.png",@"home_icon_24.png",@"home_icon_30.png",@"home_icon_46.png",nil];
    //考虑到点击的效果,是否在界面上:0表示在界面上;1表示不在界面上.然后直接用model保存在nsarray中,很显然数据的保存用数组的话更好
//    NSDictionary *allData = @{@"images":imageArray,@"name":nameArray};
    
    NSMutableArray *allArr = [NSMutableArray array];
    
    for (int i = 0; i <nameArray.count; i++) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:4];
        
        [tempDic setObject:nameArray[i] forKey:@"itemName"];
        [tempDic setObject:@0 forKey:@"itemType"];
        [tempDic setObject:imageArray[i] forKey:@"itemImage"];
        //第四个是顺序,我没有考虑到字典是乱序的.
        
        [tempDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"skipNum"];
        
        ItemModel *model = [ItemModel shareItemModelWithDic:tempDic];
        [allArr addObject:model];
        
    }

    
    return allArr;
}

//这是一开始的数据.
+(NSMutableArray *)shareModelWithUnselectedData
{
    NSArray *nameArray  =  [NSArray arrayWithObjects:@"会员关怀",@"会员流失",@"订单",@"高级设置",@"数据备份", nil];
    NSArray *imageArray = [NSArray arrayWithObjects:@"home_icon_31.png",@"home_icon_32.png",@"home_icon_36.png",@"home_icon_37.png",@"home_icon_38.png", nil];
    
    NSMutableArray *allArr = [NSMutableArray array];
    
    for (int i = 0; i <nameArray.count; i++) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:4];
        
        [tempDic setObject:nameArray[i] forKey:@"itemName"];
        [tempDic setObject:@1 forKey:@"itemType"];
        [tempDic setObject:imageArray[i] forKey:@"itemImage"];
        [tempDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"skipNum"];
        
        ItemModel *model = [ItemModel shareItemModelWithDic:tempDic];
        [allArr addObject:model];
    }
    
    return allArr;
}

+(ItemModel *)shareItemModelWithDic:(NSDictionary *)dic
{
    return [[ItemModel alloc]initWithDic:dic];
}
-(ItemModel *)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
