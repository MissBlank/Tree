//
//  Model.h
//  tree
//
//  Created by NERC on 2018/6/4.
//  Copyright © 2018年 GaoNing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL open;
@property (strong, nonatomic) NSMutableArray *array;

@end
