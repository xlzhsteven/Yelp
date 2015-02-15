//
//  BusinessCell.m
//  Yelp
//
//  Created by Xiaolong Zhang on 2/14/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "BusinessCell.h"
#import "UIImageView+AFNetworking.h"

@interface BusinessCell ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *businessNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;

@end
@implementation BusinessCell

- (void)awakeFromNib {
    self.businessNameLabel.preferredMaxLayoutWidth = self.businessNameLabel.frame.size.width;
    self.posterImageView.layer.cornerRadius = 3;
    self.posterImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBusiness:(Business *)business {
    _business = business;
    [self.posterImageView setImageWithURL:[NSURL URLWithString:self.business.imageUrl]];
    self.businessNameLabel.text = self.business.businessName;
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f mi", self.business.distance];
    [self.ratingImageView setImageWithURL:[NSURL URLWithString:self.business.ratingImageUrl]];
    self.reviewCountLabel.text = [NSString stringWithFormat:@"%ld Reviews",self.business.numReviews];
    self.addressLabel.text = self.business.address;
    self.categoriesLabel.text = self.business.categories;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.businessNameLabel.preferredMaxLayoutWidth = self.businessNameLabel.frame.size.width;
}

@end
