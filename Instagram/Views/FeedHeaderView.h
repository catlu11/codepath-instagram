//
//  FeedHeaderView.h
//  Instagram
//
//  Created by Catherine Lu on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) PFUser *user;
@end

NS_ASSUME_NONNULL_END
