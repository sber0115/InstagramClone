//
//  PostCell.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"
#import "NSDate+DateTools.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)pressLike:(id)sender {
}

- (void)makePost:(Post *)post {
    _post = post;
    
    NSDate *createdAtDate = post.createdAt;
    
    NSDate *timeAgoDate = [NSDate dateWithTimeInterval:0 sinceDate:createdAtDate];

    self.postTimeElapsed.text = timeAgoDate.shortTimeAgoSinceNow;
    
    self.postImage.file = post.image;
    [self.postImage loadInBackground];
    self.postCaption.text = post.caption;
    self.numLikes.text = [NSString stringWithFormat:@"%lu",post.usersWhoLikedArray.count];
    
    PFUser *author = post[@"author"];
    self.postUsername.text = author.username;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
