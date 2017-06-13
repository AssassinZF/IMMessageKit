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

@implementation MessageItem
-(NSString *)cellTypeString{return nil;}
@end

@implementation TextMessageItem
-(NSString *)cellTypeString{return NSStringFromClass([ChatTextCell class]);}
@end

@implementation PhotoMessageItem
-(NSString *)cellTypeString{return NSStringFromClass([ChatPhotoCell class]);}
@end
