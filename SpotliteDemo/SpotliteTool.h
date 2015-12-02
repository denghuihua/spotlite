//
//  SpotliteTool.h
//  SpotliteDemo
//
//  Created by huihuadeng on 15/12/2.
//  Copyright © 2015年 huihuadeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PeopleModel;

@interface SpotliteTool : NSObject

+(instancetype)shareSpotliteTool;

-(void)insertItem:(PeopleModel *)peopleItem;
-(void)deleteItem:(PeopleModel *)peopleItem;
-(void)deleteAll;
@end
