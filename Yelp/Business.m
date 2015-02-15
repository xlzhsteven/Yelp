//
//  Business.m
//  Yelp
//
//  Created by Xiaolong Zhang on 2/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "Business.h"

@implementation Business

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        // Set image url
        self.imageUrl = dictionary[@"image_url"];
        
        // Set business name
        self.businessName = dictionary[@"name"];
        
        // Set distance
        float milesPerMeter = 0.000621371;
        self.distance = [dictionary[@"distance"] integerValue] * milesPerMeter;
        
        // Set rating image url
        self.ratingImageUrl = dictionary[@"rating_img_url"];
        
        // Set num of reviews
        self.numReviews = [dictionary[@"review_count"] integerValue];
        
        // Set address, handle error when street is nil
        NSString *street = [dictionary valueForKeyPath:@"location.address"][0];
        NSString *neighborhoods = [dictionary valueForKeyPath:@"location.neighborhoods"][0];
        self.address = [NSString stringWithFormat:@"%@, %@",street, neighborhoods];
        
        // Set categories
        NSArray *categories = dictionary[@"categories"];
        NSMutableArray *categoryNames = [NSMutableArray array];
        [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [categoryNames addObject:obj[0]];
        }];
        self.categories = [categoryNames componentsJoinedByString:@", "];
    }
    return self;
}

+ (NSArray *)businessesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *businesses = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Business *business = [[Business alloc] initWithDictionary:dictionary];
        [businesses addObject:business];
    }
    return businesses;
}

@end
