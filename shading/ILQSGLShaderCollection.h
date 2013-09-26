//
//  ILQSGLShaderCollection.h
//  Snake
//
//  Created by Ariel on 2013-09-25.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSGLShader;

@protocol ILQSGLShaderCollection <NSObject, NSFastEnumeration>

- (uint)size;
- (void)addShader:(NSObject<ILQSGLShader> *)shader;
- (void)removeShader:(NSObject<ILQSGLShader> *)shader;
- (bool)containsShader:(NSObject<ILQSGLShader> *)shader;
- (void)addShaders:(NSObject<ILQSGLShaderCollection> *)shaders;
- (void)removeShaders:(NSObject<ILQSGLShaderCollection> *)shaders;
- (bool)containsShaders:(NSObject<ILQSGLShaderCollection> *)shaders;
- (void)clear;

@end
