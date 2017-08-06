//
//  ViewController.h
//  VNGRSTwitter
//
//  Created by ilker Sen on 4.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweets.h"
#import "DetailViewController.h"
@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property(nonatomic,strong) NSMutableArray *tweets;
@property(nonatomic,copy) NSString *searchText;

- (IBAction)searchTweets:(id)sender;
@property(nonatomic,strong) SearchMetadata *metaData;
@end

