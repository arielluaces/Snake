//
//  LQSTexturedVerticesProgram.h
//  Snake
//
//  Created by Ariel on 2013-08-14.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILQSTexturedVerticesProgram.h"

@interface LQSTexturedVerticesProgram : NSObject <ILQSTexturedVerticesProgram>

- (id)init;
- (id)initWithContext:(EAGLContext *)context;
- (id)initWithSharegroup:(EAGLSharegroup *)sharegroup;

@end
