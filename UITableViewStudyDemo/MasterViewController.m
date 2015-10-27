//
//  MasterViewController.m
//  UITableViewStudyDemo
//
//  Created by xuqianlong on 15/10/26.
//  Copyright (c) 2015年 Matt Reach. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "QLCustomCell.h"

@interface MasterViewController ()

@property NSMutableArray *objects;

@property (nonatomic,assign) UITableViewCellEditingStyle editingStyle;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
//    支持多选；
//    self.tableView.allowsMultipleSelectionDuringEditing = YES;
//    编辑的时候允许选择；
//    self.tableView.allowsSelectionDuringEditing = YES;
    for (int i = 0; i < 20; i ++) {
        [self insertNewObject:nil];
    }
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender
{
    return !self.isEditing;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QLCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [(self.tableView.isEditing ? [self editingStyle2DescString] : @"")stringByAppendingString:[object description]];
    cell.ownerTable = self.tableView;
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    return self.editingStyle;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (editing) {
        self.editingStyle = self.editingStyle + 1;
        if (UITableViewCellEditingStyleInsert + UITableViewCellEditingStyleDelete < self.editingStyle) {
            self.editingStyle = UITableViewCellEditingStyleNone;
        }
        self.title = [self editingStyle2DescString];
    }else{
        self.title = @"UITableViewEditDemo";
    }
    
    [self.tableView reloadData];
    [super setEditing:editing animated:animated];
}

- (NSString *)editingStyle2DescString
{
    switch (self.editingStyle) {
        case UITableViewCellEditingStyleDelete:
        {
            return @"Delete Style";
        }
            break;
        case UITableViewCellEditingStyleInsert:
        {
            return @"Insert Style";
        }
            break;
        case UITableViewCellEditingStyleNone:
        {
            return @"None Style";
        }
    }
    return @"Multiple Select";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }else{
//        自定义删除；
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
