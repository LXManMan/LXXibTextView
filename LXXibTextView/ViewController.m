//
//  ViewController.m
//  LXXibTextView
//
//  Created by 漫漫 on 2018/3/31.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "ViewController.h"
#import "LXKeyboardController.h"
#import "LXCellTextTableViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataA;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"LXCustomTextView";
    [IQKeyboardManager sharedManager].enable = YES; //开启
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO; //辅助键盘关闭
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 5; //
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES; //
    
    self.dataA = @[@"键盘自动增长",@"cell xib中的textView自适应"];
    [self.view addSubview:self.tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataA.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataA[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        LXKeyboardController *nextVc =[[LXKeyboardController alloc]init];
        [self.navigationController pushViewController:nextVc animated:YES];
    }
    if (indexPath.row == 1) {
        LXCellTextTableViewController *nextVc =[[LXCellTextTableViewController alloc]init];
        [self.navigationController pushViewController:nextVc animated:YES];
    }
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
