//
//  ILQSTransformationCollection.h
//  Snake
//
//  Created by Ariel on 2013-09-20.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSTransformation;

@protocol ILQSTransformationCollection <NSObject, NSFastEnumeration>

- (uint)size;
- (bool)containsTransformation:(NSObject<ILQSTransformation> *)transformation;
- (void)addTransformation:(NSObject<ILQSTransformation> *)transformation;
- (void)removeTransformation:(NSObject<ILQSTransformation> *)transformation;
- (bool)containsTransformations:(NSObject<ILQSTransformationCollection> *)transformations;
- (void)addTransformations:(NSObject<ILQSTransformationCollection> *)transformations;
- (void)removeTransformations:(NSObject<ILQSTransformationCollection> *)transformations;
- (void)clear;

@end
