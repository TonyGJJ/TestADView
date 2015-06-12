//
//  CSIIADView.h
//  szdevbank
//
//  Created by 刘杨 on 14-8-22.
//  Copyright (c) 2014年 csii. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSIIADView;
@protocol CSIIADViewDelegate <NSObject>

- (void)endButton;
- (void)lookProtocol;

@end

@interface CSIIADView : UIView <UITextViewDelegate>

@property (nonatomic,assign) id<CSIIADViewDelegate>adDelegate;
- (instancetype)initSubView;
- (void)show;

@end
