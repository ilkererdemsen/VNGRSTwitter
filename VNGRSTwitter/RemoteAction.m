//
//  RemoteAction.m
//  VNGRSTwitter
//
//  Created by Erdem on 5.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import "RemoteAction.h"
#import <Fabric/Fabric.h>


#define RemoteURLString @"https://api.twitter.com/1.1/search/tweets.json?q="
#define RemoteURL       [NSURL URLWithString:RemoteURLString]

@implementation RemoteAction

+ (id)sharedManager {
    static RemoteAction *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    }); 
    return sharedMyManager;
}


-(void)searchTweets:(NSString *)searchText
           metaData:(SearchMetadata *)metadata
               type:(int)type
            success:(void (^)(Tweets *response)) successBlock
            failure:(void (^)( NSError *error)) failureBlock {
    NSString *strSearch = searchText;
    
    // convert to a data object, using a lossy conversion to ASCII
    NSData *asciiEncoded = [searchText dataUsingEncoding:NSASCIIStringEncoding
                                   allowLossyConversion:YES];
    // take the data object and recreate a string using the lossy conversion
    strSearch = [[NSString alloc] initWithData:asciiEncoded
                                      encoding:NSASCIIStringEncoding];
    
    strSearch = [strSearch stringByReplacingOccurrencesOfString:@" "
                                                     withString:@"%20"];
    strSearch = [strSearch stringByReplacingOccurrencesOfString:@"@"
                                                     withString:@"%40"];
    strSearch = [strSearch stringByReplacingOccurrencesOfString:@"\""
                                                     withString:@"%22"];
    strSearch = [strSearch stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@"%23"];
    NSString *strURL;
    if (metadata) {
        strURL = [NSString stringWithFormat:@"%@%@",RemoteURLString,type==0 ?metadata.refresh_url : metadata.next_results];
    } else {
    strURL = [NSString stringWithFormat:@"%@%@",RemoteURLString,strSearch];
    }
    
    NSDictionary *params = @{};
    NSError *clientError;
    TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
    NSURLRequest *request = [client URLRequestWithMethod:@"GET" URL:strURL parameters:params error:&clientError];
    if (request) {
        [client sendTwitterRequest:request
                        completion:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                            if (data) {
                                NSError *error;
                                Tweets *tweets = [[Tweets alloc] initWithData:data error:&error]; 
                                successBlock(tweets);
                            }
                            else {
                                NSLog(@"Error: %@", connectionError);
                            }
                        }];
    }
    
    
}

-(void)tweetDetail:(NSString *)tweetId
           success:(void (^)(TWTRTweet *response)) successBlock
           failure:(void (^)( NSError *error)) failureBlock{
    TWTRAPIClient *client = [[TWTRAPIClient alloc] init];
    [client loadTweetWithID:tweetId completion:^(TWTRTweet *tweet, NSError *error) {
        if (!error) {
            successBlock(tweet);
        } else {
            NSLog(@"Failed to load tweet: %@", [error localizedDescription]);
        }
    }];

}
@end
