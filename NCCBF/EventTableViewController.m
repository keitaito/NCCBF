//
//  EventTableViewController.m
//  NCCBF
//
//  Created by Keita on 2/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "EventTableViewController.h"
#import "EventTableViewCell.h"
#import "EventDetailViewController.h"
#import "Event.h"

@interface EventTableViewController ()

@property (nonatomic, strong) NSArray *events;

@end

@implementation EventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.events = @[@"Apple",
//                    @"Banana",
//                    @"Orange",
//                    @"Strawberry",
//                    @"Grape",
//                    @"Watermelon",
//                    @"Peach",
//                    @"Blueberry",
//                    @"Raspberry"];
    
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
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    // Get event name string from events property
    // 1. get an event
    NSDictionary *anEvent = self.events[indexPath.row];
    // 2. get name string
    NSString *eventName = anEvent[@"name"];
    // Set title label.
    cell.titleLabel.text = eventName;
    
    // Set poster view.
//    NSString *pathForImage = [[NSBundle mainBundle] pathForResource:@"sample-image" ofType:@"jpg"];
//    UIImage *poster = [UIImage imageWithContentsOfFile:pathForImage];
    UIImage *poster = [UIImage imageNamed:@"sample-image"];
    cell.posterView.image = poster;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showEventDetailView"]) {
        NSLog(@"showEventDetailView");
        
        EventDetailViewController *eventDetailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // Get event title string from events property
        // 1. get an event
        NSDictionary *anEvent = self.events[indexPath.row];
        // 2. get name string
        NSString *eventTitle = anEvent[@"name"];

        Event *eventDetail = [[Event alloc] initWithEventTitle:eventTitle];
        eventDetailViewController.eventDetail = eventDetail;
    }
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





@end
