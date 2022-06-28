//
//  FeedCell.m
//  Instagram
//
//  Created by Catherine Lu on 6/27/22.
//

#import "FeedCell.h"

@implementation FeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) updateUI {
    [self.postDetailsView updateUIBasic];
}
@end
