#import <Lynx/LynxView.h>

#import "ViewController.h"
#import "DemoLynxProvider.h"

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  LynxView *lynxView = [[LynxView alloc] initWithBuilderBlock:^(LynxViewBuilder *builder) {
      builder.config = [[LynxConfig alloc] initWithProvider:[[DemoLynxProvider alloc] init]];
      builder.screenSize = self.view.frame.size;
      builder.fontScale = 1.0;
  }];
  lynxView.preferredLayoutWidth = self.view.frame.size.width;
  lynxView.preferredLayoutHeight = self.view.frame.size.height;
  lynxView.layoutWidthMode = LynxViewSizeModeExact;
  lynxView.layoutHeightMode = LynxViewSizeModeExact;
  [self.view addSubview:lynxView];

  [lynxView loadTemplateFromURL:@"main.lynx" initData:nil];
}

@end
