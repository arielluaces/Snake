//
//  ILQSGLShader.h
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>

@protocol ILQSGLShader <NSObject>

- (EAGLSharegroup *)sharegroup;
- (GLuint)name;

@end
