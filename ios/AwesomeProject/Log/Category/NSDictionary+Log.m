//
//  NSDictionary+Log.m
//  FishHookDemo
//
//  Created by 张延深 on 2019/12/24.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

#ifdef DEBUG

- (NSString *)description {
    return [self YS_descriptionWithLevel:1];
}

- (NSString *)descriptionWithLocale:(id)locale {
    return [self YS_descriptionWithLevel:1];
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    return [self YS_descriptionWithLevel:level];
}

#pragma mark - Private methods

- (NSString *)YS_descriptionWithLevel:(NSUInteger)level {
    if (![self isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    NSString *subSpace = [self YS_getSpaceWithLevel:level];
    NSString *space = [self YS_getSpaceWithLevel:level - 1];
    NSMutableString *strM = [NSMutableString stringWithString:@"{"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str;
        if ([obj isKindOfClass:[NSString class]]) {
            str = obj;
//            str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            str = [NSString stringWithFormat:@"\n%@\"%@\": \"%@\",", subSpace, key, str];
        } else if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = obj;
            str = [dic YS_descriptionWithLevel:level + 1];
            str = [NSString stringWithFormat:@"\n%@\"%@\": %@,", subSpace, key, str];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = obj;
            str = [arr descriptionWithLocale:nil indent:level + 1];
            str = [NSString stringWithFormat:@"\n%@\"%@\": %@,", subSpace, key, str];
        } else {
            str = [NSString stringWithFormat:@"\n%@\"%@\": %@,", subSpace, key, obj];
        }
        [strM appendString:str];
    }];
    if ([strM hasSuffix:@","]) {
        [strM deleteCharactersInRange:NSMakeRange(strM.length - 1, 1)];
    }
    
    [strM appendFormat:@"\n%@}", space];
    
    return strM;
}

/**
 根据层级，返回前面的空格占位符
 
 @param level 数组的层级
 @return 占位空格
 */
- (NSString *)YS_getSpaceWithLevel:(NSUInteger)level {
    NSMutableString *strM = [[NSMutableString alloc] init];
    for (int i = 0; i < level; i ++) {
        [strM appendString:@"\t"];
    }
    return strM;
}

#endif

@end
