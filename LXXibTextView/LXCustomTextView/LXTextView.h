//
//  LXTextView.h
//  UITextViewPlaceholderView
//
//  Created by idMac2 on 16/1/21.
//  Copyright © 2016年 idMac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@property(nonatomic,assign)CGPoint placePoint;//占位符的文字位置
@end

