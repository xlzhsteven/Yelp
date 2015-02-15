//
//  Business.h
//  Yelp
//
//  Created by Xiaolong Zhang on 2/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, strong) NSString *ratingImageUrl;
@property (nonatomic, assign) NSInteger numReviews;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *categories;

+ (NSArray *)businessesWithDictionaries:(NSArray *)dictionaries;

@end
