//
//  ILQSDrawableCollection.h
//  Snake
//
//  Created by Ariel on 2013-09-09.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSDrawable;

@protocol ILQSDrawableCollection <NSObject, NSFastEnumeration>

- (uint)size;
- (void)addDrawableObject:(NSObject<ILQSDrawable> *)drawableObject;
- (void)removeDrawableObject:(NSObject<ILQSDrawable> *)drawableObject;
- (bool)containsDrawableObject:(NSObject<ILQSDrawable> *)drawableObject;
- (void)addDrawableObjects:(NSObject<ILQSDrawableCollection> *)drawableObjects;
- (void)removeDrawableObjects:(NSObject<ILQSDrawableCollection> *)drawableObjects;
- (bool)containsDrawableObjects:(NSObject<ILQSDrawableCollection> *)drawableObjects;
- (void)clear;

@end
