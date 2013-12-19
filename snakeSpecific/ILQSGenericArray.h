//
//  ILQSGenericArray.h
//  Snake
//
//  Created by Ariel on 2013-10-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "ILQSGenericCollection.h"

#define INVOKE(macro, ...) macro(__VA_ARGS__)
#define ArrayInterface(name) ILQS##name##Array
#define CollectionInterface(name) ILQS##name##Collection
#define NameInterface(name) ILQS##name

@protocol INVOKE(ArrayInterface, __LQS_GENERIC_NAME__) <INVOKE(CollectionInterface, __LQS_GENERIC_NAME__)>

- (NSUInteger)indexOfObject:(NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)object;
- (NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)objectAtIndex:(NSUInteger)index;
- (void)insertObject:(NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)object atIndex:(NSUInteger)index;

@end

#undef INVOKE
#undef ArrayInterface
#undef CollectionInterface
#undef NameInterface
