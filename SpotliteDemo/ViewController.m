//
//  ViewController.m
//  SpotliteDemo
//
//  Created by huihuadeng on 15/12/2.
//  Copyright © 2015年 huihuadeng. All rights reserved.
//

#import "ViewController.h"
#import "PeopleModel.h"
#import "SpotliteTool.h"

@interface ViewController ()
{
    int index;
    SpotliteTool *tool;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tool = [SpotliteTool shareSpotliteTool];
    
    UIButton *addButton = [UIButton  buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:addButton];
    addButton.frame = CGRectMake(200, 100, 60, 44);
    [addButton setTitle:@"新增" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *deleteButton = [UIButton  buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:deleteButton];
    deleteButton.frame = CGRectMake(200, 260, 60, 44);
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *updateButton = [UIButton  buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:updateButton];
    updateButton.frame = CGRectMake(200, 420, 60, 44);
    [updateButton setTitle:@"更新" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *clearButton = [UIButton  buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:clearButton];
    clearButton.frame = CGRectMake(200, 500, 60, 44);
    [clearButton setTitle:@"清空" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)addButtonAction:(UIButton *)button
{
    for (int i =0;  i < 100;i ++)
    {
        index ++;
        PeopleModel *peopleItem = [[PeopleModel alloc] init];
        peopleItem.title = @"huahua";
        peopleItem.message = [NSString stringWithFormat:@"%@%zd",peopleItem.title,index];
        peopleItem.identifier = [NSString stringWithFormat:@"%@%zd",peopleItem.title,index];
        [tool performSelectorInBackground:@selector(insertItem:) withObject:peopleItem];
    }
}

-(void)deleteButtonAction:(UIButton *)button
{
    PeopleModel *peopleItem = [[PeopleModel alloc] init];
    peopleItem.title = @"huahua";
    peopleItem.message = [NSString stringWithFormat:@"update%@%zd",peopleItem.title,index];
    peopleItem.identifier = [NSString stringWithFormat:@"%@%zd",peopleItem.title,index];
    [tool deleteItem:peopleItem];
}

-(void)updateButtonAction:(UIButton *)button
{
    PeopleModel *peopleItem = [[PeopleModel alloc] init];
    peopleItem.title = @"huahua";
    peopleItem.message = [NSString stringWithFormat:@"update%@%zd",peopleItem.title,index];
    peopleItem.identifier = [NSString stringWithFormat:@"%@%zd",peopleItem.title,index];
    [tool insertItem:peopleItem];
}

-(void)clearButtonAction:(UIButton *)button
{
    [tool deleteAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
