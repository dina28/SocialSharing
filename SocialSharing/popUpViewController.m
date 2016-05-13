//
//  popUpViewController.m
//  SocialSharing
//
//  Created by Kazi Sharmin Dina on 5/10/16.
//  Copyright © 2016 Kazi Sharmin Dina. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth(self.tableView.frame), 44.f)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 30.f)];
    [headerView addSubview:headerLabel];
    headerLabel.center = CGPointMake(CGRectGetWidth(headerView.frame)/2, CGRectGetHeight(headerView.frame)/2);
    headerLabel.text = kOption;
    headerLabel.numberOfLines = 1;
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = [UIColor blackColor];
    self.tableView.tableHeaderView = headerView;
    if (!self.tableView.tableFooterView) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, CGRectGetWidth(self.tableView.frame), 44.f)];
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 30.f)];
        [footerView addSubview:closeButton];
        closeButton.center = CGPointMake(CGRectGetWidth(footerView.frame)/2, CGRectGetHeight(footerView.frame)/2);
        [closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTitle:kClose forState:UIControlStateNormal];
        closeButton.backgroundColor = [UIColor blueColor];
        self.tableView.tableFooterView = footerView;
    }
}

- (void)closeAction:(id)sender {
    self.closeAction();
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifer = kCell;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = kPhotoLibrary;
    } else {
        cell.textLabel.text = kTakePhoto;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectedRowTableAction) {
        self.didSelectedRowTableAction(indexPath.row);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
