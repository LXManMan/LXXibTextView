//
//  LXCustomTextView.m
//  LXXibTextView
//
//  Created by 漫漫 on 2018/3/31.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LXCustomTextView.h"
#import "UIView+Frame.h"
#import "LXTextView.h"

@interface LXCustomTextView()<UITextViewDelegate>
@property(nonatomic,strong)LXTextView *textView;

@end
@implementation LXCustomTextView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder: aDecoder];
    if (self) {
        
        [self initilize];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initilize];
    }
    return self;
}
//初始化
-(void)initilize{
    
    self.h_margin  = 0;
    self.v_margin = 10;
    
    self.initiLine = 1;
    self.maxLine = INT_MAX;
    
    self.font = [UIFont systemFontOfSize:17];
    
    [self addSubview:self.textView];
    
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 1.5;
    self.layer.borderColor =[UIColor hexStringToColor:@"cecece"].CGColor;

}
-(void)textViewDidChange:(UITextView *)textView{
    
    
    //内容高度
    CGFloat contentSizeH = self.textView.contentSize.height;
    
    
    //最大高度
    CGFloat maxHeight = ceil(self.font.lineHeight * self.maxLine);
    
    //初始高度
    CGFloat initiTextViewHeight = ceilf(self.initiLine *self.font.lineHeight);
    if (contentSizeH <= maxHeight) {
        
        if (contentSizeH <= initiTextViewHeight) {
            self.textView.height = initiTextViewHeight;
        }else{
            self.textView.height = contentSizeH;
        }
        
        
    }else{
        self.textView.height = maxHeight;
    }
    
    self.height = self.textView.height + 2 * self.v_margin;
    
    if (self.textHeightChangeBlock) {
        self.textHeightChangeBlock(self.height);
    }
    [textView scrollRangeToVisible:NSMakeRange(textView.selectedRange.location, 1)];
    
    
}

-(void)setMaxLine:(NSInteger)maxLine{
    _maxLine = maxLine;
    
}
-(void)setH_margin:(CGFloat)h_margin{
    _h_margin = h_margin;
    [self updateTextViewFrame];
}
-(void)setV_margin:(CGFloat)v_margin{
    _v_margin = v_margin;
    [self updateTextViewFrame];

}
-(void)setInitiLine:(NSInteger)initiLine{
    _initiLine = initiLine;
    [self updateTextViewFrame];

}
-(void)setFont:(UIFont *)font{
    _font = font;
    self.textView.font = font;
    [self updateTextViewFrame];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.textView.width = self.frame.size.width - 2 *self.h_margin;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
}
-(void)updateTextViewFrame{
    self.textView.frame =  CGRectMake(self.h_margin, self.v_margin, self.frame.size.width - 2 *self.h_margin, ceilf(self.initiLine *self.font.lineHeight));
    self.height = self.v_margin *2 + ceilf(self.initiLine *self.font.lineHeight);
}
-(void)setPlacePoint:(CGPoint)placePoint{
    _placePoint = placePoint;
    self.textView.placePoint = placePoint;
}
-(LXTextView *)textView{
    if (!_textView) {
        _textView =[[LXTextView alloc]initWithFrame:CGRectMake(self.h_margin, self.v_margin, self.frame.size.width - 2 *self.h_margin,  self.initiLine *self.font.lineHeight)];
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.delegate = self;
        _textView.placeholder = @"请输入";
    }
    return _textView;
}

@end
