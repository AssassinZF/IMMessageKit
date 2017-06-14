//
//  MessageItem.h
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MessageSendState) {
    ICMessageDeliveryState_Pending = 0,  // 待发送
    ICMessageDeliveryState_Delivering,   // 正在发送
    ICMessageDeliveryState_Delivered,    // 已发送，成功
    ICMessageDeliveryState_Failure,      // 发送失败
    ICMessageDeliveryState_ServiceFaid   // 发送服务器失败(可能其它错,待扩展)
};

typedef NS_ENUM(NSInteger,MessageType) {
    MessageType_Text  = 1,             // 文本
    MessageType_Voice,                 // 短录音
    MessageType_Image,                 // 图片
    MessageType_Video,                 // 短视频
    MessageType_Doc,                   // 文档
    MessageType_NIF,                    //通知
};

typedef NS_ENUM(NSInteger,MessageStatus) {
    MessageStatus_unRead = 0,          // 消息未读
    MessageStatus_read,                // 消息已读
    MessageStatus_back                 // 消息撤回
};

typedef NS_ENUM(NSInteger,MessageFrom) {
    MessageFrom_output,//发出
    MessageFrom_input,//接收
};



//消息元素
@interface MessageItem : NSObject

@property (nonatomic, copy)NSString *userID;
@property (nonatomic, copy)NSString *messageIdentifier;//消息标识((消息+时间)的MD5)

@property (nonatomic, assign)MessageSendState sendState;//发送状态
@property (nonatomic, assign)MessageType messageType;//消息类型
@property (nonatomic, assign)MessageFrom messageFrom;//消息来源

@property (nonatomic, copy)NSString *fromID;//消息来源ID
@property (nonatomic, copy)NSString *toID;//消息目的地ID

@property (nonatomic, assign)NSInteger messageDate;//消息时间
@property (nonatomic, copy)NSString *headImageUrl;//头像
@property (nonatomic, copy)NSString *nickName;//昵称

@property (nonatomic, copy)NSString *content;//文本内容

@property (nonatomic, assign)BOOL isShowDate;//是否显示发送时间

@property (nonatomic, assign)BOOL isShowNickName;//显示成员昵称:用于群组聊天



/**
 返回子类的类名字符

 @return string
 */
-(NSString *)cellTypeString;

+(MessageItem *)creatClass:(MessageType)messageType;

@end

#pragma mark ------------------------- 文本消息

@interface TextMessageItem : MessageItem

@end

#pragma mark ------------------------- 图片消息

@interface PhotoMessageItem : MessageItem

@property (nonatomic, copy)NSString *imagePath;

@end

#pragma mark ------------------------- 音频

@interface VoiceMessageItem : MessageItem
@property (nonatomic, copy)NSString *voicePath;
@end


