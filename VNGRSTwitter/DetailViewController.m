//
//  DetailViewController.m
//  VNGRSTwitter
//
//  Created by Erdem on 7.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[RemoteAction sharedManager] tweetDetail:self.tweet.id_str
                                      success:^(TWTRTweet *response) {
                                          
                                      } failure:^(NSError *error) {
                                          
                                      }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
