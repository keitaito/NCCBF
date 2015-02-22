//
//  SocialWebViewController.m
//  NCCBF
//
//  Created by Keita on 2/20/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "SocialWebViewController.h"

@interface SocialWebViewController () /*<UIWebViewDelegate>*/

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation SocialWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Create urlRequest for web view.
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    // Load urlRequest.
    [self.webView loadRequest:urlRequest];
    NSLog(@"%@", self.urlString);
}


//#pragma mark - UIWebViewDelegate methods
//
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    // starting the load, show the activity indicator in the status bar
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    // finished loading, hide the activity indicator in the status bar
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    // load error, hide the activity indicator in the status bar
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    
//    // report the error inside the webview
//    NSString* errorString = [NSString stringWithFormat:
//                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
//                             error.localizedDescription];
//    [self.webView loadHTMLString:errorString baseURL:nil];
//}




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
