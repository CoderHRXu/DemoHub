//
//  ViewController.m
//  XunFeiDemo
//
//  Created by haoran on 2018/3/8.
//  Copyright © 2018年 Fclassroom. All rights reserved.
//

#import "ViewController.h"
#import <iflyMSC/IFlyMSC.h>
#import "PcmPlayer.h"

@interface ViewController ()<IFlySpeechSynthesizerDelegate>

/** 语音合成类  */
@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;
/** 基于AVPlayer自定义的播放器  */
@property (nonatomic, strong) PcmPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOnlineSynthesizer];
//    [self initLocalSynthesizer];
}


#pragma mark -
- (void)initOnlineSynthesizer{
    
    // 在线合成
    
    //合成服务单例
    self.iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    self.iFlySpeechSynthesizer.delegate = self;
    
    //设置合成参数
    //设置在线工作方式
    [self.iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD] forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //设置音量，取值范围 0~100
    [self.iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]];
    //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
    [self.iFlySpeechSynthesizer setParameter:@" xiaoyan " forKey: [IFlySpeechConstant VOICE_NAME]];
    //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
    [self.iFlySpeechSynthesizer setParameter:nil forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];

}


- (void)initLocalSynthesizer{
    
    self.iFlySpeechSynthesizer              = [IFlySpeechSynthesizer sharedInstance];
    self.iFlySpeechSynthesizer.delegate     = self;
    [self.iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_LOCAL] forKey:[IFlySpeechConstant ENGINE_TYPE]];
    //设置语音合成的启动参数
    [[IFlySpeechUtility getUtility] setParameter:@"tts" forKey:[IFlyResourceUtil ENGINE_START]];

    //设置本地引擎类型
    //设置发音人为小燕
    [self.iFlySpeechSynthesizer setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    //获取离线语音合成发音人资源文件路径。以发音人小燕为例，请确保资源文件的存在。
    NSString *resPath                       = [[NSBundle mainBundle] resourcePath];
    NSString *vcnResPath                    = [[NSString alloc] initWithFormat:@"%@/ttsres/common.jet;%@/tts64res/xiaoyan.jet",resPath,resPath];
    //设置离线语音合成发音人资源文件路径
    [self.iFlySpeechSynthesizer setParameter:vcnResPath forKey:@"tts_res_path"];
    
    [self.iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]];

    //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
    [self.iFlySpeechSynthesizer setParameter:nil forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)startSpeek:(UIButton *)sender {
    //启动合成会话
    if (self.textView.text.length) {
        [self.iFlySpeechSynthesizer startSpeaking: self.textView.text];
    }
}


#pragma mark - IFlySpeechSynthesizerDelegate
/*!
 *  结束回调<br>
 *  当整个合成结束之后会回调此函数
 *
 *  @param error 错误码
 */
- (void) onCompleted:(IFlySpeechError*) error{
    NSLog(@"结束回调--%@",error);
}

/*!
 *  开始合成回调
 */
- (void) onSpeakBegin{
    NSLog(@"开始合成回调");
}

/*!
 *  缓冲进度回调
 *
 *  @param progress 缓冲进度，0-100
 *  @param msg      附件信息，此版本为nil
 */
- (void) onBufferProgress:(int) progress message:(NSString *)msg{
    NSLog(@"缓冲进度回调--进度%d",progress);
}

/*!
 *  播放进度回调
 *
 *  @param progress 当前播放进度，0-100
 *  @param beginPos 当前播放文本的起始位置，0-100
 *  @param endPos 当前播放文本的结束位置，0-100
 */
- (void) onSpeakProgress:(int) progress beginPos:(int)beginPos endPos:(int)endPos{
    NSLog(@"播放进度回调---进度%d",progress);
}

/*!
 *  暂停播放回调
 */
- (void) onSpeakPaused{
    NSLog(@"暂停");
}

/*!
 *  恢复播放回调<br>
 *  注意：此回调方法SDK内部不执行，播放恢复全部在onSpeakBegin中执行
 */
- (void) onSpeakResumed{
    NSLog(@"恢复播放");
}

/*!
 *  正在取消回调<br>
 *  注意：此回调方法SDK内部不执行
 */
- (void) onSpeakCancel{
    NSLog(@"正在取消");
}

/*!
 *  扩展事件回调<br>
 *  根据事件类型返回额外的数据
 *
 *  @param eventType 事件类型，具体参见IFlySpeechEventType枚举。目前只支持EVENT_TTS_BUFFER也就是实时返回合成音频。
 *  @param arg0      arg0
 *  @param arg1      arg1
 *  @param eventData 事件数据
 */
- (void) onEvent:(int)eventType arg0:(int)arg0 arg1:(int)arg1 data:(NSData *)eventData{
    NSLog(@"扩展事件回调");
}


@end
