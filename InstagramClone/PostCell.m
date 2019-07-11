//
//  PostCell.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)makePost:(Post *)post {
    _post = post;
    self.postImage.file = post.image;
    [self.postImage loadInBackground];
    self.postCaption.text = post.caption;
    self.numLikes.text = [post.likeCount stringValue];
    
    PFUser *author = post[@"author"];
    self.postUsername.text = author.username;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
