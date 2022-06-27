//
//  HomeViewController.m
//  Instagram
//
//  Created by Catherine Lu on 6/27/22.
//

#import "SceneDelegate.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "FeedCell.h"
#import "Parse/Parse.h"

@interface HomeViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (strong, nonatomic) NSArray *arrayOfPosts;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.feedTableView.dataSource = self;
}

- (IBAction)logoutUser:(id)sender {
    SceneDelegate *appDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        NSLog(@"Successfully logged out");
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell" forIndexPath:indexPath];
    cell.post = self.arrayOfPosts[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

@end
