//
//  DetailViewController.h
//  VNGRSTwitter
//
//  Created by Erdem on 7.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteAction.h"
#import "Tweet.h"

@interface DetailViewController : UIViewController
@property(nonatomic,strong) Tweet *tweet;
@end
