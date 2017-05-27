//
//  ViewController.m
//  ExpandableTable
//
//  Created by Vaishali on 25/5/17.
//  Copyright © 2017 VaishaliApp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{

    NSArray *Data;
    NSMutableArray *subData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    subData=[[NSMutableArray alloc]init];
    Data=[[NSArray alloc]initWithObjects:
                       @"Apple",
                       @"Strawberry",
                       @"Grapes",
                       @"Orange",
                       @"Banana",
                       @"Papaya",
                       @"Guava",
                       @"pineapple",
                       nil];
    
    for (int i=0; i<[Data count]; i++)
    {
        [subData addObject:[NSNumber numberWithBool:NO]];
    }
    
    //_ExpandableTable.dataSource=self;
    //_ExpandableTable.delegate=self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //if ([[subData objectAtIndex:section] boolValue]) {
        return [subData count]-6;
    //}
    //else
       // return 0;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [Data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellid=@"hello";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    
    BOOL manyCells  = [[subData objectAtIndex:indexPath.section] boolValue];
    
    /********** If the section supposed to be closed *******************/
    if(!manyCells)
    {
        //cell.backgroundColor=[UIColor blueColor];
        
        cell.textLabel.text=@"";
    }
    /********** If the section supposed to be Opened *******************/
    else
    {
    cell.textLabel.text=[NSString stringWithFormat:@"%@ %ld",[Data objectAtIndex:indexPath.section],indexPath.row+1];
        cell.textLabel.font=[UIFont systemFontOfSize:15.0f];
        cell.backgroundColor=[UIColor clearColor];
        
    }
    cell.textLabel.textColor=[UIColor blackColor];
    
        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*************** Close the section, once the data is selected ***********************************/
    [subData replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
    
    [_ExpandableTable reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[subData objectAtIndex:indexPath.section] boolValue]) {
        return 40;
    }
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280,40)];
    sectionView.tag=section;
    UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, _ExpandableTable.frame.size.width-10, 40)];
    viewLabel.backgroundColor=[UIColor clearColor];
    viewLabel.textColor=[UIColor blackColor];
    viewLabel.font=[UIFont systemFontOfSize:15];
    viewLabel.text=[NSString stringWithFormat:@"List of %@",[Data objectAtIndex:section]];
    [sectionView addSubview:viewLabel];
        /********** Add UITapGestureRecognizer to SectionView   **************/
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [sectionView addGestureRecognizer:headerTapped];
    
    return  sectionView;
    
    
}

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        BOOL collapsed  = [[subData objectAtIndex:indexPath.section] boolValue];
        for (int i=0; i<[Data count]; i++) {
            if (indexPath.section==i) {
                [subData replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:!collapsed]];
            }
        }
        [_ExpandableTable reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
