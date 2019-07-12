//
//  PostedPicCell.h
//  InstagramClone
//
//  Created by sbernal0115 on 7/11/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "PFImageView.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostedPicCell : UICollectionViewCell

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *previousPostImageView;

- (void)setImage:(Post *)post;

@end

NS_ASSUME_NONNULL_END
