//
//  AboutUsDetailViewController.m
//  NCCBF
//
//  Created by Keita on 3/6/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "AboutUsDetailViewController.h"
#import "AboutUsDetailViewCell.h"

@interface AboutUsDetailViewController ()

//@property (weak, nonatomic) IBOutlet UITextView *textView;
//@property (nonatomic, copy) NSString *festDescString;

@end

@implementation AboutUsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set up nav bar title.
//    self.title = @"About NCCBF";
    
    // Create path for plist.
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"SocialMedia" ofType:@"plist"];
//     Create dictionary to store plist's root dictionary.
//    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    // Store festival description in string.
//    self.festDescString = dict[@"FestivalDescription"];
    
//     Update text of text view.
//    self.textView.text = festDescString;
//    self.textView.editable = NO;
    
    // Update title in nav bar.
//    self.navigationController.navigationItem.title = @"About NCCBF";
    // search how to display title.
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"AboutUsDetailViewCell";

    
    AboutUsDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.AboutUsDescriptionLabel.text = self.festDescString;
    
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
