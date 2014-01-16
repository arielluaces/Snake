//
//  ILQSFoodSpawner.h
//  Snake
//
//  Created by Ariel School on 2014-01-15.
//  Copyright (c) 2014 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILQSFood;

@protocol ILQSFoodSpawner <NSObject>

- (NSObject<ILQSFood> *)spawnFood;

@end
