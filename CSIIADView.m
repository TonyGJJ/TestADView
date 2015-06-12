//
//  CSIIADView.m
//  szdevbank
//
//  Created by 刘杨 on 14-8-22.
//  Copyright (c) 2014年 csii. All rights reserved.
//

#import "CSIIADView.h"

@implementation CSIIADView 
{
    UIView      *_adView;
    UIControl   *overlayView;
    
    UIColor *LEFTCOLOR;
    UIView *background;
    
    UILabel *textLabel;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

- (instancetype)initSubView
{
    self = [super initWithFrame:CGRectMake(10, 10, UI_SCREEN_WIDTH, 400)];
    if (self) {
        overlayView = [[UIControl alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        [overlayView setBackgroundColor:[UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.8]];
        [overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        background = [[UIView alloc]initWithFrame:CGRectMake((UI_SCREEN_WIDTH - 300)/2, 0, 300, 250)];
        background.layer.cornerRadius = 3;
        [background setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:background];
        [self addTextView];
        [self addButton];
    }
    return self;
}

/**
 *  添加文字
 */
- (void)addTextView
{
    if (!textLabel) {
        NSString *str1 = @"用户您好，您的预约时间距刺客不足24小时，由于我们已为您预约了护工，所以您此时取消订单可能需要承担3%的违约费。\n\n详情查看《护工之家用户守则》,仍然取消吗？";
        NSString *str = @"《护工之家用户守则》";
        NSRange range = [str1 rangeOfString:str];
        NSMutableAttributedString *attre = [[NSMutableAttributedString alloc] initWithString:@"用户您好，您的预约时间距此刻不足24小时，由于我们已为您预约了护工，所以您此时取消订单可能需要承担3%的违约费。\n\n详情查看《护工之家用户守则》,仍然取消吗？"];
        [attre setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:20/255.0 green:160/255.0 blue:123/255.0 alpha:1]} range:range];
        textLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, background.frame.size.width - 30, 130)];
        textLabel.font = [UIFont systemFontOfSize:15];
        textLabel.numberOfLines = 0;
        textLabel.attributedText = attre;
        [background addSubview:textLabel];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setFrame:CGRectMake(65, 85, 140, 30)];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [textLabel addSubview:button];
    }
}

- (void)buttonAction
{
    if ([self.adDelegate respondsToSelector:@selector(lookProtocol)]) {
        [self.adDelegate lookProtocol];
    }
}

/**
 *  添加按钮
 */
- (void)addButton
{
    UIButton *cencelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cencelButton setTitle:@"不了" forState:UIControlStateNormal];
    [cencelButton setTitleColor:[UIColor colorWithRed:20/255.0 green:160/255.0 blue:123/255.0 alpha:1] forState:UIControlStateNormal];
    cencelButton.layer.cornerRadius = 2;
    
    [cencelButton setFrame:CGRectMake((background.frame.origin.x + 140) , 205, 60, 30)];
    cencelButton.tag = 2000;
    cencelButton.layer.borderColor = [UIColor colorWithRed:20/255.0 green:160/255.0 blue:123/255.0 alpha:1].CGColor;
    cencelButton.layer.borderWidth = 0.5;

    [cencelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:cencelButton];
    
    UIButton *passButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [passButton setTitle:@"取消订单" forState:UIControlStateNormal];
    [passButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [passButton setBackgroundColor:[UIColor colorWithRed:20/255.0 green:160/255.0 blue:123/255.0 alpha:1]];
    
    [passButton setFrame:CGRectMake( (background.frame.origin.x + 20) , 205, 100, 30)];
    passButton.tag = 1000;
    passButton.layer.cornerRadius = 2;
    [passButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:passButton];
}

- (void)buttonAction:(UIButton *)sender
{
    
    if (sender.tag == 1000) {
        //确定
        [self dismiss];
        if ([self.adDelegate respondsToSelector:@selector(endButton)]) {
            [self.adDelegate endButton];
        }
    } else {
        //取消
        [self dismiss];
    }
}

- (void)dismiss
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:overlayView];
    [keywindow addSubview:self];
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f, 300);
    [self fadeIn];
}

#pragma mark -animations
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
