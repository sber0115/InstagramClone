//
//  ProfileViewController.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/11/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "ProfileViewController.h"


@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *previousPostsArray;

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.usernameLabel.text = PFUser.currentUser.username;
    self.nameLabel.text = PFUser.currentUser[@"fullName"];
    
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self setUserProfileImage];
    [self collectionViewFormatting];
    
    
    [self userOnlyData];
    
    
}




- (void) setUserProfileImage
{
    
    PFFileObject *userProfileImageFile = [PFUser currentUser][@"profileImageFile"];
    
    self.profileImageImageView.file = userProfileImageFile;
    [self.profileImageImageView loadInBackground];
    
    self.profileImageImageView.layer.masksToBounds = true;
    self.profileImageImageView.layer.cornerRadius = self.profileImageImageView.frame.size.width/2;
    
}





- (void) collectionViewFormatting
{
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    CGFloat postsPerLine = 4;
    CGFloat itemWidth = (self.collectionView.frame.size.width / postsPerLine);
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
}




//
//- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
//    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//
//    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
//    resizeImageView.image = image;
//
//    UIGraphicsBeginImageContext(size);
//    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return newImage;
//}
//
//
//
//- (void) launchCamera
//
//{
//
//    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
//    imagePickerVC.delegate = self;
//    imagePickerVC.allowsEditing = YES;
//
//
//
//
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    else {
//        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//
//
//    [self presentViewController:imagePickerVC animated:YES completion:nil];
//
//}
//
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//
//    // Get the image captured by the UIImagePickerController
//    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
//    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
//
//    //resize
//    self.imageToPost = [self resizeImage:editedImage withSize:CGSizeMake(100, 100)];
//
//    self.picView.image = editedImage;
//
//
//    // Do something with the images (based on your use case)
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//}





- (void) userOnlyData

{
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo:PFUser.currentUser];
    
    postQuery.limit = 20;
    
    
    //wherekey -->  created at less than
    // get the date of the last post --> array indexing
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.previousPostsArray = posts;
            
            [self.collectionView reloadData];
            
            
        }
        else {
            NSLog(@"Was not able to load posts");
        }
        
    }];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    

    PostedPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"previousPost" forIndexPath:indexPath];
    
    Post *post = self.previousPostsArray[indexPath.item];
    
    [cell setImage:post];
    
    return cell;
    
    
    
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.previousPostsArray.count;
}



@end
