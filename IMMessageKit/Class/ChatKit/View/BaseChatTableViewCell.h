//
//  BaseChatTableViewCell.h
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BaseChatTableViewCell,MessageModel;

@protocol BaseChatTableViewCellDelegate <NSObject>

- (void)longPress:(UILongPressGestureRecognizer *)longRecognizer;

@optional
- (void)headImageClicked:(NSString *)eId;
- (void)reSendMessage:(BaseChatTableViewCell *)baseCell;


@end

@interface BaseChatTableViewCell : UITableViewCell

// 消息模型
@property (nonatomic, strong) MessageModel *modelFrame;

@property (nonatomic, strong)UIImageView *avatarImageView;//头像

@property (nonatomic, strong)UILabel *nickName;//昵称

@property (nonatomic, strong) UIImageView *bubbleView;//气泡

@property (nonatomic, strong) UIActivityIndicatorView *activityView;//消息发送指示器

@property (nonatomic, strong) UIButton *retryButton;//重复按钮

@property (nonatomic, strong) UILabel *messageStatus;//是否已读或未读

@end
