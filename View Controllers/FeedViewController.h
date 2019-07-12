//
//  FeedViewController.h
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedViewController : UIViewController <UIScrollViewDelegate>

- (IBAction)logoutButton:(id)sender;
- (IBAction)composeButton:(id)sender;

@end



NS_ASSUME_NONNULL_END
