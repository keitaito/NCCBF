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

@property (strong, nonatomic) NSArray *tmpArray;
@property (strong, nonatomic) NSArray *socialMediaNames;

@end

@implementation SocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tmpArray = @[@"Tokyo",
                      @"Yokohama",
                      @"Chiba",
                      @"Saitama"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SocialMedia" ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    self.socialMediaNames = dict[@"SocialMediaNames"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.tmpArray.count;
    return self.socialMediaNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SocialViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialViewCell" forIndexPath:indexPath];
//    cell.titleLabel.text = self.tmpArray[indexPath.row];
    cell.titleLabel.text = self.socialMediaNames[indexPath.row];

    return cell;
}

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
