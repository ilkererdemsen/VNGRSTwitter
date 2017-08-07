//
//  DetailViewController.h
//  VNGRSTwitter
//
//  Created by Erdem on 7.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import "BaseViewController.h"


@interface DetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mediaImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property(nonatomic,strong) Tweet *tweet;
@end
