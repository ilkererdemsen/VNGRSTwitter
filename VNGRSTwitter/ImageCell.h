//
//  ImageCell.h
//  VNGRSTwitter
//
//  Created by Erdem on 6.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mediaImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end
