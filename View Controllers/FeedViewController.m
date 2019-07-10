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



@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *postsArray;
@property (weak, nonatomic) UIImage *capturedPic;



@end






@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.postsArray = posts;
        }
        else {
            NSLog(@"Was not able to load posts");
        }
    }];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}




- (IBAction)postButton:(id)sender {
    
    
}


- (IBAction)logoutButton:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        NSLog(@"User successfully logged out");
    }];
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginPageViewController *loginPageViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginPageViewController animated:YES completion:nil];
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Post *post = self.postsArray[indexPath.row];
    
    cell.post = post;
    
    cell.postCaption.text = post[@"caption"];
    [cell setPost:post];
    
    return cell;

}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}



@end
