//
//  FeedCell.h
//  Instagram
//
//  Created by Catherine Lu on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "DetailsView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet DetailsView *postDetailsView;
-(void) updateUI;
@end

NS_ASSUME_NONNULL_END
