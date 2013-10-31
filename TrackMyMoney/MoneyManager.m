//
//  MoneyManager.m
//  TrackMyMoney
//
//  Created by wyp on 13-10-31.
//  Copyright (c) 2013年 he110world. All rights reserved.
//

#import "MoneyManager.h"
#import "Money.h"

@implementation MoneyManager


- (BOOL)add:(int32_t)index Receipt:(float)receipt Date:(NSDate *)date Pic:(NSString *)pic Address:(NSString *)address{
    Money *money = (Money *)[NSEntityDescription insertNewObjectForEntityForName:@"Money" inManagedObjectContext:self.managedObjectContext];
    
    [money setIndex:[NSNumber numberWithInt:index]];
    [money setDate:date];
    [money setReceipt:[NSNumber numberWithFloat:receipt]];
    [money setPic:pic];
    [money setAddress:address];
    
    
    NSError *error;
    BOOL isSaveSuccess = [self.managedObjectContext save:&error];
    /*
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        NSLog(@"Save successful!");
    }*/
    
    return isSaveSuccess;
}

- (NSMutableArray *)load:(NSPredicate *)predicate{
    NSMutableArray *moneyData;
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Money" inManagedObjectContext:self.managedObjectContext];
    //设置请求实体
    [request setEntity:entityDes];
    
    //筛选条件
    //NSPredicate *predicate;
    //predicate = [NSPredicate predicateWithFormat:@"name MATCHES %@",@"tugging"];
    
    [request setPredicate:predicate];
    
    //指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    //[sortDescriptions release];
    //[sortDescriptor release];
    
    NSError *error = nil;
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    moneyData = mutableFetchResult;
    
    NSLog(@"The count of entry:%i",[moneyData count]);
    
    for (Money *money in moneyData) {
        NSLog(@"Index:%@---Date:%@---Receipt:%@",money.index,money.date,money.receipt);
    }
    
    //[mutableFetchResult release];
    //[request release];
    return moneyData;
}

- (int)getCount:(id)sender{
    NSMutableArray *moneyData;
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entityDes = [NSEntityDescription entityForName:@"Money" inManagedObjectContext:self.managedObjectContext];
    //设置请求实体
    [request setEntity:entityDes];
    
    
    //指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError *error = nil;
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    moneyData = mutableFetchResult;
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
        return 0;
    }else{
        return moneyData.count;
    }
    
    
    //NSLog(@"The count of entry:%i",[moneyData count]);
    /*
    for (Money *money in moneyData) {
        NSLog(@"Index:%@---Date:%@---Receipt:%@",money.index,money.date,money.receipt);
    }
    */
    //[mutableFetchResult release];
    //[request release];
    
}


@end
