//
//  SocialSharingViewController.h
//  SocialSharing
//
//  Created by Kazi Sharmin Dina on 5/10/16.
//  Copyright © 2016 Kazi Sharmin Dina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MJPopupViewController.h"
#import "popUpViewController.h"
#import <Social/Social.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface SocialSharingViewController:UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *setImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
