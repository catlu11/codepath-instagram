//
//  DetailsView.m
//  Instagram
//
//  Created by Catherine Lu on 6/28/22.
//

#import "DetailsView.h"

@implementation DetailsView

-(void) updateUIWithDetails {
    [self updateUIBasic];
    
    // unhide details elements
    self.timestampLabel.hidden = NO;
    self.likeButton.hidden = NO;
    self.commentButton.hidden = NO;
    self.usernameLabel.hidden = NO;
    
    self.usernameLabel.text = self.post.author.username;
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"%@", self.post.likeCount] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%@", self.post.commentCount] forState:UIControlStateNormal];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:self.post.timestamp];
    self.timestampLabel.text = stringFromDate;
}

-(void) updateUIBasic {
    // hide details elements
    self.timestampLabel.hidden = YES;
    self.likeButton.hidden = YES;
    self.commentButton.hidden = YES;
    self.usernameLabel.hidden = YES;
    
    self.captionLabel.text = self.post.caption;
    PFFileObject *imageData = self.post.image;
    [imageData getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if(data) {
            NSLog(@"successfully fetched image");
            self.postImageView.image = [UIImage imageWithData:data];
        }
        else {
            NSLog(@"bad image");
        }
    }];
}

@end
