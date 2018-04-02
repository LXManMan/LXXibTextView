//
//  LXCellTextTableViewController.m
//  LXXibTextView
//
//  Created by 漫漫 on 2018/3/31.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LXCellTextTableViewController.h"
#import "MyCell.h"

@interface LXCellTextTableViewController ()

@end

@implementation LXCellTextTableViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = YES; //开启
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"cell xib中的textView自适应";
    
    self.tableView.rowHeight= UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight= 0.01;
    self.tableView.tableFooterView =[UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell =[[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = 0;
    // Configure the cell...
    
    return cell;
}



@end
