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
@property (nonatomic, strong) NSArray *eventsJSON;

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
//    NSLog(@"%@", self.events);
    
    NSString *urlString = @"http://keitaito.com/sampleNCCBF/document.json";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               self.eventsJSON = object[@"Events"];
                               [self.tableView reloadData];
                               NSLog(@"%@", object);
                           }];
    

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
//    return [self.events count];
    return [self.eventsJSON count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventTableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    // Get event name string from events property
    // 1. get an event
//    NSDictionary *anEvent = self.events[indexPath.row];
    NSDictionary *anEvent = self.eventsJSON[indexPath.row];

    // 2. get name string
    NSString *eventName = anEvent[@"name"];
    // Set title label.
    cell.titleLabel.text = eventName;
    
    // Set poster view.
//    NSString *pathForImage = [[NSBundle mainBundle] pathForResource:@"sample-image" ofType:@"jpg"];
//    UIImage *poster = [UIImage imageWithContentsOfFile:pathForImage];
    NSString *imageName = anEvent[@"image_name"];
    UIImage *poster = [UIImage imageNamed:imageName];
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
//        NSDictionary *eventDictionary = self.events[indexPath.row];
        NSDictionary *eventDictionary = self.eventsJSON[indexPath.row];
        // 2. get name string
        __unused NSString *eventTitle = eventDictionary[@"name"];

//        Event *eventDetail = [[Event alloc] initWithEventTitle:eventTitle];
        Event *eventDetail = [[Event alloc] initWithEventDictionary:eventDictionary];
        eventDetailViewController.eventDetail = eventDetail;
    }
}



//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//        for (int 0; i < plist.count; i++) {
//            Event *event = [[Event alloc] initwihPlist[i]];
//            [self.events addObject:event];
//        }
//    }
//    return self;
//}









#pragma mark - memory warning

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
