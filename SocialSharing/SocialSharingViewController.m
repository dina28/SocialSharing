//
//  SocialSharingViewController.m
//  SocialSharing
//
//  Created by Kazi Sharmin Dina on 5/10/16.
//  Copyright © 2016 Kazi Sharmin Dina. All rights reserved.
//

#import "SocialSharingViewController.h"

@interface SocialSharingViewController () {
    UIImagePickerController *pickerfromPhotoLibrary;
    UIImagePickerController *pickerfromCamera;
    UIImage *image;
}

@end

@implementation SocialSharingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)setImageButtonClick:(id)sender {
    popUpViewController *controller = [[popUpViewController alloc] initWithNibName:@"popUpViewController" bundle:nil];
    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    controller.didSelectedRowTableAction = ^(NSInteger index) {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        if (index == 0) {
            [self chooseExisting];
        } else {
            [self takePhoto];
        }
    };
    controller.closeAction = ^() {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    [self presentPopupViewController:controller animationType:MJPopupViewAnimationFade];
}

- (void)chooseExisting {
}

- (void)takePhoto {
    pickerfromCamera = [[UIImagePickerController alloc] init]];
}

@end
