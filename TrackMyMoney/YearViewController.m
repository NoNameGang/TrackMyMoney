//
//  YearViewController.m
//  Accounting
//
//  Created by wyp on 13-10-29.
//  Copyright (c) 2013年 ohhnoz. All rights reserved.
//

#import "YearViewController.h"
#import "MonthViewController.h"

@interface YearViewController ()

@end

@implementation YearViewController
{
    NSArray *dates;
    NSArray *years;
    NSArray *bills;
    NSArray *images;
}

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
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //years = [NSArray arrayWithObjects:@"2010", @"2011", @"2012", @"2013", nil];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Accounting" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    dates = [dict objectForKey:@"Date"];
    
    NSDate *firstDate = [dates objectAtIndex:0];
    CFDateRef firstDateRef = CFBridgingRetain(firstDate);
    CFAbsoluteTime firstTime = CFDateGetAbsoluteTime(firstDateRef);
    CFTimeZoneRef timeZoneRef = CFTimeZoneCopyDefault();
    CFGregorianDate firstDateCf = CFAbsoluteTimeGetGregorianDate(firstTime,timeZoneRef);
    CFAbsoluteTime thisTime =  CFAbsoluteTimeGetCurrent();
    CFGregorianDate thisDateCf = CFAbsoluteTimeGetGregorianDate(thisTime,timeZoneRef);
/*
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:firstDate];
    int firstYear = comps.year;
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    int thisYear = comps.year;
    */
    years = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", (int)firstDateCf.year], nil];
    
    
    for (int cnt = (int)firstDateCf.year + 1; cnt <= (int)thisDateCf.year; cnt++) {
        years = [years arrayByAddingObject:[NSString stringWithFormat:@"%d", cnt]];
    }
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:(int)thisDateCf.year - (int)firstDateCf.year inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    // FUCK: CF Ref need to be released!!
    CFRelease(firstDateRef);
    CFRelease(timeZoneRef);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 430;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *simpleTableIdentifier = @"SimpleTableViewCell";
    SimpleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        //cell.contentView.userInteractionEnabled = NO;
        //[cell reuseIdentifier:simpleTableIdentifier];
        
    }*/
    
    //cell.yearLabel.text = [years objectAtIndex:indexPath.row];
    
    static NSString *simpleTableIdentifier = @"YearsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }else{
        NSArray*subviews = [[NSArray alloc]initWithArray:cell.contentView.subviews];
        for (UIView *subview in subviews) {
                [subview removeFromSuperview];
        }
    }
    
    //UILabel *yearLabel = (UILabel *)[cell.contentView viewWithTag:99];
    UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 150, 30)];
    yearLabel.text = [years objectAtIndex:indexPath.row];
    yearLabel.font = [UIFont systemFontOfSize:24];
    yearLabel.userInteractionEnabled = FALSE;
    [cell.contentView addSubview:yearLabel];
    
    //cell.textLabel.text = [years objectAtIndex:indexPath.row];
    
    for (int cnt = 1; cnt <= 12; cnt++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:[NSString stringWithFormat:@"%d", cnt] forState:UIControlStateNormal];
        button.tag = [yearLabel.text intValue];
        //button.tag = indexPath.row;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(20 + (cnt - 1)%3 * 100, 58 + (cnt - 1)/3 * 88, 80, 80);
        button.titleLabel.font = [UIFont systemFontOfSize: 20];
        [cell.contentView addSubview:button];
        
        
    }
    
    return cell;
}



-(void)buttonAction:(id)sender{
    
    //self.navigationItem.backBarButtonItem.title = [NSString stringWithFormat:@"%d-%@",button.tag,button.titleLabel.text];
    //[self.navigationController pushViewController:monthView animated:YES];
    [self performSegueWithIdentifier:@"GotoMonthView" sender:sender];
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIButton *button = (UIButton *)sender;
    /*
    //MonthViewController *monthView = [[MonthViewController alloc] init];
    CFGregorianDate selectedMonthDate;
    CFAbsoluteTime        currentTime;
    currentTime=CFAbsoluteTimeGetCurrent();
    selectedMonthDate=CFAbsoluteTimeGetGregorianDate(currentTime,CFTimeZoneCopyDefault());
    selectedMonthDate.year = button.tag;
    selectedMonthDate.month = [button.titleLabel.text intValue];
    */
    //monthView.selectedDate = selectedMonthDate;
     //NSLog(@"111:%d.%d",button.tag,[button.titleLabel.text intValue]);
    
    UIViewController *monthView = segue.destinationViewController;
    //if (monthView.class == ) {
    if ([segue.identifier  isEqual: @"GotoMonthView"]) {
        [monthView setValue:[NSString stringWithFormat:@"%d",button.tag] forKey:@"selectYear"];
        [monthView setValue:button.titleLabel.text forKey:@"selectMonth"];
    }

    //}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
