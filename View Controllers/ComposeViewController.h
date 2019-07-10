//
//  ComposeViewController.h
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *picView;
- (IBAction)cancelButton:(id)sender;
- (IBAction)finalPostButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *caption;


@end

NS_ASSUME_NONNULL_END
