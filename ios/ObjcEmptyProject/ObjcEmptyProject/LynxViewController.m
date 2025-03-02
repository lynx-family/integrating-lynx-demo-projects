//
//  LynxViewController.m
//  ObjcEmptyProject
//

#import <Foundation/Foundation.h>
#import "LynxViewController.h"

@interface LynxViewController ()

@property (nonatomic, strong) NSString *urlString;

@end

@implementation LynxViewController

- (instancetype)initWithUrl:(NSString *)urlString {
    self = [super init];
    if (self) {
        _urlString = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self render:self.urlString];
}

- (void)render: (NSString *)url {
    // TODO render lynx view here
}


@end
