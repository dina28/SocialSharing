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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
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
    pickerfromPhotoLibrary = [[UIImagePickerController alloc] init];
    pickerfromPhotoLibrary.delegate = self;
    [pickerfromPhotoLibrary setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerfromPhotoLibrary animated:YES completion:NULL];
}

- (void)takePhoto {
    pickerfromCamera = [[UIImagePickerController alloc] init];
    pickerfromCamera.delegate = self;
    [pickerfromCamera setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:pickerfromCamera animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
