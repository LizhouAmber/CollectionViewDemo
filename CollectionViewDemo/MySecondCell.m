//
//  MySecondCell.m
//  CollectionViewDemo
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 lizhou. All rights reserved.
//

#import "MySecondCell.h"

@interface MySecondCell()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtu;
@end

@implementation MySecondCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(ItemModel *)model
{
    _model = model;

    self.topImageView.image = [UIImage imageNamed:model.itemImage];
    self.nameLabel.text = model.itemName;
    
    [self addLongPressGesture];
    self.deleteBtu.hidden = YES;
}

-(void)setIsAllowDelete:(BOOL)isAllowDelete
{
    _isAllowDelete = isAllowDelete;
    
}
- (void)addLongPressGesture
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(appearAnimation)];
    
    longPress.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(appearTheOutButton)];
    tap.delegate = self;
    
    [self addGestureRecognizer:longPress];
    [self addGestureRecognizer:tap];
}



-(void)appearAnimation
{
    [UIView animateKeyframesWithDuration:0.7 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        if (self.alpha == 1) {
//            self.transform = CGAffineTransformMakeScale(1.2, 1);
            self.center = CGPointMake(self.center.x-10, self.center.y-10);
            self.alpha = 0.9;
            
        }else{
//            self.transform = CGAffineTransformMakeScale(1, 1);
            self.center = CGPointMake(self.center.x+10, self.center.y+10);
            self.alpha = 1;
        }
         } completion:nil];
    //然后可以跟着走
    
    

}

-(void)appearTheOutButton
{
    //只有type为1的才能出现删除的情况.
    if(self.model.itemType == 1 && _isAllowDelete){
        //也得回调出delete按钮的现象,因为这样的话才能响应点击事件.
        
        if ([self.delegate respondsToSelector:@selector(appearDeleteBtu:andDeleteBtu:)]) {
            
            [self.delegate appearDeleteBtu:self andDeleteBtu:self.deleteBtu];
        }
        NSLog(@"delete appear");
    }//第二个界面是,allow = no且 self.itemtype = 0
    else if(self.model.itemType == 1 && _isAllowDelete == NO){
        if ([self.delegate respondsToSelector:@selector(backToForeViewControl:)]) {
            
            [self.delegate backToForeViewControl:self];
        }
    }
    else {
        //如果不是可以删除的,就直接回调,出现下一个界面.这个第一个界面的跳转,所以条件为 allow = yes;
        if ([self.delegate respondsToSelector:@selector(removeAnimationOfCell:)]) {
            
            [self.delegate removeAnimationOfCell:self];
        }
    }
   
    
   
}

@end
