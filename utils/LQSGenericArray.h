//
//  LQSGenericArray.h
//  Snake
//
//  Created by Ariel on 2013-10-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSGenericArray.h"

#define INVOKE(macro, ...) macro(__VA_ARGS__)
#define ClassName(name) LQS##name##Array
#define ArrayInterface(name) ILQS##name##Array

@interface INVOKE(ClassName, __LQS_GENERIC_NAME__) : NSObject <INVOKE(ArrayInterface, __LQS_GENERIC_NAME__)>

@end

#undef INVOKE
#undef ClassName
#undef ArrayInterface
