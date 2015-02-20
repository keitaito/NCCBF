//
//  ScheduleTableViewController.m
//  NCCBF
//
//  Created by Keita on 2/14/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "ScheduleTableViewCell.h"

@interface ScheduleTableViewController ()

@property (nonatomic, strong) NSArray *events;

@end

@implementation ScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.events = @[@"ManUtd",
//                    @"Liverpool",
//                    @"Chelsea",
//                    @"Arsenal",
//                    @"ManCity",
//                    @"Tottenham",
//                    @"Everton"];
    
    
    
    // Create path for plist.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Event" ofType:@"plist"];
    // Create dictionary to store plist's root dictionary.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    // Store Events Array into events property
    self.events = dict[@"Events"];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"ScheduleTableView");
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduleTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    // Get event name string from events property
    // 1. get an event
    NSDictionary *anEvent = self.events[indexPath.row];
    // 2. get name string
    NSString *eventName = anEvent[@"name"];
    // Set title label.
    cell.titleLabel.text = eventName;
    
    // get 
    
    
//     Set title label.
//    cell.titleLabel.text = self.events[indexPath.row];
    
    return cell;
}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
