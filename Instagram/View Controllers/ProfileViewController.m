//
//  ProfileViewController.m
//  Instagram
//
//  Created by Catherine Lu on 6/28/22.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"

@interface ProfileViewController ()  <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [self updateUI];
    [super viewDidLoad];
}

- (void) updateUI {
    if(self.feedUser == nil) {
        self.feedUser = [PFUser currentUser];
        [self.profileImageView setUserInteractionEnabled:YES];
    }
    else {
        [self.profileImageView setUserInteractionEnabled:NO];
    }
    
    self.usernameLabel.text = self.feedUser.username;
    PFFileObject *profileImg = self.feedUser[@"profileImage"];
    [profileImg getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (data) {
            self.profileImageView.image = [UIImage imageWithData:data];
        }
    }];
    self.profileImageView.layer.cornerRadius = 0.5*self.profileImageView.frame.size.width;
    self.profileImageView.clipsToBounds = YES;
    
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    
    UITapGestureRecognizer *profileTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfilePicture)];
    [self.profileImageView addGestureRecognizer:profileTap];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    PFFileObject *pfImage = [PFFileObject fileObjectWithName:@"image.png" data:UIImagePNGRepresentation(editedImage)];
    
    // upload to database
    [[PFUser currentUser] setObject:pfImage forKey:@"profileImage"];
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"successfully uploaded profile picture");
            self.profileImageView.image = editedImage;
        }
        else {
            NSLog(@"failed to upload profile picture");
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) tapProfilePicture {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

@end
