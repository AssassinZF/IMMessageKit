//
//  IMMessageAnalysis.h
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/14.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@interface IMMessageAnalysis : NSObject
+(MessageModel *)CreatMessageWithType:(MessageType)msgType
                              content:(NSString *)content
                             filePath:(NSString *)path
                               fromID:(NSString *)fromID
                                 toID:(NSString *)toID
                          messageFrom:(MessageFrom)msgFrom;
@end
