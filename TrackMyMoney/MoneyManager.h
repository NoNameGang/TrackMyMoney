//
//  MoneyManager.h
//  TrackMyMoney
//
//  Created by wyp on 13-10-31.
//  Copyright (c) 2013年 he110world. All rights reserved.
//

#import "AppDelegate.h"


@interface MoneyManager : NSObject

//数据模型对象
@property(strong,nonatomic) NSManagedObjectModel *managedObjectModel;
//上下文对象
@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;
//持久性存储区
@property(strong,nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//初始化Core Data使用的数据库
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

//managedObjectModel的初始化赋值函数
-(NSManagedObjectModel *)managedObjectModel;

//managedObjectContext的初始化赋值函数
-(NSManagedObjectContext *)managedObjectContext;

- (BOOL)add:(float)receipt Pic:(NSString *)pic;
//- (BOOL)remove:(id)sender;
//- (BOOL)edit:(id)sender;
- (NSMutableArray *)load:(NSPredicate *)predicate;
- (int)getCount;

@end
