//
//  MessageModel.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "MessageModel.h"
#import "MessageItem.h"
#import "ChatConst.h"


@implementation MessageModel

-(void)setMessageItem:(MessageItem *)messageItem{
    _messageItem = messageItem;
    
    CGFloat topSpace = 10;
    CGFloat left = topSpace;
    CGFloat headImageView_W = 45;
    CGFloat headToBubble  = 3;
    CGFloat bubblePadding = 10;
    CGFloat chatLabelMax  = APP_WIDTH - headImageView_W - 100;
    CGFloat arrowWidth    = 7;      // 气泡箭头
    CGFloat dateLabel_H = 20;//时间高度
    CGFloat nickLabel_H = 25;//昵称高度
    CGFloat cellMin_w = 60;
    
    BOOL isSender = messageItem.messageFrom == MessageFrom_output;//是发送者还是接受者
    
    //发送时间
    if (messageItem.isShowDate) {
        _dateLabelF = CGRectMake(0, topSpace, APP_WIDTH, dateLabel_H);
        topSpace = CGRectGetMaxY(_dateLabelF)+topSpace;
    }

    //头像的位置
    CGFloat head_x = isSender?APP_WIDTH - topSpace - headImageView_W:topSpace;
    _avatarViewF = CGRectMake(head_x, topSpace, headImageView_W, headImageView_W);
    
    //昵称
    if (messageItem.isShowNickName) {
        _nickNameF = CGRectMake(CGRectGetMaxX(_avatarViewF)+headToBubble, _avatarViewF.origin.y, 100, 25);
    }
    
    //内容size
    switch (messageItem.messageType) {
        case MessageType_Text:{
            
            CGSize chateLabelSize = [messageItem.content sizeForFont:MessageFont size:CGSizeMake(chatLabelMax, MAXFLOAT) mode:NSLineBreakByWordWrapping];
            CGSize bubbleSize = CGSizeMake(chateLabelSize.width + bubblePadding * 2 + arrowWidth, chateLabelSize.height + bubblePadding * 2);
            
            CGFloat bubble_x = isSender?CGRectGetMinX(_avatarViewF) - headToBubble - bubbleSize.width:CGRectGetMaxX(_avatarViewF)+headToBubble;
            
            CGFloat bubble_y = messageItem.isShowNickName?CGRectGetMaxY(_nickNameF):_avatarViewF.origin.y;
            
            _bubbleViewF = CGRectMake(bubble_x,bubble_y , MAX(bubbleSize.width, cellMin_w), MAX(bubbleSize.height, _avatarViewF.size.height));
            
            CGFloat text_x = isSender?bubblePadding:bubblePadding+arrowWidth;
            
            _textContentF = CGRectMake(text_x, bubblePadding, chateLabelSize.width, chateLabelSize.height);

        }break;
        case MessageType_Image:{
            
        }break;
        case MessageType_Voice:{
            
        }break;
            
        default:
            break;
    }
    
    _cellMax_H = MAX(CGRectGetMaxY(_avatarViewF)+left, CGRectGetMaxY(_bubbleViewF)+left);
    
}

@end
