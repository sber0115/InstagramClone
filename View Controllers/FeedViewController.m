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



static NSString * const POST_ORDER_KEY = @"createdAt";
static NSString * const POST_AUTHOR_KEY = @"author";
static NSString * const DETAILS_SEGUE_ID = @"displayDetails";
static NSString * const MAIN_STORYBOARD_ID = @"Main";
static NSString * const LOGIN_VIEW_ID = @"LoginViewController";



@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *postsArray;
@property (weak, nonatomic) UIImage *capturedPicImage;
@property (assign, nonatomic) BOOL isMoreDataLoadingBool;
@end


@implementation FeedViewController


- (void) refreshData

{
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:POST_ORDER_KEY];
    [postQuery includeKey:POST_AUTHOR_KEY];
    postQuery.limit = 20;
    
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


- (void)viewDidAppear:(BOOL)animated
{
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    [self refreshData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    [self refreshData];
    [refreshControl endRefreshing];

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:DETAILS_SEGUE_ID])

    {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.postsArray[indexPath.row];

        DetailedViewViewController *detailsViewController = [segue destinationViewController];

        detailsViewController.post = post;

        NSLog(@"Tapping on a post");

    }

}


- (IBAction)logoutButton:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        NSLog(@"User successfully logged out");
    }];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN_STORYBOARD_ID bundle:nil];
    LoginPageViewController *loginPageViewController = [storyboard instantiateViewControllerWithIdentifier:LOGIN_VIEW_ID];
    [self presentViewController:loginPageViewController animated:YES completion:nil];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Post *post = self.postsArray[indexPath.row];
    cell.post = post;
    [cell makePost:post];
    return cell;

}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}



@end
