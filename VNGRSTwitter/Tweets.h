//
//  Tweets.h
//  VNGRSTwitter
//
//  Created by Erdem on 6.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Tweet.h"
@protocol Tweet;
@protocol ProductModel;


@interface SearchMetadata : JSONModel
@property(nonatomic)NSString<Optional> *next_results;
@property(nonatomic)NSString<Optional> *refresh_url;

@end

@interface Tweets : JSONModel
@property(nonatomic,strong)NSArray<Tweet> *statuses;
@property(nonatomic,strong)SearchMetadata *search_metadata;

@end
