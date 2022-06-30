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
#import "FeedHeaderView.h"

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
    
    UINib *headerNib = [UINib nibWithNibName:@"FeedHeaderView" bundle:nil];
    [self.feedTableView registerNib:headerNib forHeaderFooterViewReuseIdentifier:@"FeedHeaderView"];

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
    if (self.forUser) {
        [query whereKey:@"author" equalTo:self.forUser];
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
    cell.postDetailsView.post = [Post postFromPFObject:self.arrayOfPosts[indexPath.section]];
    [cell updateUI];
    
    // If bottom, start infinite scrolling
    if(indexPath.section == self.arrayOfPosts.count - 1 && self.arrayOfPosts.count >= 20 && self.arrayOfPosts.count < self.numPostsTotal) {
        [self fetchPosts:YES];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-
(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayOfPosts.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FeedHeaderView *header = (FeedHeaderView *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FeedHeaderView"];
    Post *post = [Post postFromPFObject:self.arrayOfPosts[section]];
                  
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:post.timestamp];
    
    header.usernameLabel.text = post.author.username;
    header.dateLabel.text = stringFromDate;
    header.profilePictureView.layer.cornerRadius = 0.5*header.profilePictureView.frame.size.width;
    header.profilePictureView.clipsToBounds = YES;
    PFFileObject *profileImg = post.author[@"profileImage"];
    [profileImg getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (data) {
            header.profilePictureView.image = [UIImage imageWithData:data];
        }
    }];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *navigationController = self.navigationController;
    DetailsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    viewController.view;
    viewController.postDetailsView.post = [Post postFromPFObject:self.arrayOfPosts[indexPath.section]];
    [viewController.postDetailsView updateUIWithDetails];
    [navigationController pushViewController: viewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

@end
