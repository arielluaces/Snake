//
//  LQSGLShaderArray.m
//  Snake
//
//  Created by Ariel on 2013-09-25.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSGLShaderArray.h"

@implementation LQSGLShaderArray
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

- (void)addShader:(NSObject<ILQSGLShader> *)shader
{
    [_array addObject:shader];
}

- (void)removeShader:(NSObject<ILQSGLShader> *)shader
{
    [_array removeObject:shader];
}

- (bool)containsShader:(NSObject<ILQSGLShader> *)shader
{
    return [_array containsObject:shader];
}

- (void)addShaders:(NSObject<ILQSGLShaderCollection> *)shaders
{
    for (NSObject<ILQSGLShader> *shader in shaders)
    {
        [_array addObject:shader];
    }
}

- (void)removeShaders:(NSObject<ILQSGLShaderCollection> *)shaders
{
    for (NSObject<ILQSGLShader> *shader in shaders)
    {
        [_array removeObject:shader];
    }
}

- (bool)containsShaders:(NSObject<ILQSGLShaderCollection> *)shaders
{
    for (NSObject<ILQSGLShader> *shader in shaders)
    {
        if (![_array containsObject:shader])
        {
            return false;
        }
    }
    return true;
}

- (NSUInteger)indexOfShader:(NSObject<ILQSGLShader> *)shader
{
    return [_array indexOfObject:shader];
}

- (void)insertShader:(NSObject<ILQSGLShader> *)shader atIndex:(NSUInteger)index
{
    [_array insertObject:shader atIndex:index];
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
