//
//  SecondViewController.m
//  CollectionViewDemo
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 lizhou. All rights reserved.
//

#import "SecondViewController.h"
#import "LocalDateTool.h"
#import "ItemModel.h"
#import "MySecondCell.h"
#import "ThirdViewController.h"

static NSString  * const cellStr = @"MySecondCell";

@interface SecondViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ThirdViewControllerProtocol,MySecondCellProtocl>
{
    NSArray *_dateArr;
    NSArray *_nameArr;
    NSArray *_imageArr;
    
    NSInteger _selectedTag;
    
    MySecondCell *_foreCell;
    UIButton *_foreBtu;
    MySecondCell *_currentCell;
    
    
}
//@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic, strong) NSMutableArray *selectedArr;

@property (nonatomic, strong) ThirdViewController *third ;

//再次删除的cell存放的array;

@property (nonatomic, strong) NSMutableArray *reDeleteCellArr;


@end

@implementation SecondViewController

-(ThirdViewController *)third
{
    if (_third == nil) {
        
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        _third = [main instantiateViewControllerWithIdentifier:@"thirdViewController"];
    }
    return _third;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.reDeleteCellArr = [NSMutableArray array];
    [self setDateInfo];

    
     NSString *dayOfWeek = [LocalDateTool standardLoaclDateOfWeek];
    
    NSString *currentDay = [LocalDateTool standardLoaclCurrentDays];

    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",currentDay,dayOfWeek];
//
//    [LocalDateTool standardLoaclDateOfComp];
    
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MySecondCell" bundle:nil] forCellWithReuseIdentifier:cellStr];
    

}

- (void)setDateInfo
{
    self.selectedArr = [ItemModel shareModelWithData];
    NSLog(@"%@",self.selectedArr);
    [self.myCollectionView reloadData];
}

//#warning mess "回调的delegate函数没有调用"
/**
                       注意
 **/
-(void)returnSelectedItemModel:(ItemModel *)model
{
    [self.selectedArr addObject:model];
    [self.myCollectionView reloadData];
}

#pragma mark --------- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.selectedArr.count/9+1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MySecondCell *cell = [self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellStr forIndexPath:indexPath];
    cell.tag = indexPath.section *9+indexPath.row +100;
    if (indexPath.section == 0) {
        ItemModel *model = [self.selectedArr objectAtIndex:indexPath.row];
        cell.model = model;
        
         return cell;
    }else{
       
        if (indexPath.row+9 < self.selectedArr.count) {
             ItemModel *model = [self.selectedArr objectAtIndex:indexPath.row+9];
            cell.model = model;
        
            
        }else {
            cell.model = nil;
        }
        cell.isAllowDelete = YES;
        cell.delegate = self;
        
        return cell;
    }
   
    
   
}

#pragma mark -----------cell delegate
-(void)appearDeleteBtu:(MySecondCell *)cell andDeleteBtu:(UIButton *)but
{
    if (_foreCell != cell) {
        _foreBtu.hidden = YES;
        _foreBtu = but;
        _foreCell = cell;
        _foreBtu.hidden = NO;
    }

    [but addTarget:self action:@selector(deleteBtuPressed) forControlEvents:UIControlEventTouchUpInside];
}
-(void)deleteBtuPressed
{
    //一旦点击删除的按钮,就直接返回unselected的数值中,从本数值中去除.
    [self.selectedArr removeObject:_foreCell.model];
    [self.reDeleteCellArr addObject:_foreCell.model];
    
    [self.myCollectionView reloadData];
    
    NSLog(@"xxxxxx bibibibib");
}

-(void)removeAnimationOfCell:(MySecondCell *)cell
{

    NSUInteger count = self.selectedArr.count-1;
    
    __weak typeof(self) lizhou=self;
    [self.third setMyBackBlock:^(ItemModel *model) {
        [lizhou.selectedArr insertObject:model atIndex:count];
        for (int i=0 ; i<lizhou.selectedArr.count; i++) {
            ItemModel *model = lizhou.selectedArr[i];
            NSLog(@"%@",model.itemName);
        }
        [lizhou.myCollectionView reloadData];
    }];
    self.third.reDeleteCellArr = self.reDeleteCellArr;
    
    [self.navigationController pushViewController:self.third animated:YES];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    }
    if ((self.selectedArr.count-9) %3 ==0 ) {
        NSLog(@"self.selectedArr.count-9) ::%lu",(self.selectedArr.count-9));
        return self.selectedArr.count-9;
    }
    return (self.selectedArr.count -9+1)%3 == 0 ? self.selectedArr.count -9+1:self.selectedArr.count -9+2;

}
#pragma mark --------- UICollectionViewDelegateFlowLayout

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
    return CGSizeMake(375/3-0.3, 375/3+10);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsZero;
    }else{
        return UIEdgeInsetsMake(30, 0, 30, 0);
    
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //这是选择的cell,对cell进行一定的操作.
//    MySecondCell *cell = (MySecondCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    
//    
//    NSInteger currentTag = indexPath.section*9+indexPath.row+100;
//    if (_selectedTag != currentTag) {
//        //如果点击的是另一个的话,先把所有的东西的动画取消,再在点击的那个上面设置点击的事件.
//        
//        //1.先结束上一个cell的动画效果
//        [self removeBeforeSelectedTag:_selectedTag];
//        _selectedTag = currentTag;
//        [self addNewSelectedTag:_selectedTag];
//        
//    }

    
   }


-(void)addNewSelectedTag:(NSInteger)addTag
{
//    [UIView animateWithDuration:0.3 animations:^{
//        self.deleteBtu.hidden = NO;
//    }];
//    [UIView animateKeyframesWithDuration:0.7 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
//        
//        if (self.alpha == 1) {
//            self.alpha =0.9;
//            
//            self.transform = CGAffineTransformMakeScale(0.99, 0.99);
//        }else{
//            self.alpha = 1;
//            self.transform = CGAffineTransformMakeScale(1, 1);
//        }
//    } completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
