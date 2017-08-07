//
//  DetailViewController.m
//  VNGRSTwitter
//
//  Created by Erdem on 7.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import "DetailViewController.h"
#import <UIImageView+WebCache.h>

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.tweet.entities.media) {
        self.imageViewHeight.constant = 0;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[RemoteAction sharedManager] tweetDetail:self.tweet.id_str
                                      success:^(TWTRTweet *response) {
                                          [self refreshTweetData:response];
                                          [self reloadView];
                                      } failure:^(NSError *error) {
                                          
                                      }];
}
-(void)refreshTweetData:(TWTRTweet *)data{
    self.tweet.favorite_count = data.likeCount;
    self.tweet.retweet_count = data.retweetCount;

}

- (void)reloadView {
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:self.tweet.user.profile_image_url_https ]];
    if (self.tweet.entities.media) {
        NSString *url = ((Media *)self.tweet.entities.media[0]).media_url;
        [self.mediaImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.mediaImageView.image = image;
        }];
    }
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%lld Retweet",self.tweet.retweet_count];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%lld Favourite",self.tweet.favorite_count];
    self.commentCountLabel.text = [NSString stringWithFormat:@"%lu Contributors",(unsigned long)(self.tweet.contributors ? [self.tweet.contributors count]:0)];
    self.tweetTextLabel.text = self.tweet.text;
    self.dateLabel.text = [self formattedDate:self.tweet.created_at];
}

-(NSString *)formattedDate:(NSString *)stringDate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];

    NSDate *date = [dateFormat dateFromString:stringDate];
    
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm"];
    return  [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
    
    
}

@end
