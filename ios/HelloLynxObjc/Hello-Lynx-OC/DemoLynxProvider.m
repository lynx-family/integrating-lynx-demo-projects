#import <Foundation/Foundation.h>

#import "DemoLynxProvider.h"

@implementation DemoLynxProvider

- (void)loadTemplateWithUrl:(NSString*)url onComplete:(LynxTemplateLoadBlock)callback {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:url ofType:@"bundle"];
    if (filePath) {
      NSError *error;
      NSData *data = [NSData dataWithContentsOfFile:filePath options:0 error:&error];
      if (error) {
        NSLog(@"Error reading file: %@", error.localizedDescription);
        callback(nil, error);
      } else {
        callback(data, nil);
      }
    } else {
      NSError *urlError = [NSError errorWithDomain:@"com.lynx"
                                                  code:400
                                                userInfo:@{NSLocalizedDescriptionKey : @"Invalid URL."}];
      callback(nil, urlError);
    }
}

@end
