//
//  MessageItem.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "MessageItem.h"
#import "ChatTextCell.h"
#import "ChatPhotoCell.h"
#import "ChatVoiceCell.h"

@implementation MessageItem

-(NSString *)cellTypeString{return nil;}

+(MessageItem *)creatClass:(MessageType)messageType{
    switch (messageType) {
        case MessageType_Text:
            return [[TextMessageItem alloc] init];
            break;
        case MessageType_Image:
            return [[PhotoMessageItem alloc] init];
        case MessageType_Voice:
            return [[VoiceMessageItem alloc] init];

        default:
            break;
    }
    return nil;
}
@end

@implementation TextMessageItem
-(NSString *)cellTypeString{return NSStringFromClass([ChatTextCell class]);}


@end

@implementation PhotoMessageItem
-(NSString *)cellTypeString{return NSStringFromClass([ChatPhotoCell class]);}

@end

@implementation VoiceMessageItem

-(NSString *)cellTypeString{return NSStringFromClass([ChatVoiceCell class]);}

@end
