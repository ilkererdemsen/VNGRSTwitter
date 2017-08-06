//
//  StandardCell.h
//  VNGRSTwitter
//
//  Created by Erdem on 6.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;

@end
