//
//  ILQSSpaceCollection.h
//  Snake
//
//  Created by Ariel on 2013-09-03.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSAdjacentSpace;

@protocol ILQSSpaceCollection <NSFastEnumeration>

- (uint)size;
- (bool)containsSpace:(NSObject<ILQSAdjacentSpace> *)space;
- (void)addSpace:(NSObject<ILQSAdjacentSpace> *)space;
- (void)removeSpace:(NSObject<ILQSAdjacentSpace> *)space;
- (bool)containsSpaces:(NSObject<ILQSSpaceCollection> *)spaces;
- (void)addSpaces:(NSObject<ILQSSpaceCollection> *)spaces;
- (void)removeSpaces:(NSObject<ILQSSpaceCollection> *)spaces;
- (void)clear;

@end
