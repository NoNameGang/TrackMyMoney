//
//  MonthViewController.h
//  Accounting
//
//  Created by wyp on 13-10-29.
//  Copyright (c) 2013年 ohhnoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>{
    //CFGregorianDate currentMonthDate;
    CFGregorianDate selectMonthDate;
    CFAbsoluteTime        currentTime;
    NSString *selectYear;
    NSString *selectMonth;
}

//@property CFGregorianDate currentMonthDate;
@property CFGregorianDate selectMonthDate;
@property CFAbsoluteTime  currentTime;
@property NSString *selectYear;
@property NSString *selectMonth;

-(int)getDayCountOfaMonth:(CFGregorianDate)date;
-(int)getMonthWeekday:(CFGregorianDate)date;
//-(int)getDayFlag:(int)day;

@end
