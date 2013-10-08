//
//  ILQSGenericCollection.h
//  Snake
//
//  Created by Ariel on 2013-10-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INVOKE(macro, ...) macro(__VA_ARGS__)
#define CollectionInterface(name) ILQS##name##Collection

@protocol INVOKE(CollectionInterface, __LQS_GENERIC_NAME__) <NSObject, NSFastEnumeration>

@end

#undef INVOKE
#undef CollectionInterface
