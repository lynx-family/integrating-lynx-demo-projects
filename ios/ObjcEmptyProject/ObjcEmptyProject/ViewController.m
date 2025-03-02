//
//  ViewController.m
//  ObjcEmptyProject
//

#import "ViewController.h"
#import "LynxViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];

    UILabel *label = [UILabel new];
    label.text = @"Hello Lynx!";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:30];

    [self.view addSubview:label];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Go" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];

    label.translatesAutoresizingMaskIntoConstraints = NO;
    button.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [label.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],

        [button.topAnchor constraintEqualToAnchor:label.bottomAnchor constant:20],
        [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    ]];
}

- (void)buttonTapped:(UIButton *)sender {
    // TODO: change url to lynx bundle url here
    NSString *urlString = @"";
    if (urlString.length > 0) {
        LynxViewController *vc = [[LynxViewController alloc] initWithUrl:urlString];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Please modify url" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        });
    }
}


@end
