//
//  ILQSCollection.h
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSCollection <NSFastEnumeration>

- (uint)size;
- (bool)containsObject:(NSObject *)object;
- (void)addObject:(NSObject *)object;
- (void)removeObject:(NSObject *)object;
- (bool)containsObjects:(NSObject<ILQSCollection> *)objects;
- (void)addObjects:(NSObject<ILQSCollection> *)objects;
- (void)removeObjects:(NSObject<ILQSCollection> *)objects;
- (void)clear;

@end
