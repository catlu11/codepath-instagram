//
//  DetailsViewController.m
//  Instagram
//
//  Created by Catherine Lu on 6/27/22.
//

#import "DetailsViewController.h"
#import "DetailsView.h"
#import "ProfileViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.postDetailsView updateUIWithDetails];
    
    UITapGestureRecognizer *profileTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUsername:)];
    [self.postDetailsView.usernameLabel addGestureRecognizer:profileTapGesture];
    [self.postDetailsView.usernameLabel setUserInteractionEnabled: YES];
}

- (void) tapUsername:(UITapGestureRecognizer *)tapGesture {
    UINavigationController *navigationController = self.navigationController;
    ProfileViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    viewController.feedUser = self.postDetailsView.post.author;
    viewController.view;
    [viewController updateUI];
    [navigationController pushViewController: viewController animated:YES];
}

@end
