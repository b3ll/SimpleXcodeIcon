//
//  XCPSimpleXcodeIcon.m
//  SimpleXcodeIcon
//
//  Created by Adam Bell on 2015-04-10.
//  Copyright (c) 2015 Adam Bell. All rights reserved.
//

#include <objc/runtime.h>

#import "XCPSimpleXcodeIcon.h"

static XCPSimpleXcodeIcon *sharedPlugin;

@implementation XCPSimpleXcodeIcon

+ (BOOL)shouldLoadPlugin
{
  NSString *currentApplicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleNameKey];
  if (![currentApplicationName isEqual:@"Xcode"]){
    return NO;
  }
  
  return YES;
}

+ (void)pluginDidLoad:(NSBundle *)plugin
{
  static dispatch_once_t t;
  
  if ([self shouldLoadPlugin]) {
    dispatch_once(&t, ^{
      Class DVTApplicationClass = NSClassFromString(@"DVTApplication");
      SEL adjustApplicationIconSEL = NSSelectorFromString(@"adjustApplicationIconForEnvironment:");
      
      Method origClassMethod = class_getClassMethod(DVTApplicationClass, adjustApplicationIconSEL);
      
      IMP newIMP = imp_implementationWithBlock(^(id _self, id enviroment) {
        return;
      });
      
      method_setImplementation(origClassMethod, newIMP);
    });
  }
}

@end
