//
//  SocialSharingViewController.m
//  SocialSharing
//
//  Created by Kazi Sharmin Dina on 5/10/16.
//  Copyright © 2016 Kazi Sharmin Dina. All rights reserved.
//

#import "SocialSharingViewController.h"

@interface SocialSharingViewController () {
    bool flag;
}

@end

@implementation SocialSharingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    flag = NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)setImageButtonClick:(id)sender {
    PopUpViewController *controller = [[PopUpViewController alloc] initWithNibName:kPopUpViewController bundle:nil];
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
    flag = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)postOnFaceBook {
    SLComposeViewController *fbSLComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [fbSLComposeViewController addImage:self.imageView.image];
    [fbSLComposeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
        [self checkPostOrCancle:result fromMethod:kFaceBook];
    }];
    [self presentViewController:fbSLComposeViewController animated:YES completion:nil];
}

- (void)faceBookTextAlert {
    UIAlertController *messageController = [UIAlertController alertControllerWithTitle:kFaceBook message:kTextErrorOfFaceBook preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:kOK style:UIAlertActionStyleDefault handler: ^(UIAlertAction * action) {
        self.textField.text = @"";
        if (flag) {
            [self postOnFaceBook];
        }
    }];
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:kCancel style:UIAlertActionStyleDefault handler:nil];
    [messageController addAction:ok];
    [messageController addAction:Cancel];
    [self presentViewController:messageController animated:YES completion:nil];
}

- (IBAction)facebookButtonClick:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        if(self.textField.text.length > 0) {
            [self faceBookTextAlert];
            return;
        }
        if (!flag) {
            [self loadMessageWithTitle:kFaceBook message:kSelectImage];
        } else {
            [self postOnFaceBook];
        }
    } else {
        [self loadMessageWithTitle:kTitleForFaceBook message:kMessageForFaceBook];
    }
}

- (void)checkPostOrCancle:(NSInteger)result fromMethod:(NSString *)fromMethod {
    switch (result) {
        case SLComposeViewControllerResultCancelled:
            break;
        case SLComposeViewControllerResultDone: {
            self.textField.text = @"";
            self.imageView.image = [UIImage imageNamed:kImageName];
            if ([fromMethod isEqualToString:kFaceBook]) {
                [self loadMessageWithTitle:kFaceBook message:kSuccessForFaceBook];
            } else {
                [self loadMessageWithTitle:kTwitter message:kSuccessForTwitter];
            }
            flag = NO;
            break;
        }
    }
}

- (IBAction)twitterButtonClick:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        if (flag || (!flag && self.textField.text.length > 0)) {
            SLComposeViewController *twitterSLComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [twitterSLComposeViewController addImage:self.imageView.image];
            [twitterSLComposeViewController setInitialText:self.textField.text];
            [twitterSLComposeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
                [self checkPostOrCancle:result fromMethod:kTwitter];
            }];
            [self presentViewController:twitterSLComposeViewController animated:YES completion:nil];
        } else {
            [self loadMessageWithTitle:kTwitter message:kSelectImage];
        }
    } else {
        [self loadMessageWithTitle:kTitleForTwitter message:kMessageForTwitter];
    }
}

- (void)loadMessageWithTitle:(NSString *)title  message:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *messageController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [messageController addAction:ok];
        [self presentViewController:messageController animated:YES completion:nil];
    });
}

@end
