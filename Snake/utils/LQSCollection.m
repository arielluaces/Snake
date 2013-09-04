//
//  LQSCollection.m
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSCollection.h"

@implementation LQSCollection

- (id)init
{
    self = [super init];
    if (self)
    {
        _array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithArray:(NSMutableArray *)array
{
    self = [super init];
    if (self)
    {
        _array = array;
    }
    return self;
}

- (uint)size
{
    return [_array count];
}

- (bool)containsObject:(NSObject *)object
{
    return [_array containsObject:object];
}

- (void)addObject:(NSObject *)object
{
    [_array addObject:object];
}

- (void)removeObject:(NSObject *)object
{
    [_array removeObject:object];
}

- (bool)containsObjects:(NSObject<ILQSCollection> *)objects
{
    for (NSObject *object in objects)
    {
        if (![_array containsObject:object])
        {
            return false;
        }
    }
    return true;
}

- (void)addObjects:(NSObject<ILQSCollection> *)objects
{
    for (NSObject *object in objects)
    {
        [_array addObject:object];
    }
}

- (void)removeObjects:(NSObject<ILQSCollection> *)objects
{
    for (NSObject *object in objects)
    {
        [_array removeObject:object];
    }
}

- (void)clear
{
    [_array removeAllObjects];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len
{
    return [_array countByEnumeratingWithState:state objects:buffer count:len];
}

@end
