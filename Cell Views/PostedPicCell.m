//
//  PostedPicCell.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/11/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "PostedPicCell.h"
#import "Post.h"

@implementation PostedPicCell




- (void)setImage:(Post *)post {
    _post = post;
    self.previousPostImageView.file = post.image;
    [self.previousPostImageView loadInBackground];
    
}



@end
