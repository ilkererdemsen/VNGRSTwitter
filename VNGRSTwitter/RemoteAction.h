//
//  RemoteAction.h
//  VNGRSTwitter
//
//  Created by Erdem on 5.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweets.h"
#import <TwitterKit/TwitterKit.h>
@interface RemoteAction : NSObject

+ (id)sharedManager;


-(void)searchTweets:(NSString *)searchText
           metaData:(SearchMetadata *)metadata
               type:(int)type
            success:(void (^)(Tweets *response)) successBlock
            failure:(void (^)( NSError *error)) failureBlock;
-(void)tweetDetail:(NSString *)tweetId
           success:(void (^)(TWTRTweet *response)) successBlock
           failure:(void (^)( NSError *error)) failureBlock;
@end
