//
//  MoneyManager.h
//  TrackMyMoney
//
//  Created by wyp on 13-10-31.
//  Copyright (c) 2013年 he110world. All rights reserved.
//

#import "AppDelegate.h"

@interface MoneyManager : AppDelegate
- (BOOL)add:(int32_t)index Receipt:(float)receipt Date:(NSDate *)date Pic:(NSString *)pic Address:(NSString *)address;
//- (BOOL)remove:(id)sender;
//- (BOOL)edit:(id)sender;
- (NSMutableArray *)load:(NSPredicate *)predicate;
- (int)getCount:(id)sender;
@end
