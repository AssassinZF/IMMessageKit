//
//  IMMessageAnalysis.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/14.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "IMMessageAnalysis.h"

@implementation IMMessageAnalysis

+(MessageModel *)CreatMessageWithType:(MessageType)msgType
                              content:(NSString *)content
                             filePath:(NSString *)path
                               fromID:(NSString *)fromID
                                 toID:(NSString *)toID
                          messageFrom:(MessageFrom)msgFrom{
    
    MessageItem *msgItem = [MessageItem  creatClass:msgType];
    msgItem.messageFrom = msgFrom;
    msgItem.toID = toID;
    msgItem.fromID = fromID;
    msgItem.messageFrom = msgFrom;
    msgItem.messageDate = [self currentLocalMessageTime];//暂时设置为本地时间
    msgItem.messageType = msgType;

    switch (msgType) {
        case MessageType_Text:{
            TextMessageItem *textItem = (TextMessageItem *)msgItem;
            textItem.content = content;
            
        }break;
        case MessageType_Image:{
            PhotoMessageItem *photoItem = (PhotoMessageItem *)msgItem;
            photoItem.imagePath = path;
            photoItem.content = @"[图片]";
        }break;
        case MessageType_Voice:{
            VoiceMessageItem *voiceItem = (VoiceMessageItem *)msgItem;
            voiceItem.voicePath = path;
            voiceItem.content = @"[语音]";
        }break;
        default:
            break;
    }
    
    MessageModel *messageModel = [[MessageModel alloc] init];
    messageModel.messageItem = msgItem;
    
    return messageModel;
    
}

+ (NSInteger)currentLocalMessageTime
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSInteger iTime     = (NSInteger)(time * 1000);
    return iTime;
}


@end
