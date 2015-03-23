//
//  EventDetailViewController.m
//  NCCBF
//
//  Created by Keita on 2/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "EventDetailViewController.h"
#import "Event.h"
#import "EventDetailViewBaseCell.h"

typedef NS_ENUM (NSInteger, EventDetailViewCellType) {
    EventDetailViewCellTypeImage = 0,
    EventDetailViewCellTypeName,
    EventDetailViewCellTypeSchedule,
    EventDetailViewCellTypeLocation,
    EventDetailViewCellTypeDescription
};

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set nav bar title.
    self.title = self.eventDetail.name;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Fix Cell height when view is returned from other tab views.
    [self.tableView reloadData];
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
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = nil;
    
    if (indexPath.row == EventDetailViewCellTypeImage) {
        identifier = @"EventImageCell";
    }
    else if (indexPath.row == EventDetailViewCellTypeName) {
        identifier = @"EventNameCell";
    }
    else if (indexPath.row == EventDetailViewCellTypeSchedule) {
        identifier = @"EventScheduleCell";
    }
    else if (indexPath.row == EventDetailViewCellTypeLocation) {
        identifier = @"EventLocationCell";
    }
    else if (indexPath.row == EventDetailViewCellTypeDescription) {
        identifier = @"EventDescriptionCell";
    }
    
    EventDetailViewBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell...
    [cell setupWithModel:self.eventDetail];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"UITableViewAutomationDimension");
    return UITableViewAutomaticDimension;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
