//
//  ILQSTouchProcessor.h
//  Snake
//
//  Created by Ariel School on 2013-12-29.
//  Copyright (c) 2013 Liquid Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UITouch;

@protocol ILQSTouchProcessor <NSObject>

- (void)processTouch:(UITouch *)touch;

@end
