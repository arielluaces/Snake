//
//  LQSGenericArray.m
//  Snake
//
//  Created by Ariel on 2013-10-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSGenericArray.h"

#define INVOKE(macro, ...) macro(__VA_ARGS__)
#define ClassName(name) LQS##name##Array

@implementation INVOKE(ClassName, __LQS_GENERIC_NAME__)

@end

#undef INVOKE
#undef ClassName
