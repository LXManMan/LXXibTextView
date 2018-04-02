//
//  LXKeyboardController.m
//  LXXibTextView
//
//  Created by 漫漫 on 2018/3/31.
//  Copyright © 2018年 漫漫. All rights reserved.
//


#import "LXKeyboardController.h"
#import "LXCustomTextView.h"
#import "UIView+Frame.h"

@interface LXKeyboardController ()
@property (weak, nonatomic) IBOutlet LXCustomTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomH;
@property(nonatomic,assign)BOOL isDisappear;

@end

@implementation LXKeyboardController
{
    CGFloat keyboardH;
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self  name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self  name:UIKeyboardDidChangeFrameNotification object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isDisappear = NO;
     [IQKeyboardManager sharedManager].enable = NO; //关闭
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isDisappear = YES;
    [IQKeyboardManager sharedManager].enable = YES; //开启

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"键盘自动增长";
    
    
    [self setup];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //        NSLog(@"%@",NSStyringFromCGRect(keyboardF));
   CGFloat keyboardY = keyboardF.origin.y;
    keyboardH =  keyboardF.size.height;
    
    
    if (!self.isDisappear) {
        [self dealKeyBoardWithKeyboardH:keyboardH keyboardY:keyboardY duration:duration];
    }

}
-(void)keyboardDidChangeFrame:(NSNotification *)notification{
    
    NSDictionary *userInfo = notification.userInfo;
   
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardY = keyboardF.origin.y;
    
    keyboardH =  keyboardF.size.height;
    
    if (self.isDisappear) {
         [self dealKeyBoardWithKeyboardH:keyboardH keyboardY:keyboardY duration:duration];
    }
   
    
}
#pragma mark---处理高度---
-(void)dealKeyBoardWithKeyboardH:(CGFloat)keyboardH keyboardY:(CGFloat)keyboardY duration:(CGFloat)duration{
    
    if (!self.isDisappear) {
        [UIView animateWithDuration:duration animations:^{
            // 工具条的Y值 == 键盘的Y值 - 工具条的高度
            
            if (keyboardY >= Device_Height) {
                self.bottomH.constant = 0;
            }else
            {
                self.bottomH.constant = keyboardH;
            }

        }];
    }else{
        if (keyboardY >= Device_Height) {
            self.bottomH.constant = 0;
        }else
        {
            self.bottomH.constant = keyboardH;
        }
    }
    
}

-(void)setup{
    self.textView.initiLine = 1;
    self.textView.maxLine = 3;
    self.textView.placeholder= @"请输入";
    
    self.textH.constant = self.textView.height;
    LXWS(weakSelf);
    self.textView.textHeightChangeBlock = ^(CGFloat height) {
        
        weakSelf.textH.constant = height;
        weakSelf.bottomH.constant = keyboardH;
        [weakSelf.view updateConstraints];
        [weakSelf.view updateConstraintsIfNeeded];
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf.view layoutIfNeeded];
        }];
    };
    
}


@end
