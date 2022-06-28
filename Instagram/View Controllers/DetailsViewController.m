//
//  DetailsViewController.m
//  Instagram
//
//  Created by Catherine Lu on 6/27/22.
//

#import "DetailsViewController.h"
#import "DetailsView.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.postDetailsView updateUIWithDetails];
}

@end
