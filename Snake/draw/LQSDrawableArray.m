//
//  LQSDrawableArray.m
//  Snake
//
//  Created by Ariel on 2013-09-09.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSDrawableArray.h"

@implementation LQSDrawableArray
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

- (void)addDrawableObject:(NSObject<ILQSDrawable> *)drawableObject
{
    [_array addObject:drawableObject];
}

- (void)removeDrawableObject:(NSObject<ILQSDrawable> *)drawableObject
{
    [_array removeObject:drawableObject];
}

- (bool)containsDrawableObject:(NSObject<ILQSDrawable> *)drawableObject
{
    return [_array containsObject:drawableObject];
}

- (void)addDrawableObjects:(NSObject<ILQSDrawableCollection> *)drawableObjects
{
    for (NSObject<ILQSDrawable> *drawableObject in drawableObjects)
    {
        [_array addObject:drawableObject];
    }
}

- (void)removeDrawableObjects:(NSObject<ILQSDrawableCollection> *)drawableObjects
{
    for (NSObject<ILQSDrawable> *drawableObject in drawableObjects)
    {
        [_array removeObject:drawableObject];
    }
}

- (bool)containsDrawableObjects:(NSObject<ILQSDrawableCollection> *)drawableObjects
{
    for (NSObject<ILQSDrawable> *drawableObject in drawableObjects)
    {
        if (![_array containsObject:drawableObject])
        {
            return false;
        }
    }
    return true;
}

- (void)insertObject:(NSObject<ILQSDrawable> *)drawableObject atIndex:(NSUInteger)index
{
    [_array insertObject:drawableObject atIndex:index];
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
