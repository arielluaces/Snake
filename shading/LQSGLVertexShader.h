//
//  LQSGLVertexShader.h
//  Snake
//
//  Created by Ariel on 2013-07-28.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSGLShader.h"
#import <OpenGLES/EAGL.h>

@interface LQSGLVertexShader : NSObject <ILQSGLShader>

- (id)initWithContext:(EAGLContext *)context;
- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup;

@end
