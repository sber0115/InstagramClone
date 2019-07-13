//
//  DetailedViewViewController.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/10/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "DetailedViewViewController.h"
#import "NSDate+DateTools.h"
#import <UIKit/UIKit.h>


static NSString * const POST_AUTHOR_KEY = @"author";


@interface DetailedViewViewController ()

@property (weak, nonatomic) UIImage *capturedPic;

@end


@implementation DetailedViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureDetailedView];
}


- (void)configureDetailedView
{
    NSDate *createdAtDate = self.post.createdAt;
    
    NSDate *timeAgoDate = [NSDate dateWithTimeInterval:0 sinceDate:createdAtDate];
    
    self.createdAtLabel.text = timeAgoDate.shortTimeAgoSinceNow;
    
    self.postPicImageView.file = self.post.image;
    [self.postPicImageView loadInBackground];
    
    PFUser *author = self.post[POST_AUTHOR_KEY];
    
    self.postUsernameLabel.text = author.username;
    
    self.postCaptionLabel.text = self.post.caption;
    self.postLikesLabel.text = [NSString stringWithFormat:@"%lu", self.post.usersWhoLikedArray.count];
    
}

@end
