//
//  SocialViewController.m
//  NCCBF
//
//  Created by Keita on 2/17/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "SocialViewController.h"
#import "SocialViewCell.h"
#import "AboutUsCell.h"
#import "SocialWebViewController.h"

typedef NS_ENUM (NSInteger, SocialViewCellType) {
    SocialViewCellTypeFacebook = 0,
    SocialViewCellTypeTwitter,
    SocialViewCellTypeInstagram,
    SocialViewCellTypeNCCBFWebsite,
    SocialViewCellTypeAboutNCCBF,
    SocialViewCellTypePrivacyPolicy
};

@interface SocialViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *socialMediaArray;

@end

@implementation SocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUIItems];
    
    
    // Set up delegate and dataSource for table view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    // Create path for plist.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SocialMedia" ofType:@"plist"];
    // Create dictionary to store plist's root dictionary.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];

    // Store social media names in socialMediaNames array.
    self.socialMediaArray = dict[@"SocialMedia"];
    
}

#pragma mark - Set up UI methods

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if(indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)setUpUIItems {
    
    // Set tint color of nav bar back button arrow white.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

# pragma mark - Table view delegate and dataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.tmpArray.count;
    return self.socialMediaArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == SocialViewCellTypeAboutNCCBF) {
        AboutUsCell *aboutUsCell = [tableView dequeueReusableCellWithIdentifier:@"AboutUsCell" forIndexPath:indexPath];
        
        NSDictionary *socialDict = self.socialMediaArray[indexPath.row];
//        aboutUsCell.titleLabel.text = socialDict[@"name"];
        aboutUsCell.textLabel.text = socialDict[@"name"];
        
        return aboutUsCell;
    } else {
        SocialViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SocialViewCell" forIndexPath:indexPath];
        
        NSDictionary *socialDict = self.socialMediaArray[indexPath.row];
        
//        cell.titleLabel.text = socialDict[@"name"];
        cell.textLabel.text = socialDict[@"name"];

        cell.urlString = socialDict[@"URL"];
        
        return cell;
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showSocialWebView"]) {
        NSLog(@"show SocialWebView");
        
        SocialWebViewController *SWVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary *socialMediaDict = self.socialMediaArray[indexPath.row];
        NSString *urlString = socialMediaDict[@"URL"];
        SWVC.urlString = urlString;
        SWVC.title = socialMediaDict[@"name"];
    }
    
}









#pragma mark - memory warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
