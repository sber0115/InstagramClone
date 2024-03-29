//
//  Post.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "Parse/Parse.h"
#import "Post.h"


@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic usersWhoLikedArray;
@dynamic createdAtDate;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.usersWhoLikedArray = [NSMutableArray new];
    newPost.commentCount = @(0);
    newPost.createdAtDate = [NSDate date];

    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Successfully saved post");
            
            //line below is what sends the boolean yes
            //to indicate post success to completion block
            //nil is the error to be "returned"
            completion(YES,nil);
            //the values above are to be used in the composeViewController
        }
        else {
            NSLog(@"%@", error.localizedDescription);
            completion(NO,error);
        }
    }];
    
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }

    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
