//
//  SpotliteTool.m
//  SpotliteDemo
//
//  Created by huihuadeng on 15/12/2.
//  Copyright © 2015年 huihuadeng. All rights reserved.
//

#import "SpotliteTool.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import "PeopleModel.h"

static SpotliteTool *instance;
static dispatch_queue_t _queue;

@implementation SpotliteTool

+(instancetype)shareSpotliteTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[SpotliteTool alloc] init];
            _queue = dispatch_queue_create("com.sohu.huji.spotlite", DISPATCH_QUEUE_SERIAL);
        }
    });
    return instance;
}

// 需要 支持多线程 （插入跟更新不能同时做）
-(void)insertItem:(PeopleModel *)peopleItem
{
    
    dispatch_async(_queue, ^{
        CSSearchableItemAttributeSet *set = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"aa"];
        set.title = peopleItem.title;
        set.contentDescription = peopleItem.message;
        CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:peopleItem.identifier domainIdentifier:@"file-1" attributeSet:set];
        //item 的identifier一致，即为更新
        [[CSSearchableIndex defaultSearchableIndex]indexSearchableItems:[NSArray arrayWithObject:item] completionHandler:^(NSError * _Nullable error) {
            NSLog(@"complete :%@",error.description);
        }];
    });
}

-(void)updateItem:(PeopleModel *)peopleItem
{
    dispatch_async(_queue, ^{
        CSSearchableItemAttributeSet *set = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"aa"];
        set.title = peopleItem.title;
        set.contentDescription = peopleItem.message;
        CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:peopleItem.identifier domainIdentifier:@"file-1" attributeSet:set];
        //item 的identifier一致，即为更新
        [[CSSearchableIndex defaultSearchableIndex]indexSearchableItems:[NSArray arrayWithObject:item] completionHandler:^(NSError * _Nullable error) {
        }];
    });
}

-(void)deleteItem:(PeopleModel *)peopleItem
{
    dispatch_async(_queue, ^{
    //item 的identifier一致，即为更新
        [[CSSearchableIndex defaultSearchableIndex] deleteSearchableItemsWithIdentifiers:[NSArray arrayWithObject:peopleItem.identifier] completionHandler:^(NSError * _Nullable error)
         {
             
         }];
    });
}

-(void)deleteAll
{
  [[CSSearchableIndex defaultSearchableIndex] deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {
      
  }];
}

-(void)dealloc
{
//对于最低sdk版本>=ios6.0来说,GCD对象已经纳入了ARC的管理范围,我们就不需要再手工调用 dispatch_release了,否则的话,在sdk<6.0的时候,即使我们开启了ARC,这个宏OS_OBJECT_USE_OBJC 也是没有的,也就是说这个时候,GCD对象还必须得自己管理
//    dispatch_release(_queue);
}

@end
