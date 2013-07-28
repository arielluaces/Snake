//
//  LQSGLShader.h
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/EAGL.h>

@interface LQSGLShader : NSObject

@property (nonatomic, readonly) GLuint name;
@property (nonatomic, readonly) EAGLSharegroup *sharegroup;

- (id)initWithType:(GLenum)type;
- (id)initWithType:(GLenum)type context:(EAGLContext *)context;
- (id)initWithType:(GLenum)type sharegroup:(EAGLSharegroup *)sharegroup;

@end
