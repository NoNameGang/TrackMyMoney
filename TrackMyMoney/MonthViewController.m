//
//  MonthViewController.m
//  Accounting
//
//  Created by wyp on 13-10-29.
//  Copyright (c) 2013年 ohhnoz. All rights reserved.
//

#import "MonthViewController.h"

@interface MonthViewController (){
    NSArray *years;
    NSArray *dates;
    NSArray *months;
}

@end

@implementation MonthViewController

//@synthesize currentMonthDate;
@synthesize selectMonthDate;
@synthesize currentTime;
@synthesize selectYear;
@synthesize selectMonth;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    currentTime=CFAbsoluteTimeGetCurrent();
    CFTimeZoneRef timeZoneRef = CFTimeZoneCopyDefault();
    selectMonthDate=CFAbsoluteTimeGetGregorianDate(currentTime,timeZoneRef);
    selectMonthDate.day=1;
    selectMonthDate.year = [selectYear intValue];
    selectMonthDate.month = [selectMonth intValue];
    
    //NSLog(@"weekday:%d",[self getMonthWeekday:currentMonthDate]);
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Accounting" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    dates = [dict objectForKey:@"Date"];
    NSDate *firstDate = [dates objectAtIndex:0];
    
    CFDateRef firstDateRef = CFBridgingRetain(firstDate);
    CFAbsoluteTime firstTime = CFDateGetAbsoluteTime(firstDateRef);
    CFGregorianDate firstDateCf = CFAbsoluteTimeGetGregorianDate(firstTime,timeZoneRef);
    firstDateCf.month = 1;
    
    CFAbsoluteTime thisTime =  CFAbsoluteTimeGetCurrent();
    CFGregorianDate thisDateCf = CFAbsoluteTimeGetGregorianDate(thisTime,timeZoneRef);
    thisDateCf.month = 12;
    
    years = [[NSArray alloc] init];
    months = [[NSArray alloc] init];
    
    for (int cnt = (int)firstDateCf.year; cnt <= (int)thisDateCf.year; cnt++) {
        for (int m = 1; m <= 12; m++) {
            months = [months arrayByAddingObject:[NSString stringWithFormat:@"%d", m]];
            years = [years arrayByAddingObject:[NSString stringWithFormat:@"%d", cnt]];
        }
        
    }
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:((int)selectMonthDate.year - (int)firstDateCf.year) * 12 + selectMonthDate.month - 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    if(timeZoneRef){
        CFRelease(timeZoneRef);
    }

    if(firstDateRef){
        CFRelease(firstDateRef);
    }

    //NSLog(@"123:%d.%d",[selectYear intValue],[selectMonth intValue]);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(int)getMonthWeekday:(CFGregorianDate)date
{
    CFTimeZoneRef tz = CFTimeZoneCopyDefault();
    CFGregorianDate month_date;
    month_date.year=date.year;
    month_date.month=date.month;
    month_date.day=1;
    month_date.hour=0;
    month_date.minute=0;
    month_date.second=1;
    int day = (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date,tz),tz);
    
    if(tz){
        CFRelease(tz);
    }
    
    return day;
}

-(int)getDayCountOfaMonth:(CFGregorianDate)date{
    switch (date.month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
            
        case 2:
            if(date.year%4==0 && date.year%100!=0)
                return 29;
            else
                return 28;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        default:
            return 31;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [years count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MonthCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }else{
        NSArray*subviews = [[NSArray alloc]initWithArray:cell.contentView.subviews];
        for (UIView *subview in subviews) {
                [subview removeFromSuperview];
        }
    }
    
    UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 150, 30)];
    monthLabel.text = [months objectAtIndex:indexPath.row];
    monthLabel.font = [UIFont systemFontOfSize:24];
    monthLabel.userInteractionEnabled = FALSE;
    [cell.contentView addSubview:monthLabel];
    
    
    //UILabel *monthLabel = (UILabel *)[cell.contentView viewWithTag:99];
    
    self.navigationItem.title = [years objectAtIndex:indexPath.row];
    
    CFTimeZoneRef timeZoneRef = CFTimeZoneCopyDefault();
    CFGregorianDate currentMonthDate = CFAbsoluteTimeGetGregorianDate(currentTime,timeZoneRef);
    currentMonthDate.day=1;
    currentMonthDate.year = [[years objectAtIndex:indexPath.row] intValue];
    currentMonthDate.month = [[months objectAtIndex:indexPath.row] intValue];
    int weekday = [self getMonthWeekday:currentMonthDate];
    if (weekday == 7) {
        weekday = 0;
    }
    
    for (int cnt = 1; cnt <= [self getDayCountOfaMonth:currentMonthDate]; cnt++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:[NSString stringWithFormat:@"%d", cnt] forState:UIControlStateNormal];
        button.tag = [monthLabel.text intValue];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(20 + (cnt + weekday - 1)%7 * 40, 58 + (cnt + weekday - 1)/7 * 40, 30, 30);
        button.titleLabel.font = [UIFont systemFontOfSize: 15];
        [cell.contentView addSubview:button];
   
    }
    
    if(timeZoneRef){
        CFRelease(timeZoneRef);
    }
    
    return cell;
}

-(void)buttonAction:(id)sender{
    [self performSegueWithIdentifier:@"GotoDayView" sender:sender];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
