//
//  ViewController.m
//  CountDown
//
//  Created by youyu on 2018/3/24.
//  Copyright © 2018年 com.morpx. All rights reserved.
//

#import "ViewController.h"
#import "CountDownButtonViewController.h"
#import "CountDownLabelViewController.h"
#import "CountDownCellViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"按钮倒计时";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Label倒计时";
    } else {
        cell.textLabel.text = @"Cell中的倒计时";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        CountDownButtonViewController *vc = [CountDownButtonViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        CountDownLabelViewController *vc = [CountDownLabelViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        CountDownCellViewController *vc = [CountDownCellViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}





@end
