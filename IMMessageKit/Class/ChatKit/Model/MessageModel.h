//
//  MessageModel.h
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageItem.h"

@interface MessageModel : NSObject
@property (nonatomic, strong)MessageItem *messageItem;

//layout
@property (nonatomic, assign,readonly)CGRect bubbleViewF;//聊天气泡frame
@property (nonatomic, assign,readonly)CGRect textContentF;//文字内容frame
@property (nonatomic, assign,readonly)CGRect indicateF;//指示viewframe
@property (nonatomic, assign,readonly)CGRect avatarViewF;//头像
@property (nonatomic, assign, readonly) CGRect activityF;//消息指示
@property (nonatomic, assign, readonly) CGRect retryButtonF;//重新发送按钮
@property (nonatomic, assign, readonly) CGRect dateLabelF;//发送时间label
@property (nonatomic, assign, readonly) CGRect nickNameF;//昵称位置

@property (nonatomic, assign ,readonly)CGFloat cellMax_H;//cell的总高度


@end
