//
//  ComposeViewController.m
//  Instagram
//
//  Created by Catherine Lu on 6/27/22.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imagePreviewView;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@property (strong, nonatomic) UIImage *selectedImage;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
}

- (IBAction)selectFromCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        [self selectFromLibrary:sender];
    }
}

- (IBAction)selectFromLibrary:(id)sender {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    self.imagePreviewView.image = editedImage;
    self.selectedImage = editedImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)postAction:(id)sender {
    if(self.selectedImage != nil) {
        UIImage *img = self.selectedImage;
        NSString *caption = self.captionTextView.text;
        
        [Post postUserImage:img withCaption:caption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if(succeeded) {
                NSLog(@"Successfully posted to Instagram");
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                NSLog(@"Error in posting");
            }
        }];
    }
}

- (IBAction)cancelAction:(id)sender {
}

@end
