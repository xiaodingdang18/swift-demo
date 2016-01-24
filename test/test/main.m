//
//  main.m
//  test
//
//  Created by zhaohf on 16/1/21.
//  Copyright © 2016年 RW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "object.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSString *str = @"abcd";
        NSLog(@"str is %@ &str is %p",str, &str);
        
        NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:@"abcd", nil];
        NSLog(@"arr is %@ &arr is %p ",arr,&arr);
        
        object *obj = [[object alloc]init];
        object *obj2 = [[object alloc]init];
        NSLog(@"obj %@",obj);
        [obj log];
        [obj setValue:@"123" forKey:@"_foo"];
       
        [obj log];
        NSLog(@"obj is %@ &obj is %p",obj,&obj);
    }
    return 0;
}
