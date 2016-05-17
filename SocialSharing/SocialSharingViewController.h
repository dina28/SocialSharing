//
//  SocialSharingViewController.h
//  SocialSharing
//
//  Created by Kazi Sharmin Dina on 5/10/16.
//  Copyright © 2016 Kazi Sharmin Dina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MJPopupViewController.h"
#import "PopUpViewController.h"
#import <Social/Social.h>
#import <MobileCoreServices/MobileCoreServices.h>
#define kMessageForFaceBook  @"Sorry, we're unable to find a Facebook account on your device.\nPlease setup an account in your devices settings and try again."
#define kMessageForTwitter   @"Sorry, we're unable to find a Twitter account on your device.\nPlease setup an account in your devices settings and try again."
#define kTitleForFaceBook    @"FaceBook Unavailable"
#define kTitleForTwitter     @"Twitter Unavailable"
#define kImageName           @"images.png"
#define kSuccessForFaceBook  @"Successfully posted on FaceBook."
#define kSuccessForTwitter   @"Successfully posted on Twitter."
#define kFailed              @"Failed"
#define kFaceBook            @"FaceBook"
#define kTwitter             @"Twitter"
#define kSelectImage         @"Please select Image"
#define kTextErrorOfFaceBook @"Text message can not be posted on FaceBook."
#define kPopUpViewController @"PopUpViewController"
#define kOK                  @"OK"
#define kCancel              @"Cancel"

@interface SocialSharingViewController:UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *setImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
