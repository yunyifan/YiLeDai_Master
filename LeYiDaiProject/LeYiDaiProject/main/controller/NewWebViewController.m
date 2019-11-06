//
//  NewWebViewController.m
//  LeYiDaiProject
//
//  Created by 貟一凡 on 2019/10/30.
//  Copyright © 2019 貟一凡. All rights reserved.
//

#import "NewWebViewController.h"
#import <WebKit/WebKit.h>

@interface NewWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic, strong) UIProgressView *myProgressView;
@end

@implementation NewWebViewController
// 记得取消监听
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = YES;
       [self.view addSubview:self.webView];
       [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(self.view);
       }];
       [self.view addSubview:self.myProgressView];
    
    NSDictionary *dataDic;
    if (self.typeIndex == 2) {
        dataDic = @{@"userId":self.loginModel.userId,@"type":@(self.typeIndex),@"amount":self.loanMoneyStr};
    }else{
        dataDic = @{@"userId":self.loginModel.userId,@"type":@(self.typeIndex)};
    }
    @weakify(self);
    [[RequestAPI shareInstance] useWebGetWebInfo:dataDic Completion:^(BOOL succeed, NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        if (succeed) {
            @strongify(self);
           if ([result[@"success"] intValue] == 1) {
             
               NSDictionary *dic = result[@"result"];
               
               if (!STRING_ISNIL(dic[@"webUrl"])) {
                   self.navigationItem.title = EMPTY_IF_NIL(dic[@"webName"]);
                   
                  [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dic[@"webUrl"]]]];


               }else{
                   
                   [MBProgressHUD showSuccess:@"暂无服务"];
               }
               
           }else{
               
               
               [MBProgressHUD showError:EMPTY_IF_NIL(result[@"message"]) ];
           }
        }
    }];
    
       
}
#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark WKNavigationDelegate

// 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // 可以在这里做正在加载的提示动画 然后在加载完成代理方法里移除动画
    NSLog(@"web开始加载");
}

// 当内容开始到达时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"web已经加载");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"web加载完成");
//    [self.navigationController setNavigationBarHidden:YES];

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"web加载失败");
}
//收到服务器重定向请求后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"重定向");
}
// 在收到响应开始加载后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在请求开始加载之前调用，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    NSString *decodedString = (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)urlStr, CFSTR(""));
    NSLog(@"发送跳转请求：%@",decodedString);

    //自己定义的协议头
    NSString *htmlHeadString = @"github://";
    if([urlStr hasPrefix:htmlHeadString]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"通过截取URL调用OC" message:@"你想前往我的Github主页?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [alertController addAction:([UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString:[urlStr stringByReplacingOccurrencesOfString:@"github://callName_?" withString:@""]];
            [[UIApplication sharedApplication] openURL:url];
        }])];
        [self presentViewController:alertController animated:YES completion:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}
#pragma mark WKUIDelegate
// 在js中调用alert函数时，会调用该方法。
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];

}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];

    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark WKScriptMessageHandler
//获取js传递的数据
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"-------%@",message.name);// 方法名
    NSLog(@"-------%@",message.body);// 传递的数据
    if([message.name isEqualToString:@"nextStep"]){
       
    }
}

- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//        [wkUController removeScriptMessageHandlerForName:@"nextStep"];

//        [wkUController addScriptMessageHandler:self name:@"nextStep"];

        config.userContentController = wkUController;
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        _webView.backgroundColor = [UIColor whiteColor];
        
//        //  h5用rem编写
//        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//
//        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//        [wkUController addUserScript:wkUserScript];
        

        //        _webView.scrollView.delegate = self;
    }
    return _webView;
}
#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
    if (_myProgressView == nil) {
//        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, Height_NavBar+1, [UIScreen mainScreen].bounds.size.width, 0)];
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0,1, [UIScreen mainScreen].bounds.size.width, 0)];

        _myProgressView.tintColor = [UIColor blueColor];
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }
    
    return _myProgressView;
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
