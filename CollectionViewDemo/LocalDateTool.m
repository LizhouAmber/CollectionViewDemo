//
//  LocalDateTool.m
//  CollectionViewDemo
//
//  Created by qianfeng on 16/1/4.
//  Copyright (c) 2016年 lizhou. All rights reserved.
//

#import "LocalDateTool.h"


@implementation LocalDateTool

+(NSString *)standardLoaclDateOfWeek
{
    NSArray *dateArr = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    
    NSDate *now = [NSDate date];
    NSLog(@"%@",now);
    //由这种方法得到的星期会多1????
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateFormatter;
    
    dateFormatter = [calendar components:NSCalendarUnitWeekday fromDate:now];
    
    NSLog(@"week : %@",dateFormatter);
    
    NSLog(@"real : %ld",[dateFormatter weekday]);
    
    NSInteger numOfWeek = [dateFormatter weekday];
    NSLog(@"dataArr: %@",[dateArr objectAtIndex:(numOfWeek-1)]);
    
    return [dateArr objectAtIndex:(numOfWeek-1)];
}

+(NSString *)standardLoaclCurrentDays
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月DD日"];
    
    return [dateFormatter stringFromDate:now];
}

+(int)standardLoaclDateOfComp
{
    
    //计算下某一天和今天相差了多少天?
    //如果不用日历NSCalendar而是简单的NSDate
    
    NSArray *dayOfMonthF = @[@31,@28,@31,@30,@31,@30,@31,@30,@31,@30,@31,@30];//瑞年
    NSArray *dayOfMonthT = @[@31,@29,@31,@30,@31,@30,@31,@30,@31,@30,@31,@30];//普通的年份
    
    //纪念的旧日子
    NSString *oldStr = @"2014-01-05";
    
    //得到今天的日子
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *nowStr = [dateFormatter stringFromDate:now];
    //判断是不是一年?
    NSArray *oldArr = [oldStr componentsSeparatedByString:@"-"];
    NSArray *nowArr = [nowStr componentsSeparatedByString:@"-"];
    
    int startMonth = [oldArr[1] intValue];
    int endMonth = [nowArr[1] intValue];
    int countDays = 0;
    
    if ([oldArr[0] isEqualToString:nowArr[0]]) {
            //  是在一年
        //把旧日子后一个月到新月份的前一个月的月份想加,现在不判断是否为瑞年.
        
        for (int i = startMonth+1; i<endMonth; i++) {
            countDays += [dayOfMonthT[i] intValue];
        }
        //把相差的月份加完后,加当月中相差的天数,可以封装一个方法
        int daysInCurrentOldMonth = [dayOfMonthF[startMonth] intValue] -[oldArr[2] intValue];
        int daysInCurrentNowMonth = [nowArr[2] intValue];
        
        
        countDays += daysInCurrentNowMonth + daysInCurrentOldMonth;
    }else{
        //不是同一年的话,旧年份:从当月到底;新年份:从头到这个月
//        int numOfOldMonths = 12 - startMonth
        
        for (int i = startMonth +1; i < dayOfMonthF.count; i++) {
            countDays += [dayOfMonthF[i] intValue];
        }
        for (int i = 0; i< endMonth; i++) {
            countDays += [dayOfMonthF[i] intValue];
        }
        
        int daysInCurrentOldMonth = [dayOfMonthF[startMonth] intValue] -[oldArr[2] intValue];
        int daysInCurrentNowMonth = [nowArr[2] intValue];
        
        countDays += daysInCurrentNowMonth + daysInCurrentOldMonth;
    }
    
    NSLog(@"comp : %d",countDays);
    
    
    return countDays;
}



@end
