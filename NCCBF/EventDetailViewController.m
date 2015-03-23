//
//  EventDetailViewController.m
//  NCCBF
//
//  Created by Keita on 2/12/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "EventDetailViewController.h"
#import "Event.h"

typedef NS_ENUM (NSInteger, KeitaTableType) {
    KeitaTableTypePicture = 0,
    KeitaTableTypeName,
    KeitaTableTypeDescription,
};

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set nav bar title.
    self.title = self.eventDetail.name;
    
    // Set event image.
    NSString *imageName = self.eventDetail.imageString;
    self.detailPosterView.image = [UIImage imageNamed:imageName];
    
    // Set event title, time, location, description.
    self.titleLabel.text = self.eventDetail.name;
    self.eventDescriptionLabel.text = self.eventDetail.eventDescription;
    self.locationLabel.text = self.eventDetail.location;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = nil;
    
    if (indexPath.row == KeitaTableTypePicture) {
        identifier = @"EventImageCell";
    } else if (indexPath.row == KeitaTableTypeName) {
        identifier = @"EventNameCell";
    } else if (indexPath.row == KeitaTableTypeDescription) {
        identifier = @"EventDescriptionCell";
    }
    
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    
    
    // Configure the cell...
    Event *event = [[Event alloc] init];
    [cell setupWithModel:event];
    
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
