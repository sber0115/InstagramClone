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

@interface DetailedViewViewController ()

@property (weak, nonatomic) UIImage *capturedPic;

@end


@implementation DetailedViewViewController

- (void)viewDidLoad {
    
    
    NSDate *createdAtDate = self.post.createdAt;
    
    NSDate *timeAgoDate = [NSDate dateWithTimeInterval:0 sinceDate:createdAtDate];
        
    self.createdAt.text = timeAgoDate.shortTimeAgoSinceNow;
    
    [super viewDidLoad];
    
    self.postPic.file = self.post.image;
    [self.postPic loadInBackground];
    
    
    PFUser *author = self.post[@"author"];
    
    self.postUsername.text = author.username;
    
    self.postCaption.text = self.post.caption;
    self.postLikes.text = [NSString stringWithFormat:@"%lu", self.post.usersWhoLikedArray.count];
    

    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
