//
//  DayViewController.m
//  TrackMyMoney
//
//  Created by wyp on 13-10-31.
//  Copyright (c) 2013年 he110world. All rights reserved.
//

#import "DayViewController.h"
#import "Money.h"
#import "MoneyManager.h"

@interface DayViewController (){
    NSMutableArray *moneyData;
}

@end

@implementation DayViewController

@synthesize selectDate;

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
    //NSLog(@"date:%@",selectDate);

    self.navigationItem.title = selectDate;
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat:@"dateNo MATCHES %@",[NSNumber numberWithInt:[selectDate intValue]]];
    MoneyManager *mm = [[MoneyManager alloc] init];
    moneyData = [mm load:predicate];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return moneyData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"DaysCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }else{
        NSArray*subviews = [[NSArray alloc]initWithArray:cell.contentView.subviews];
        for (UIView *subview in subviews) {
            [subview removeFromSuperview];
        }
    }
    
    self.navigationItem.title = selectDate;
    /*
    //UILabel *yearLabel = (UILabel *)[cell.contentView viewWithTag:99];
    UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(52, 20, 150, 30)];
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
    */
    
    Money *money = [moneyData objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"-%d",[money.receipt intValue]];
    return cell;
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
