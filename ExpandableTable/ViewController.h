//
//  ViewController.h
//  ExpandableTable
//
//  Created by Vaishali on 25/5/17.
//  Copyright © 2017 VaishaliApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController < UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *ExpandableTable;

@end

