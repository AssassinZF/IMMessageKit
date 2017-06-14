//
//  ZFKeyboardInputView.h
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/14.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEIGHT_TABBAR 49
#define CHATBOX_BUTTON_WIDTH 37
#define HEIGHT_TEXTVIEW HEIGHT_TABBAR * 0.74
#define SPACE 6
#define TEXTVIEW_BOTTPN_SPACE HEIGHT_TABBAR * 0.13



typedef NS_ENUM(NSInteger,ZFKeyboardType) {
    ZFKeyboardTypeChat,//聊天使用
    ZFKeyboardTypeComment//评论使用
};


@interface ZFKeyboardInputView : UIView
@property (nonatomic, assign ,readonly)ZFKeyboardType keyboardType;
-(instancetype)initWithKeyboardType:(ZFKeyboardType)keboardType;
@end
