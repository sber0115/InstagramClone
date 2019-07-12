//
//  FeedViewController.m
//  InstagramClone
//
//  Created by sbernal0115 on 7/9/19.
//  Copyright © 2019 sbernal0115. All rights reserved.
//

#import "FeedViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "LoginPageViewController.h"
#import "Post.h"
#import "ComposeViewController.h"
#import "PostCell.h"
#import "DetailedViewViewController.h"




@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *postsArray;
@property (weak, nonatomic) UIImage *capturedPic;
@property (assign, nonatomic) BOOL isMoreDataLoading;


@end






@implementation FeedViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    [self refreshData];
    
}


//
////have to this method to make it clearer
////that this is handling refreshing as user scrolls
//-(void)loadMoreData{
//
//    // construct PFQuery
//    PFQuery *morePostsQuery = [Post query];
//    [morePostsQuery orderByDescending:@"createdAt"];
//    [morePostsQuery includeKey:@"author"];
//
//
//
//    //here I am filtering the posts retrieved with their creation date
//    //when user scrolls enough, the posts that are older than the last
//    //current post in view are loaded into the postsArray
//
//    Post *finalPost = [self.postsArray objectAtIndex:self.postsArray.count-1];
//    NSDate *finalPostDate = finalPost.createdAt;
//
//    [morePostsQuery whereKey:@"createdAt" lessThan:finalPostDate];
//
//    //wherekey -->  created at less than
//    // get the date of the last post --> array indexing
//
//    // fetch data asynchronously
//    [morePostsQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
//        if (posts) {
//            [self.postsArray addObjectsFromArray:posts];
//
//            [self.tableView reloadData];
//
//
//        }
//        else {
//            NSLog(@"There are no more posts to load");
//        }
//
//    }];
//
//    self.isMoreDataLoading = false;
//
//
//}
//
//
//
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if(!self.isMoreDataLoading){
//
//        // Calculate the position of one screen length before the bottom of the results
//        int scrollViewContentHeight = self.tableView.contentSize.height;
//        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
//
//        // When the user has scrolled past the threshold, start requesting
//        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
//            self.isMoreDataLoading = true;
//            [self loadMoreData];
//
//
//        }
//
//    }
//}
//
//
//
//
//
//
//
// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    [self refreshData];
    [refreshControl endRefreshing];

}

//
//
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"displayDetails"])

    {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.postsArray[indexPath.row];

        DetailedViewViewController *detailsViewController = [segue destinationViewController];

        detailsViewController.post = post;

        NSLog(@"Tapping on a post");


    }


}





- (void) refreshData

{
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    
    //wherekey -->  created at less than
    // get the date of the last post --> array indexing
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.postsArray = [[NSMutableArray alloc] initWithArray:posts];
            
            [self.tableView reloadData];
            
            
        }
        else {
            NSLog(@"Was not able to load posts");
        }
        
    }];
    
}








- (IBAction)logoutButton:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        NSLog(@"User successfully logged out");
    }];
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginPageViewController *loginPageViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginPageViewController animated:YES completion:nil];
    
}

- (IBAction)composeButton:(id)sender {
}




- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Post *post = self.postsArray[indexPath.row];
    
    NSLog(@"%d", indexPath.row);
    
    cell.post = post;
    
    
    [cell makePost:post];
    
//    cell.textLabel.text = post.caption;
    
    return cell;

}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"calling number of row");
    return self.postsArray.count;
}



@end
