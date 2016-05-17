//
//  popUpViewController.h
//  SocialSharing
//
//  Created by Kazi Sharmin Dina on 5/10/16.
//  Copyright © 2016 Kazi Sharmin Dina. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kOption       @"Option"
#define kClose        @"Close"
#define kPhotoLibrary @"Photo Library"
#define kTakePhoto    @"Take Photo"
#define kCell         @"Cell"

@interface PopUpViewController:UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) void(^didSelectedRowTableAction)(NSInteger index);
@property (copy, nonatomic) void(^closeAction)();

@end
