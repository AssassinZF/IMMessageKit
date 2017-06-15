//
//  ZFKeyboardInputView.h
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/14.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEIGHT_TABBAR 49
#define POP_H 215
#define CHATBOX_BUTTON_WIDTH 37
#define HEIGHT_TEXTVIEW HEIGHT_TABBAR * 0.74
#define SPACE 6
#define TEXTVIEW_BOTTPN_SPACE HEIGHT_TABBAR * 0.13
#define TEXT_LENGTH 5000 //文本限制最大长度

typedef NS_ENUM(NSInteger, ZFKeyboardStatus) {
    ZFKeyboardStatusNothing,     // 默认状态
    ZFKeyboardStatusShowVoice,   // 录音状态
    ZFKeyboardStatusShowFace,    // 输入表情状态
    ZFKeyboardStatusShowMore,    // 显示“更多”页面状态
    ZFKeyboardStatushowKeyboard,// 正常键盘
    ZFKeyboardStatusShowVideo    // 录制视频
};

typedef NS_ENUM(NSInteger,ZFKeyboardType) {
    ZFKeyboardTypeChat,//聊天使用
    ZFKeyboardTypeComment//评论使用
};

@class ZFKeyboardInputView;

@protocol ZFKeyboardInputViewDelegate <NSObject>

@required

/**
 返回当前的状态以及自身的高度

 @param keyboardView self
 @param currentH totalHeight
 */
-(void)changeKeyboardHeight:(ZFKeyboardInputView *)keyboardView currentH:(CGFloat)currentH;

//发送文本消息
-(void)sendTextMessage:(NSString *)textMessage;

@end



@interface ZFKeyboardInputView : UIView

@property (nonatomic, assign)id<ZFKeyboardInputViewDelegate>keyboardDelegate;

@property (nonatomic, assign ,readonly)ZFKeyboardType keyboardType;//键盘类型
@property (nonatomic, assign ,readonly)ZFKeyboardStatus keyboardStatus;//键盘状态

@property (nonatomic, assign) NSInteger maxTextLine;//最大显示行数 default 5 line


/**
 初始化方法

 @param keboardType 键盘类型 聊天 || 评论
 @return self
 */
-(instancetype)initWithKeyboardType:(ZFKeyboardType)keboardType;
@end
