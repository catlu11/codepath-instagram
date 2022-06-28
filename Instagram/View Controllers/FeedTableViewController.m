//
//  FeedTableViewController.m
//  Instagram
//
//  Created by Catherine Lu on 6/28/22.
//

#import "FeedTableViewController.h"
#import "DetailsViewController.h"
#import "FeedCell.h"
#import "Parse/Parse.h"

@interface FeedTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) int *numPostsTotal;
@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.feedTableView.dataSource = self;
    self.feedTableView.delegate = self;
    self.feedTableView.rowHeight = UITableViewAutomaticDimension;
    
    // Refresh setup
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.feedTableView insertSubview:self.refreshControl atIndex:0];
    
    [self fetchPosts:NO];
    
}

- (void) fetchPosts:(BOOL *)isMore {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    if(isMore) {
        Post *lastPost = self.arrayOfPosts[self.arrayOfPosts.count - 1];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createdAt < %@", lastPost.createdAt];
        query = [PFQuery queryWithClassName:@"Post" predicate:predicate];
    }
    [query includeKey:@"image"];
    [query includeKey:@"author"];
    [query includeKey:@"caption"];
    [query includeKey:@"likeCount"];
    [query includeKey:@"commentCount"];
    [query includeKey:@"createdAt"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    
    // update posts counts
    [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (error) {
            NSLog(@"something bad happened");
        }
        else {
            self.numPostsTotal = number;
        }
        // fetch data asynchronously after counts fetched
        [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
            if (posts != nil) {
                if(isMore) {
                    for(Post *pst in posts) {
                        [self.arrayOfPosts addObject:pst];
                    }
                }
                else {
                    self.arrayOfPosts = posts;
                }
                [self.feedTableView reloadData];
                [self.refreshControl endRefreshing];
            } else {
                NSLog(@"%@", error.localizedDescription);
            }
        }];
    }];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchPosts:NO];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell" forIndexPath:indexPath];
    cell.postDetailsView.post = [Post postFromPFObject:self.arrayOfPosts[indexPath.row]];
    [cell updateUI];
    
    // If bottom, start infinite scrolling
    if(indexPath.row == self.arrayOfPosts.count - 1 && self.arrayOfPosts.count >= 20 && self.arrayOfPosts.count < self.numPostsTotal) {
        [self fetchPosts:YES];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = self.navigationController;
    DetailsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    viewController.view;
    viewController.postDetailsView.post = [Post postFromPFObject:self.arrayOfPosts[indexPath.row]];
    [viewController.postDetailsView updateUIWithDetails];
    [navigationController pushViewController: viewController animated:YES];
}

@end
