//
//  PostCell.h
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "Post.h"

@import ParseUI

NS_ASSUME_NONNULL_BEGIN


@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextView *postCaption;
@property (strong, nonatomic) Post *post;


@end

NS_ASSUME_NONNULL_END
