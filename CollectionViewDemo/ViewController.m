//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 lizhou. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"


static  NSString * cellStr = @"MyCell";

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *myCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    
//    collectionViewLayout.minimumLineSpacing = 100;
//    collectionViewLayout.minimumInteritemSpacing = 100;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 137.5, 0, 137.5);
    
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 110) collectionViewLayout:collectionViewLayout];
    
    
//    UINib *myNib = [[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:self options:nil].lastObject;
    [collectionView registerNib:[UINib nibWithNibName:@"MyCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellStr];
    collectionView.backgroundColor = [UIColor yellowColor];
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    
//    [collectionView registerClass:[MyCell class] forCellWithReuseIdentifier:cellStr];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.myCollectionView = collectionView;
    
    [self.view addSubview:collectionView];
}

#pragma mark -------- UICollectionViewDelegate
//
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 30;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellStr forIndexPath:indexPath];
    cell.name = indexPath.section;
//    NSLog(@"%@",[cell class]);
//    if (cell ==nil) {
////        cell = [[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:self options:nil].lastObject;
//        
//        cell = [[MyCell alloc]initWithFrame:CGRectMake(indexPath.row*10, 0, 100, 200)];
//        cell.backgroundColor = [UIColor yellowColor];
//        NSLog(@"frame %f",cell.frame.size.width);
//    }
//    
    return cell;
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    if (section == 0) {
//        return UIEdgeInsetsZero ;
//    }
//    else{
//        return UIEdgeInsetsMake(0, 70, 0, 0);
//    }
//}

#pragma  mark ------- UICollectionViewDelegateFlowLayout

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 50, 2, 3);
//}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 200);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
