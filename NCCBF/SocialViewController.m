//
//  SocialViewController.m
//  NCCBF
//
//  Created by Keita on 2/17/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "SocialViewController.h"
#import "SocialViewCell.h"

@interface SocialViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *festivalDescription;

//@property (strong, nonatomic) NSArray *tmpArray;
@property (strong, nonatomic) NSArray *socialMediaArray;
@property (strong, nonatomic) NSString *festivalDescriptionString;

@end

@implementation SocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set up delegate and dataSource for table view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.tmpArray = @[@"Tokyo",
//                      @"Yokohama",
//                      @"Chiba",
//                      @"Saitama"];
    
    // Create path for plist.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SocialMedia" ofType:@"plist"];
    // Create dictionary to store plist's root dictionary.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    // Store social media names dict into socialMediaNames property.
    self.socialMediaArray = dict[@"SocialMedia"];
    // Store festival description into string.
    self.festivalDescriptionString = dict[@"FestivalDescription"];
    self.festivalDescription.text = self.festivalDescriptionString;
    self.festivalDescription.editable = NO;
}

# pragma mark - table view delegate and dataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.tmpArray.count;
    return self.socialMediaArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SocialViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialViewCell" forIndexPath:indexPath];

    NSDictionary *socialDict = self.socialMediaArray[indexPath.row];
    
    cell.titleLabel.text = socialDict[@"name"];
    cell.urlString = socialDict[@"URL"];

    return cell;
}













#pragma mark - memory warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
