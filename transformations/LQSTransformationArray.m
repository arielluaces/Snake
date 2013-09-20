//
//  LQSTransformationArray.m
//  Snake
//
//  Created by Ariel on 2013-09-20.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSTransformationArray.h"

@implementation LQSTransformationArray
{
    NSMutableArray *_transformations;
}

- (id)init
{
    self = [super init];
    if (self) {
        _transformations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (uint)size
{
    return [_transformations count];
}

- (bool)containsTransformation:(NSObject<ILQSTransformation> *)transformation
{
    return [_transformations containsObject:transformation];
}

- (void)addTransformation:(NSObject<ILQSTransformation> *)transformation
{
    [_transformations addObject:transformation];
}

- (void)removeTransformation:(NSObject<ILQSTransformation> *)transformation
{
    [_transformations removeObject:transformation];
}

- (bool)containsTransformations:(NSObject<ILQSTransformationCollection> *)transformations
{
    for (NSObject<ILQSTransformation> *transformation in transformations)
    {
        if (![_transformations containsObject:transformation])
        {
            return false;
        }
    }
    return true;
}

- (void)addTransformations:(NSObject<ILQSTransformationCollection> *)transformations
{
    for (NSObject<ILQSTransformation> *transformation in transformations)
    {
        [_transformations addObject:transformation];
    }
}

- (void)removeTransformations:(NSObject<ILQSTransformationCollection> *)transformations
{
    for (NSObject<ILQSTransformation> *transformation in transformations)
    {
        [_transformations removeObject:transformation];
    }
}

- (void)insertTransformation:(NSObject<ILQSTransformation> *)transformation atIndex:(uint)index
{
    [_transformations insertObject:transformation atIndex:index];
}

- (void)clear
{
    [_transformations removeAllObjects];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len
{
    return [_transformations countByEnumeratingWithState:state objects:buffer count:len];
}

@end
