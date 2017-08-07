//
//  ViewController.m
//  VNGRSTwitter
//
//  Created by ilker Sen on 4.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property(nonatomic)BOOL isProcessing;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.metaData) {
        [self loadDataWithMetadata:self.metaData withType:0];
    }
}
-(NSMutableArray *)tweets {
    if (!_tweets) {
        _tweets = [NSMutableArray array];
    }
    return _tweets;
}

- (IBAction)searchTweets:(id)sender {
    self.searchText = self.searchTextField.text;
    self.tweets = nil;
    self.metaData = nil;
    [self loadDataWithMetadata:self.metaData withType:0];
    
}


-(void)loadDataWithMetadata:(SearchMetadata *)data
                   withType:(int)type{
    if (self.isProcessing) {
        return;
    }
    self.isProcessing = YES;
    [[RemoteAction sharedManager] searchTweets:self.searchTextField.text
                                      metaData:self.metaData
                                          type:type
                                       success:^(Tweets *response) {
                                           self.isProcessing = NO;
                                           if (type == 0) {
                                               NSMutableArray *tempArray= [response.statuses mutableCopy];
                                               [tempArray addObjectsFromArray:self.tweets];
                                               self.tweets = tempArray;
                                           } else {
                                               [self.tweets addObjectsFromArray:response.statuses];
                                           }
                                           self.metaData = response.search_metadata;
                                           [self.tableView reloadData];
                                       } failure:^(NSError *error) {
                                           self.isProcessing = NO;
                                       }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tweets count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Tweet *tweet = self.tweets[indexPath.row];
    if (tweet.entities.media) {
        return 261;
    } else {
        return 90;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweets[indexPath.row];
    if (tweet.entities.media) {
        ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
        if (cell) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell"];
        }
        [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",tweet.user.profile_image_url_https]]];
        NSString *url = ((Media *)tweet.entities.media[0]).media_url;
        [cell.mediaImage sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            cell.mediaImage.image = image;
        }];
        cell.tweetTextLabel.text = tweet.text;
        return cell;
    } else {
        StandardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StandardCell"];
        if (cell) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"StandardCell"];
        }
        [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",tweet.user.profile_image_url_https]]];
        cell.tweetTextLabel.text = tweet.text;
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweets[indexPath.row];
    DetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detail.tweet = tweet;
    [self.navigationController pushViewController:detail animated:YES];
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > [self.tweets count] - 3 ) {
        [self loadDataWithMetadata:self.metaData withType:1];
    }
}



@end
