//
//  FeedCell.m
//  Instagram
//
//  Created by Catherine Lu on 6/27/22.
//

#import "FeedCell.h"
#import "Post.h"

@implementation FeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) updateUI {
    self.captionLabel.text = self.post.caption;
    PFFileObject *imageData = self.post.image;
    [imageData getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if(data) {
            self.postImageView.image = [UIImage imageWithData:data];
        }
        else {
            NSLog(@"bad image");
        }
    }];
}
@end
