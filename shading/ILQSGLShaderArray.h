//
//  ILQSGLShaderArray.h
//  Snake
//
//  Created by Ariel on 2013-09-25.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSGLShaderCollection.h"

@protocol ILQSGLShaderArray <ILQSGLShaderCollection>

- (NSUInteger)indexOfShader:(NSObject<ILQSGLShader> *)shader;
- (void)insertShader:(NSObject<ILQSGLShader> *)shader atIndex:(NSUInteger)index;

@end
