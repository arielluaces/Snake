//
//  LQSSpaceCollection.m
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSSpaceCollection.h"

@implementation LQSSpaceCollection
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

- (bool)containsSpace:(NSObject<ILQSAdjacentSpace> *)space
{
    return [_array containsObject:space];
}

- (void)addSpace:(NSObject<ILQSAdjacentSpace> *)space
{
    [_array addObject:space];
}

- (void)removeSpace:(NSObject<ILQSAdjacentSpace> *)space
{
    [_array removeObject:space];
}

- (bool)containsSpaces:(NSObject<ILQSSpaceCollection> *)spaces
{
    for (NSObject<ILQSAdjacentSpace> *space in spaces)
    {
        if (![_array containsObject:space])
        {
            return false;
        }
    }
    return true;
}

- (void)addSpaces:(NSObject<ILQSSpaceCollection> *)spaces
{
    for (NSObject<ILQSAdjacentSpace> *space in spaces)
    {
        [_array addObject:space];
    }
}

- (void)removeSpaces:(NSObject<ILQSSpaceCollection> *)spaces
{
    for (NSObject<ILQSAdjacentSpace> *space in spaces)
    {
        [_array removeObject:space];
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
