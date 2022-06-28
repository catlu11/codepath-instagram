//
//  FeedTableViewController.h
//  Instagram
//
//  Created by Catherine Lu on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedTableViewController : UIViewController
@property (strong, nonatomic) PFUser *forUser;
-(void)fetchPosts:(BOOL *)isMore;
@end

NS_ASSUME_NONNULL_END
