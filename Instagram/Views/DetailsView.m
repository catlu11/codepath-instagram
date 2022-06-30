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
    
//    [self.likeButton setTitle:[NSString stringWithFormat:@"%@", self.post.likeCount] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%@", self.post.commentCount] forState:UIControlStateNormal];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:self.post.timestamp];
    self.timestampLabel.text = stringFromDate;
    
    // TODO: Get number of liked users for the post and check if currentUser is in it
    PFQuery *query = [PFQuery queryWithClassName:@"Likes"];
    [query whereKey:@"PostPointer" equalTo:self.pfPost];
    [query includeKey:@"likedByUsers"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if(error) {
            [self.likeButton setTitle:[NSString stringWithFormat:@"%i", 0] forState:UIControlStateNormal];
        }
        else {
            PFRelation *relation = object[@"likedByUsers"];
            PFQuery *usersQuery = [relation query];
            [usersQuery includeKey:@"objectId"];
            [usersQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                if(error) {
                    NSLog(@"bad relation query");
                }
                else {
                    NSLog(@"good relation query");
                    for(PFObject *obj in objects) {
                        if([obj.objectId isEqual:[PFUser currentUser].objectId]) {
                            self.likeButton.tintColor = [UIColor systemPinkColor];
                        }
                    }
                    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", objects.count] forState:UIControlStateNormal];
                }
            }];
        }
    }];
    
    [self.likeButton addTarget:self action:@selector(didLike) forControlEvents:UIControlEventTouchUpInside];
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

- (void) didLike {
    NSLog(@"tapped like button");
    PFQuery *query = [PFQuery queryWithClassName:@"Likes"];
    [query whereKey:@"PostPointer" equalTo:self.pfPost];
    [query includeKey:@"likedByUsers"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if(error) {
            NSLog(@"bad like query");
        }
        else {
            PFRelation *relation = [object relationForKey:@"likedByUsers"];
            int numLikes = [self.likeButton.titleLabel.text intValue];
            NSLog(@"%i", numLikes);
            if([self.likeButton.tintColor isEqual:[UIColor systemPinkColor]]) {
                [relation removeObject:[PFUser currentUser]];
                numLikes -= 1;
                self.likeButton.tintColor = [UIColor systemGrayColor];
            }
            else {
                [relation addObject:[PFUser currentUser]];
                numLikes += 1;
                self.likeButton.tintColor = [UIColor systemPinkColor];
            }
            [object saveInBackground];
            NSLog(@"%i", numLikes);
            [self.likeButton setTitle:[NSString stringWithFormat:@"%i", numLikes] forState:UIControlStateNormal];
        }
    }];
}

@end
