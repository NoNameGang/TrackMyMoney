//
//  Money.h
//  TrackMyMoney
//
//  Created by wyp on 13-10-31.
//  Copyright (c) 2013年 he110world. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Money : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * receipt;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * pic;

@end
