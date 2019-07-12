//
//  ProfileViewController.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/11/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "PFImageView.h"
#import "PostedPicCell.h"
#import "Post.h"


@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *previousPostsArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameLabel.text = PFUser.currentUser.username;

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    
    
    CGFloat imagesPerLine = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (imagesPerLine - 1)) / imagesPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    
    layout.itemSize = CGSizeMake(itemWidth,itemHeight);
    
    [self userOnlyData];
    
    
    
}



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




- (IBAction)didTapImage:(id)sender {
    
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
