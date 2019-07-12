//
//  ComposeViewController.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "MBProgressHUD.h"


@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIImage *imageToPost;

@end


@implementation ComposeViewController
- (void)viewDidLoad {
    [super viewDidLoad];

        
    // Do any additional setup after loading the view.
}



- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}



- (void) launchCamera

{
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    //resize
    self.imageToPost = [self resizeImage:editedImage withSize:CGSizeMake(100, 100)];
    
    self.picView.image = editedImage;
    
    
    // Do something with the images (based on your use case)
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)cameraLauncer:(id)sender {
    NSLog(@"Camera luancher worked");
    [self launchCamera];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)finalPostButton:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Posting...";
    
    [Post postUserImage:self.picView.image withCaption:self.caption.text withCompletion:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
    
    [hud hideAnimated:YES];

    
}






@end
