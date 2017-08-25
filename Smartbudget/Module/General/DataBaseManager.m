//
//  DataBaseManager.m
//  Smartbudget
//
//  Created by zhanfeng on 2017/8/23.
//  Copyright © 2017年 zf. All rights reserved.
//

#import "DataBaseManager.h"
#import "BudgetModel.h"

@interface DataBaseManager()
@property (nonatomic, strong)FMDatabase *db;
@end

@implementation DataBaseManager

+(instancetype)share{
    static DataBaseManager *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[DataBaseManager alloc] init];
    });
    return share;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.db = [FMDatabase databaseWithPath:[self getDBPath]];
    }
    return self;
}

-(NSString *)getDBPath{
    return [NSString stringWithFormat:@"%@/db/database.db",DocumentPath];
}

#pragma mark - 数据库操作

-(void)creatTable{
    
    NSString *sql = @"CREATETABLE IF NOT EXISTS budget (id integer PRIMARY KEY AUTOINCREMENT, budgetName text NOT NULL, age integer NOT NULL);";
}

-(void)addData:(BudgetModel *)model{
    
}
@end
