//
//  ConversationModel.h
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

//聊天会话类

#import <Foundation/Foundation.h>

//会话类型
typedef NS_ENUM(NSInteger,ConversationType) {
    ConversationTypeSingleChat,//单聊
    ConversationTypeGroupChat,//群聊
};

@interface ConversationModel : NSObject

@property (nonatomic, copy)NSString *identifier;

@property (nonatomic, assign)NSInteger conversationID;//会话ID

@property (nonatomic, copy)NSString *conversationName;//会话显示名称

@property (nonatomic, strong)NSMutableArray <NSString *> *imageUrlString;//头像数组 单聊该数组只有一个值

@property (nonatomic, assign)ConversationType cahtType;

@property (nonatomic, assign) int unReadCount;// 组的未读数

@property (nonatomic, assign) int isTop;//是否置顶

@property (nonatomic, copy) NSString * lastMsgString;//最后一条消息

@property (nonatomic, assign) NSInteger lastMsgTime;// 最后一条消息时间戳







@end
