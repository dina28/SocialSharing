//
//  popUpViewController.h
//  SocialSharing
//
//  Created by Kazi Sharmin Dina on 5/10/16.
//  Copyright © 2016 Kazi Sharmin Dina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popUpViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) void(^didSelectedRowTableAction)(NSInteger index);
@property (copy, nonatomic) void(^closeAction)();

@end
