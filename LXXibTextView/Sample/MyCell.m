//
//  MyCell.m
//  LXXibTextView
//
//  Created by 漫漫 on 2018/3/31.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "MyCell.h"
#import "LXCustomTextView.h"

@interface MyCell()
@property (weak, nonatomic) IBOutlet LXCustomTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewH;
@end
@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.textView.initiLine = 1;
    self.textView.maxLine = 3;
    self.textView.placeholder= @"请输入";
    
    
    self.textViewH.constant = self.textView.height;
    
    LXWS(weakSelf);
    self.textView.textHeightChangeBlock = ^(CGFloat height) {
        
        weakSelf.textViewH.constant = height;
        
        [weakSelf.contentView updateConstraints];
        [weakSelf.contentView updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf.contentView layoutIfNeeded];
        }];
        UITableView *tableView = [weakSelf tableView];
        [tableView beginUpdates];
        [tableView endUpdates];
      
    };
}
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
