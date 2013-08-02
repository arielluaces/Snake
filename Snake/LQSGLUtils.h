//
//  LQSGLUtils.h
//  Snake
//
//  Created by Ariel on 2013-08-01.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSGLProgram;
@protocol ILQSGLShader;

@interface LQSGLUtils : NSObject

+ (void)checkProgramLinkStatus:(NSObject<ILQSGLProgram> *)program;
+ (void)checkShaderCompileStatus:(NSObject<ILQSGLShader> *)shader;

@end
