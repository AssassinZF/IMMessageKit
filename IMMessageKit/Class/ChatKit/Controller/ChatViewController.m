//
//  ChaViewController.m
//  IMMessageKit
//
//  Created by zhanfeng on 2017/6/13.
//  Copyright © 2017年 lzf. All rights reserved.
//

#import "ChatViewController.h"
#import "ConversationModel.h"
#import "BaseChatTableViewCell.h"
#import "ChatTextCell.h"
#import "ChatPhotoCell.h"
#import "MessageModel.h"
#import "IMMessageAnalysis.h"
#import "ZFKeyboardInputView.h"


@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,ZFKeyboardInputViewDelegate>

@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic, strong)ZFKeyboardInputView *keyboardView;


@end

@implementation ChatViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)configureUI{
    
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.keyboardView];
    [self layoutUI];
    [self registerCell];
}

-(void)layoutUI{
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-HEIGHT_TABBAR);
    }];
    [_keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableview.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(HEIGHT_TABBAR));
    }];
}

- (void)registerCell
{
    [self.tableview registerClass:[ChatTextCell class] forCellReuseIdentifier:NSStringFromClass([ChatTextCell class])];
    [self.tableview registerClass:[ChatPhotoCell class] forCellReuseIdentifier:NSStringFromClass([ChatPhotoCell class])];
}


-(void)setConversationModel:(ConversationModel *)conversationModel{
    _conversationModel = conversationModel;
    self.title = _conversationModel.conversationName;
}

#pragma mark ------------------------- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = self.dataArray[indexPath.row];
    BaseChatTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:[model.messageItem cellTypeString]];
    cell.modelFrame = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = self.dataArray[indexPath.row];
    return model.cellMax_H;
}

#pragma mark ------------------------- Getr

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.backgroundColor = XZColor(240, 237, 237);
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        
    }
    return _tableview;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

//键盘组件
-(ZFKeyboardInputView *)keyboardView{
    if (!_keyboardView) {
        _keyboardView = [[ZFKeyboardInputView alloc] initWithKeyboardType:ZFKeyboardTypeChat];
        _keyboardView.keyboardDelegate = self;
    }
    return _keyboardView;
}

#pragma mark ------------------------- Private Method

- (void)scrollToBottom
{
    if (self.dataArray.count > 0) {
        [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}



#pragma mark ------------------------- 假数据 
-(void)loadData{
    MessageModel *message1 = [IMMessageAnalysis CreatMessageWithType:MessageType_Text
                                    content:@"在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?"
                                   filePath:nil
                                     fromID:@"1"
                                       toID:@"2"
                                messageFrom:MessageFrom_output];
    MessageModel *message2 = [IMMessageAnalysis CreatMessageWithType:MessageType_Text
                                    content:@"在吗在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?在吗?"
                                   filePath:nil
                                     fromID:@"1"
                                       toID:@"2"
                                messageFrom:MessageFrom_input];
    
    [self.dataArray addObject:message1];
    [self.dataArray addObject:message2];
    
    [self.tableview reloadData];
    [self scrollToBottom];

}

#pragma mark ------------------------- 键盘输入框协议方法

-(void)changeKeyboardHeight:(ZFKeyboardInputView *)keyboardView valueH:(CGFloat)keyboardH{
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
       [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
           make.bottom.equalTo(self.view).offset(-keyboardH);
       }];
        [self.view layoutIfNeeded];
    }];
}


@end
