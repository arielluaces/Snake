//
//  LQSGLFileUtils.h
//  Snake
//
//  Created by Ariel on 2013-08-12.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>

@interface LQSGLFileUtils : NSObject

+ (const GLchar *)loadVertexShaderSource:(NSString *)resourceName;
+ (const GLchar *)loadFragmentShaderSource:(NSString *)resourceName;

@end
