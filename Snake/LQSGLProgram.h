//
//  LQSGLProgram.h
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/EAGL.h>

@interface LQSGLProgram : NSObject

@property (nonatomic, readonly) GLuint name;
@property (nonatomic, readonly) EAGLSharegroup *sharegroup;

- (id)initWithContext:(EAGLContext *)context;
- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup;

@end
