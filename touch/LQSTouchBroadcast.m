//
//  LQSTouchBroadcast.m
//  Snake
//
//  Created by Ariel School on 2013-12-30.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import "LQSTouchBroadcast.h"
#import "LQSTouchProcessorArray.h"
#import <UIKit/UITouch.h>

@implementation LQSTouchBroadcast

- (void)processTouch:(UITouch *)touch
{
    for (NSObject<ILQSTouchProcessor> *touchProcessor in _touchProcessorArray) {
        [touchProcessor processTouch:touch];
    }
}

@end
