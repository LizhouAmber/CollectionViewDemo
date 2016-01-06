//
//  MyCell.m
//  CollectionViewDemo
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 lizhou. All rights reserved.
//

#import "MyCell.h"

@interface MyCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation MyCell

- (void)awakeFromNib {
    // Initialization code
}
//-(instancetype)init
//{
//    if (self = [super init]) {
//        
//        self.backgroundColor = [UIColor yellowColor];
//    }
//    return self;
//}

-(NSArray *)dataArr
{
    if(_dataArr == nil ){
        _dataArr = @[[UIColor yellowColor],[UIColor blueColor],[UIColor greenColor],[UIColor redColor],[UIColor purpleColor]];
    }
    return _dataArr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        NSLog(@"%f",frame.size.width);
       
//        self.backgroundColor = [UIColor purpleColor];
        
//        self.dataArr = @[[UIColor yellowColor],[UIColor blueColor],[UIColor greenColor],[UIColor redColor],[UIColor purpleColor]];
    }
    return self;
}

-(void)setName:(NSInteger)name
{
    NSLog(@"%@",self.dataArr);
    
    NSInteger i = name %(self.dataArr.count);
    NSLog(@"NSInteger %ld",i);
  
    self.backgroundColor = (UIColor *)[self.dataArr objectAtIndex:i];
//    NSLog(@"%@",[self.dataArr objectAtIndex:name]);
    
    self.nameLabel.text = [NSString stringWithFormat:@"%ld",name];
}

@end
