//
//  QLCustomCell.m
//  UITableViewStudyDemo
//
//  Created by xuqianlong on 15/10/26.
//  Copyright (c) 2015年 Matt Reach. All rights reserved.
//

#import "QLCustomCell.h"

@implementation QLCustomCell

- (void)awakeFromNib{

}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (self.isEditing == editing) return;
    
    if (UITableViewCellEditingStyleNone == self.editingStyle) {
        if (editing) {
            
            UIControl *view = [[UIControl alloc]initWithFrame:CGRectMake(-20,(self.bounds.size.height -20)/2.0, 20, 20)];
            view.backgroundColor = [UIColor redColor];
            [view addTarget:self action:@selector(tipedEditView) forControlEvents:UIControlEventTouchUpInside];
            view.tag = 23456;
            [self addSubview:view];
            CGRect destRect = view.frame;
            destRect.origin.x = 15;
            
            if (animated) {
                [UIView animateWithDuration:0.25 animations:^{
                    view.frame = destRect;
                }];
            }else{
                view.frame = destRect;
            }
        }else{
            UIView *view = [self viewWithTag:23456];
            CGRect destRect = view.frame;
            destRect.origin.x = -20;
            
            if (animated) {
                [UIView animateWithDuration:0.25 animations:^{
                    view.frame = destRect;
                }completion:^(BOOL finished) {
                    [view removeFromSuperview];
                }];
            }else{
                view.frame = destRect;
                [view removeFromSuperview];
            }
        }
    }
    
    [super setEditing:editing animated:animated];
}

- (void)tipedEditView
{
//    回掉到tableview的dasource去；
    id<UITableViewDataSource>delete = self.ownerTable.dataSource;
    NSIndexPath *idx = [self.ownerTable indexPathForCell:self];
    [delete tableView:self.ownerTable commitEditingStyle:UITableViewCellEditingStyleNone forRowAtIndexPath:idx];
}

@end
