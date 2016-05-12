//
//  SocialSharingViewController.m
//  SocialSharing
//
//  Created by Kazi Sharmin Dina on 5/10/16.
//  Copyright © 2016 Kazi Sharmin Dina. All rights reserved.
//

#import "SocialSharingViewController.h"

@interface SocialSharingViewController ()

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
    UIImagePickerController *pickerfromPhotoLibrary = [[UIImagePickerController alloc] init];
    pickerfromPhotoLibrary.delegate = self;
    [pickerfromPhotoLibrary setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerfromPhotoLibrary animated:YES completion:nil];
}

- (void)takePhoto {
    UIImagePickerController *pickerfromCamera = [[UIImagePickerController alloc] init];
    pickerfromCamera.delegate = self;
    [pickerfromCamera setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:pickerfromCamera animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)facebookButtonClick:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbSLComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSLComposeViewController addImage:self.imageView.image];
        [fbSLComposeViewController setInitialText:self.textField.text];
        [self presentViewController:fbSLComposeViewController animated:YES completion:nil];
    } else {
        [self loadMessageWithTitle:@"Facebook Unavailable" message:@"Sorry, we're unable to find a Facebook account on your device.\nPlease setup an account in your devices settings and try again."];
    }
}

- (IBAction)twitterButtonClick:(id)sender {
   if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *twitterSLComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitterSLComposeViewController addImage:self.imageView.image];
        [twitterSLComposeViewController setInitialText:self.textField.text];
        [self presentViewController:twitterSLComposeViewController animated:YES completion:nil];
    } else {
        [self loadMessageWithTitle:@"Twitter Unavailable" message:@"Sorry, we're unable to find a Twitter account on your device.\nPlease setup an account in your devices settings and try again."];
    }
}

- (void)loadMessageWithTitle:(NSString *)title  message:(NSString *)message {
    UIAlertController *messageController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [messageController addAction:ok];
    [self presentViewController:messageController animated:YES completion:nil];
}

@end
