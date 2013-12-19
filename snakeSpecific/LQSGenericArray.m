//
//  LQSGenericArray.m
//  Snake
//
//  Created by Ariel on 2013-10-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSGenericArray.h"

#define INVOKE(macro, ...) macro(__VA_ARGS__)
#define ClassName(name) LQS##name##Array
#define CollectionInterface(name) ILQS##name##Collection
#define NameInterface(name) ILQS##name

@implementation INVOKE(ClassName, __LQS_GENERIC_NAME__)
{
    NSMutableArray *_array;
}

- (id)init
{
    self = [super init];
    if (self) {
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (uint)size
{
    return [_array count];
}

- (void)addObject:(NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)object
{
    [_array addObject:object];
}

- (void)removeObject:(NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)object
{
    [_array removeObject:object];
}

- (bool)containsObject:(NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)object
{
    return [_array containsObject:object];
}

- (void)addObjects:(NSObject<INVOKE(CollectionInterface, __LQS_GENERIC_NAME__)> *)objects
{
    for (NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *object in objects)
    {
        [_array addObject:object];
    }
}

- (void)removeObjects:(NSObject<INVOKE(CollectionInterface, __LQS_GENERIC_NAME__)> *)objects
{
    for (NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *object in objects)
    {
        [_array removeObject:object];
    }
}

- (bool)containsObjects:(NSObject<INVOKE(CollectionInterface, __LQS_GENERIC_NAME__)> *)objects
{
    for (NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *object in objects)
    {
        if (![_array containsObject:object])
        {
            return false;
        }
    }
    return true;
}

- (void)clear
{
    [_array removeAllObjects];
}

- (NSUInteger)indexOfObject:(NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)object
{
    return [_array indexOfObject:object];
}

- (NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)objectAtIndex:(NSUInteger)index
{
    return [_array objectAtIndex:index];
}

- (void)insertObject:(NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)object atIndex:(NSUInteger)index
{
    [_array insertObject:object atIndex:index];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len
{
    return [_array countByEnumeratingWithState:state objects:buffer count:len];
}

@end

#undef INVOKE
#undef ClassName
#undef CollectionInterface
#undef NameInterface
