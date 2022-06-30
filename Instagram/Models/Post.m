
//  Post.m
#import "Post.h"
#import "Parse/Parse.h"

@implementation Post
    
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic timestamp;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (Post *) postFromPFObject:(PFObject *)obj {
    Post *newPost = [Post new];
    newPost.image = obj[@"image"];
    newPost.author = obj[@"author"];
    newPost.caption = obj[@"caption"];
    newPost.likeCount = obj[@"likeCount"];
    newPost.commentCount = obj[@"commentCount"];
    newPost.timestamp = obj.createdAt;
    return newPost;
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded) {
            PFObject *postLikes = [PFObject objectWithClassName:@"Likes"];
            [postLikes setObject:newPost forKey:@"PostPointer"];
            [postLikes saveInBackground];
            completion(succeeded, nil);
        }
        else {
            completion(nil, error);
        }
    }];

}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
