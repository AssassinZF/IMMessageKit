//
//  MessageModel.h
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageItem;

@interface MessageModel : NSObject
@property (nonatomic, strong)MessageItem *messageItem;

//layout
@property (nonatomic, assign)CGRect bubbleViewF;//聊天气泡frame
@property (nonatomic, assign)CGRect textContentF;//文字内容frame
@property (nonatomic, assign)CGRect indicateF;//指示viewframe
@property (nonatomic, assign)CGRect avatarViewF;//头像

@end
