//
//  ProfileViewController.m
//  Instagram
//
//  Created by Catherine Lu on 6/28/22.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"

@interface ProfileViewController () 
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    self.forUser = [PFUser currentUser];
    [super viewDidLoad];
    
    self.usernameLabel.text = [PFUser currentUser].username;
    self.profileImageView.layer.cornerRadius = 0.5*self.profileImageView.frame.size.width;
    self.profileImageView.clipsToBounds = YES;
}
@end
