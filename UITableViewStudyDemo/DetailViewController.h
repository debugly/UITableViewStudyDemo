//
//  DetailViewController.h
//  UITableViewStudyDemo
//
//  Created by xuqianlong on 15/10/26.
//  Copyright (c) 2015年 Matt Reach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

