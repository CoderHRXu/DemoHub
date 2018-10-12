//
//  OTAViewController.m
//  HROCDemo
//
//  Created by Jeremy on 16/8/25.
//  Copyright © 2018年 XHR. All rights reserved.
//

#import "OTAViewController.h"
#import "ZipArchive.h"
#import "DownloadH5ZipRequest.h"

@interface OTAViewController ()
@property (weak, nonatomic) IBOutlet UIImageView    *imgView;
@property (weak, nonatomic) IBOutlet UILabel        *progressRateView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel        *statusView;
@property (weak, nonatomic) IBOutlet UIButton       *refreshBtn;
@property (weak, nonatomic) IBOutlet UILabel        *downloadStatusView;
@property (weak, nonatomic) IBOutlet UIButton       *downloadBtn;

@property (nonatomic, assign) BOOL                   canBack;   //控制可不可以返回
@end

@implementation OTAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title                          = @"更新资源";
    self.refreshBtn.hidden              = true;
    self.refreshBtn.backgroundColor     = kGlobalTintColor;
    self.refreshBtn.layer.cornerRadius  = 2;
    self.downloadBtn.backgroundColor    = kGlobalTintColor;
    self.downloadBtn.layer.cornerRadius = 2;
    self.canBack = NO;
    [self loadZip];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (BOOL)navigationShouldPopOnBackButton {
    
    if (self.canBack) {
        return YES;
    } else {
        [XFProgressHUD showAutomaticallyDisappearHUDfromView:self.view withString:@"请等待下载完成"];
        return NO;
    }
}

/**
 *  检测网络变动
 *
 */
- (void)netWorkStatusChanged:(NSNotification *)notification {
    
    switch ([Utils getNetStatus]) {
        case 0: {
            self.statusView.text = @"当前网络状态：无网络";
        }
            break;
        case 1: {
            self.statusView.text = @"当前网络状态：正常";
        }
            break;
        case 2: {
            self.statusView.text = @"当前网络状态：很差";
        }
            break;
        case 3: {
            self.statusView.text = @"当前网络状态：缓慢";
        }
            break;
        case 4: {
            self.statusView.text = @"当前网络状态：正常";
        }
            break;
        default: {
            self.statusView.text = @"当前网络状态：不可识别";
        }
            break;
    }
}

- (IBAction)tapRefresh:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tapDownLoad:(id)sender {
    
    if ([Utils getNetStatus] == 0) {
        
        [XFProgressHUD showAutomaticallyDisappearHUDfromView:self.view withString:@"网络错误，请稍后重试!"];
        return;
    }
    [self loadZip];
}

/**
 下载zip更新包
 */
- (void)loadZip {
    
    self.downloadBtn.hidden = YES;
    self.refreshBtn.hidden = YES;
    
    DownloadH5ZipRequest *downloadH5ZipRequest  = [[DownloadH5ZipRequest alloc] init];
    downloadH5ZipRequest.downloadUrl            = self.fileUrl;
    
    downloadH5ZipRequest.resumableDownloadProgressBlock = ^(NSProgress *progress){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.progressView.progress  = progress.fractionCompleted;
            self.progressRateView.text  = [NSString stringWithFormat:@"%.0f%%", progress.fractionCompleted*100.0];
            self.imgView.image          = [UIImage imageNamed:@"bg_ic_toupdate"];
            self.downloadStatusView.text = @"正在下载文件";
        });
    };
    
    [downloadH5ZipRequest mlStartWithCompletionBlockWithSuccess:^(DownloadH5ZipRequest *request) {
        
        self.imgView.image = [UIImage imageNamed:@"bg_ic_toupdate"];
        self.downloadStatusView.text = @"正在更新文件";
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            
            NSString *toPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSError *unzipError = nil;
            [SSZipArchive unzipFileAtPath:request.filePath toDestination:toPath overwrite:YES password:nil error:&unzipError];
            [[NSFileManager defaultManager] removeItemAtPath:request.filePath error:nil];
            
            if (unzipError == nil) {
                
                //禁用该目录iCloud同步
                NSString *allPath = [toPath stringByAppendingString:@"/wx2"];
                [[NSURL fileURLWithPath:allPath] setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:nil];

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                   
                    self.imgView.image              = [UIImage imageNamed:@"bg_ic_complete"];
                    self.downloadStatusView.hidden  = YES;
                    self.statusView.hidden          = YES;
                    self.refreshBtn.hidden          = NO;
                    self.canBack                    = YES;
                });
            } else {
                
                NSLog(@"Zip包解压失败-%@", unzipError);

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.imgView.image              = [UIImage imageNamed:@"bg_ic_download"];
                    self.downloadStatusView.text    = @"解压失败";
                    self.statusView.text            = @"请稍后重新下载";
                    self.downloadBtn.hidden         = NO;
                    self.canBack                    = YES;
                });
            }
        });
    } failure:^(__kindof BaseRequest *request) {
        
        self.imgView.image              = [UIImage imageNamed:@"bg_ic_download"];
        self.downloadStatusView.text    = @"下载失败";
        self.statusView.text            = @"请在网络较好的情况下重试";
        self.downloadBtn.hidden         = NO;
        self.canBack                    = YES;
    }];
}

@end
