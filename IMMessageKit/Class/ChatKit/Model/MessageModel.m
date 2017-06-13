//
//  MessageModel.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "MessageModel.h"
#import "MessageItem.h"

#define APP_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define APP_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@implementation MessageModel

-(void)setMessageItem:(MessageItem *)messageItem{
    _messageItem = messageItem;
    
    UIEdgeInsets contentViewEdg = UIEdgeInsetsMake(10, 10, 10, 10);
    
}

@end
