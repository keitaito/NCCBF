//
//  AboutUsDetailViewController.m
//  NCCBF
//
//  Created by Keita on 3/6/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "AboutUsDetailViewController.h"

@interface AboutUsDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AboutUsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set up nav bar title.
    self.title = @"About NCCBF";
    
    // Create path for plist.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SocialMedia" ofType:@"plist"];
    // Create dictionary to store plist's root dictionary.
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];

    // Store festival description in string.
    NSString *festDescString = dict[@"FestivalDescription"];
    // Update text of text view.
    self.textView.text = festDescString;
    self.textView.editable = NO;
    
    // Update title in nav bar.
//    self.navigationController.navigationItem.title = @"About NCCBF";
    // search how to display title.
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
