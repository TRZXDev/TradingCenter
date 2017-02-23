//
//  TradingCenterWebViewController.m
//  TradingCenter
//
//  Created by N年後 on 2017/2/23.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "TradingCenterWebViewController.h"
#import "TRZXKit.h"
@interface TradingCenterWebViewController ()
@property (strong, nonatomic) AXWebViewController *webVC;

@end

@implementation TradingCenterWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];



    // Do any additional setup after loading the view.
}

-(void)setWebURL:(NSString *)webURL{

        self.webVC = [[AXWebViewController alloc] initWithURL:[NSURL URLWithString:webURL]];

        self.webVC.view.frame = CGRectMake(10, 10, self.view.width-20, self.view.height-20);
        self.webVC.view.backgroundColor = [UIColor whiteColor];
        self.webVC.view.layer.cornerRadius = 5;
        self.webVC.view.layer.masksToBounds = YES;
        [self.view addSubview:self.webVC.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
