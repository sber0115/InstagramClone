//
//  ProfileViewController.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/11/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "ProfileViewController.h"
#import "DetailedViewViewController.h"



static NSString * const PREVIOUS_POST_CELL_ID = @"previousPost";
static NSString * const POST_ORDERING_KEY = @"createdAt";
static NSString * const POST_AUTHOR_KEY = @"author";
static NSString * const USER_PROFILE_IMAGEFILE_KEY = @"profileImageFile";
static NSString * const USER_FULLNAME_KEY = @"fullName";
static NSString * const DETAILS_SEGUE_ID = @"displayDetails";


@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray <Post *> *previousPostsArray;

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.usernameLabel.text = PFUser.currentUser.username;
    self.nameLabel.text = PFUser.currentUser[USER_FULLNAME_KEY];
    
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self setUserProfileImage];
    [self collectionViewFormatting];
    
    
    [self userOnlyData];
    
    
}




- (void) setUserProfileImage
{
    
    PFFileObject *userProfileImageFile = [PFUser currentUser][USER_PROFILE_IMAGEFILE_KEY];
    
    self.profilePicImageView.file = userProfileImageFile;
    [self.profilePicImageView loadInBackground];
    
    self.profilePicImageView.layer.masksToBounds = true;
    self.profilePicImageView.layer.cornerRadius = self.profilePicImageView.frame.size.width/2;
    
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
    
    PFUser.currentUser[USER_PROFILE_IMAGEFILE_KEY] = [Post getPFFileFromImage:originalImage];
    [[PFUser currentUser] saveInBackground];
    
    PFFileObject *newProfileImageFile = [Post getPFFileFromImage:originalImage];
    
    self.profilePicImageView.file = newProfileImageFile;
    [self.profilePicImageView loadInBackground];
    
    // Do something with the images (based on your use case)
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (void) userOnlyData

{
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:POST_ORDERING_KEY];
    [postQuery includeKey:POST_AUTHOR_KEY];
    [postQuery whereKey:POST_AUTHOR_KEY equalTo:PFUser.currentUser];
    
    postQuery.limit = 20;

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





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:DETAILS_SEGUE_ID])
        
    {
        UICollectionViewCell *tappedItem = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedItem];
        Post *post = self.previousPostsArray[indexPath.row];
        DetailedViewViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
        
        NSLog(@"Tapping on a post");
        
    }
}




- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostedPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PREVIOUS_POST_CELL_ID forIndexPath:indexPath];
    
    Post *post = self.previousPostsArray[indexPath.item];
    
    [cell setImage:post];
    
    return cell;
    
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.previousPostsArray.count;
}


- (IBAction)editProfilePicButton:(id)sender {
    [self launchCamera];

}


@end
