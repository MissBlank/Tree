//
//  ViewController.m
//  tree
//
//  Created by NERC on 2018/6/4.
//  Copyright © 2018年 GaoNing. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView * mainTableView;

@property (strong, nonatomic) NSMutableArray *countArray;
@property (assign, nonatomic) NSInteger rowCount;


@end

@implementation ViewController
@synthesize mainTableView;

-(NSMutableArray *)countArray{
    if (!_countArray) {
        _countArray =[[NSMutableArray alloc]init];
    }
    return _countArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    
    mainTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , self.view.frame.size.height)];
    mainTableView.delegate=self;
    mainTableView.dataSource =self;
    [self.view addSubview:mainTableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.countArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    Model * model= [self.countArray objectAtIndex:indexPath.row];
    NSString *cellState = model.open?@"-":@"+";
    cell.textLabel.text=model.name;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Model * model =[self.countArray objectAtIndex:indexPath.row];
    if (model.open) {
        [self deleteData:model.array];
    }else{
        self.rowCount =indexPath.row;
        [self insertData:model.array];
    }
    model.open = !model.open;
    [self.mainTableView reloadData];
    
    NSLog(@"%@",indexPath);
}


//收起所有子节点
- (void)deleteData:(NSMutableArray *)array {
    for (int i = 0; i<array.count; i++) {
        Model *model = [array objectAtIndex:i];
        if (model.array) {
            [self deleteData:model.array];
        }
        [self.countArray removeObject:model];
    }
    
}

//展开所有子节点
- (void)insertData:(NSMutableArray *)array {
    for (int i = 0; i<array.count; i++) {
        Model *model = [array objectAtIndex:i];
        self.rowCount++;
        [self.countArray insertObject:model atIndex:self.rowCount];
        if (model.array && model.open) {
            [self insertData:model.array];
        }
    }
}


-(void)initData{
    
    //构造父节点
    for (int i = 0; i<5; i++) {
        Model *model = [[Model alloc]init];
        model.name = [NSString stringWithFormat:@"%i",i];
        model.array = [NSMutableArray array];
        //构造子节点
        for (int j = 6; j<10; j++) {
            Model *childModel = [[Model alloc]init];
            childModel.name = [NSString stringWithFormat:@"  子节点： %i",j];
            childModel.array =[[NSMutableArray alloc]init];
            //构造孙子节点
            for (int k = 11; k<15; k++) {
                Model * grandsonModel =[[Model alloc]init];
                grandsonModel.name =[NSString stringWithFormat:@"    孙子节点： %i",k];
                // 孙子节点
                [childModel.array addObject:grandsonModel];
            }
            //子节点
            [model.array addObject:childModel];
        }
        //父节点
        [self.countArray addObject:model];
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
