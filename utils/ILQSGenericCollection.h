//
//  ILQSGenericCollection.h
//  Snake
//
//  Created by Ariel on 2013-10-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#define INVOKE(macro, ...) macro(__VA_ARGS__)
#define CollectionInterface(name) ILQS##name##Collection
#define NameInterface(name) ILQS##name

@protocol INVOKE(NameInterface, __LQS_GENERIC_NAME__);

@protocol INVOKE(CollectionInterface, __LQS_GENERIC_NAME__) <NSObject, NSFastEnumeration>

- (uint)size;
- (void)addObject:(NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)object;
- (void)removeObject:(NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)object;
- (bool)containsObject:(NSObject<INVOKE(NameInterface, __LQS_GENERIC_NAME__)> *)object;
- (void)addObjects:(NSObject<INVOKE(CollectionInterface, __LQS_GENERIC_NAME__)> *)objects;
- (void)removeObjects:(NSObject<INVOKE(CollectionInterface, __LQS_GENERIC_NAME__)> *)objects;
- (bool)containsObjects:(NSObject<INVOKE(CollectionInterface, __LQS_GENERIC_NAME__)> *)objects;
- (void)clear;

@end

#undef INVOKE
#undef CollectionInterface
#undef NameInterface
