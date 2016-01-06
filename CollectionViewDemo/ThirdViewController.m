//
//  ThirdViewController.m
//  CollectionViewDemo
//
//  Created by qianfeng on 16/1/5.
//  Copyright (c) 2016年 lizhou. All rights reserved.
//

#import "ThirdViewController.h"

#import "MySecondCell.h"

static NSString * const cellStr = @"MySecondCell";

@interface ThirdViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MySecondCellProtocl>

@property (nonatomic, strong) NSMutableArray *allArray;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    self.allArray = [ItemModel shareModelWithUnselectedData];
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MySecondCell" bundle:nil] forCellWithReuseIdentifier:cellStr];
}

#pragma mark --------  UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"count :   %lu",(unsigned long)self.allArray.count);
    if (self.allArray.count == 0) {
        return 0;
    }
    if (self.allArray.count %3 == 0) {
        return self.allArray.count;
    }
    return (self.allArray.count+1)%3==0?self.allArray.count+1:self.allArray.count+2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MySecondCell *cell = [self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellStr forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MySecondCell" owner:nil options:nil].firstObject;
    }
    if (indexPath.row < self.allArray.count) {
        ItemModel *model = [self.allArray objectAtIndex:indexPath.row];
        NSLog(@"xxxxxxxx   itemName:%@",model.itemName);
        cell.model =model;
    }else{
        cell.model = nil;
    }
    cell.delegate = self;
    
    cell.isAllowDelete = NO;
    return cell;
}
-(void)backToForeViewControl:(MySecondCell *)cell
{
    //一旦选择了,里面的type变为0,而且从array中去掉,回调给前一个界面,并且退出该界面
    if (cell.model == nil) {
        return;
    }
    
    [self.allArray removeObject:cell.model];
    NSLog(@"self.allArray : %lu",(unsigned long)self.allArray.count);
    
    self.MyBackBlock(cell.model);

    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ----- UICollectionViewDelegateFlowLayout
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.3;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(375/3-0.3, 375/3);
}


-(void)viewWillAppear:(BOOL)animated
{
    for (int i =0; i< self.allArray.count; i++) {
        ItemModel *model = [self.allArray objectAtIndex:i];
        NSLog(@"%@",model.itemName);
    }
    [self.allArray addObjectsFromArray:self.reDeleteCellArr];
    //利用id再重新排列一下.
//    NSMutableArray *tempArr = [NSMutableArray array];
//    for (int j = 0; j< self.allArray.count; j++) {
//        for (int i =0; i<self.allArray.count; i++) {
//            ItemModel *model = [self.allArray objectAtIndex:i];
//            NSLog(@"%ld",(long)[model.skipNum integerValue]);
//            if (j == [model.skipNum integerValue]) {
//                [tempArr addObject:model];
//            }
//        }
//    }
//    self.allArray = tempArr;
    //按照顺序显示
//    if (self.reDeleteCellArr == nil || self.reDeleteCellArr.count == 0) {
//         [self.myCollectionView reloadData];
//        return;
//    }
//    NSMutableArray *tempArr = self.allArray;
//    for(int i = 0;i <self.reDeleteCellArr.count;i++){
//        ItemModel *foreModel = [self.reDeleteCellArr objectAtIndex:i];
//        for (int j = 1; j <self.allArray.count; i++) {
//            
//            ItemModel *backModel = [self.allArray objectAtIndex:j];
//            if ([backModel.skipNum integerValue] > [foreModel.skipNum integerValue]) {
//                [tempArr insertObject:foreModel atIndex:j];
//                break;
//            }
//        }
//    }
//
//    for (int i = 0; i < self.reDeleteCellArr.count; i++) {
//        for (int j = 0; j++; <#increment#>) {
//            <#statements#>
//        }
//    }
//    self.allArray = tempArr;
//    NSLog(@"count ::%lu",(unsigned long)self.reDeleteCellArr.count);
    
    [self.myCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
