//
//  Tweet.h
//  VNGRSTwitter
//
//  Created by Erdem on 5.08.2017.
//  Copyright © 2017 Erdem ilker Sen. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol Mentions;
@protocol Media;

@interface Media : JSONModel
@property(nonatomic,copy)NSString *media_url;
@end

@interface Mentions : JSONModel
@property(nonatomic,copy)NSString *id_str;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *screen_name;
@end

@interface Entities : JSONModel
@property(nonatomic,strong)NSArray *hashtags;
@property(nonatomic,strong)NSArray<Mentions> *user_mentions;
@property(nonatomic,strong)NSArray<Media,Optional> *media;


@end

@interface User : JSONModel
@property(nonatomic,copy)NSString*screen_name;
@property(nonatomic,copy)NSString *profile_image_url_https;

@end

@interface Tweet : JSONModel
@property(nonatomic,copy)NSString *id_str;
@property(nonatomic,copy)NSString *text;

@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,strong)Entities *entities;
@property(nonatomic,copy)NSNumber *favorite_count;
@property(nonatomic,strong)NSNumber *retweet_count;
@property(nonatomic,copy)NSString *source;
 @property(nonatomic,strong)User *user;

@end

 
