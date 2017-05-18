//
//  YZCaputureViewController.m
//  YZLiveApp
//
//  Created by yz on 16/9/2.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "LiveViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <LFLiveKit/LFLiveKit.h>
@interface LiveViewController ()<LFLiveSessionDelegate,AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>{
    LFLiveSession *_session;
}
@property (nonatomic,retain) LFLiveSession *session;
@property (nonatomic, weak) UIView *livingPreView;
@property (weak, nonatomic) IBOutlet UIButton *beautifulBtn;
@property (weak, nonatomic) IBOutlet UIButton *livingBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *startLiveBtn;

@property (nonatomic,copy) NSString *rtmpUrl;



@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDeviceInput *currentVideoDeviceInput;
@property (nonatomic, weak) UIImageView *focusCursorImageView;
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previedLayer;
@property (nonatomic, weak) AVCaptureConnection *videoConnection;
@end

@implementation LiveViewController
- (UIView *)livingPreView
{
    if (!_livingPreView) {
        UIView *livingPreView = [[UIView alloc] initWithFrame:self.view.bounds];
        livingPreView.backgroundColor = [UIColor clearColor];
        livingPreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:livingPreView atIndex:0];
        _livingPreView = livingPreView;
    }
    return _livingPreView;
}
- (LFLiveSession*)session {
    if (!_session) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        _session.delegate = self;
        _session.running = YES;
        _session.preView = self.livingPreView;
    }
    return _session;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self setup];
}

- (void)setup{
    self.beautifulBtn.layer.cornerRadius = self.beautifulBtn.height * 0.5;
    self.beautifulBtn.layer.masksToBounds = YES;
    
    self.livingBtn.layer.cornerRadius = self.livingBtn.height * 0.5;
    self.livingBtn.layer.masksToBounds = YES;
    
    self.statusLabel.numberOfLines = 0;
    
    // 默认开启后置摄像头, 怕我的面容吓到你们了...
    self.session.captureDevicePosition = AVCaptureDevicePositionBack;
}

- (void)startLive {
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    streamInfo.url = kLiveServer;
//    streamInfo.streamId = @"stream153";
    self.rtmpUrl = streamInfo.url;
    [self.session startLive:streamInfo];
}

- (void)stopLive {
    [self.session stopLive];
}

//MARK: - CallBack:
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange: (LFLiveState)state{
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            self.startLiveBtn.hidden = NO;
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            self.startLiveBtn.hidden = NO;
            break;
        default:
            break;
    }
    self.statusLabel.text = [NSString stringWithFormat:@"状态: %@\nRTMP: %@", tempStatus, self.rtmpUrl];
}
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    MYLogFun;
}
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    MYLogFun;
}

- (IBAction)exit:(id)sender {
    if (self.session.state == LFLivePending || self.session.state == LFLiveStart){
        [self.session stopLive];
    }
    [self.tabBarController setSelectedIndex:0];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)startLive:(id)sender {
    self.livingBtn.hidden = YES;
    [self startLive];
}

- (IBAction)toggleCapture:(id)sender {
    AVCaptureDevicePosition devicePositon = self.session.captureDevicePosition;
    self.session.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    NSLog(@"切换前置/后置摄像头");
}

- (IBAction)beautyFace:(UIButton *)sender {
    sender.selected = !sender.selected;
    // 默认是开启了美颜功能的
    self.session.beautyFace = !self.session.beautyFace;
}




//
//
///**
// *  懒加载聚焦视图
// *
// */
//- (UIImageView *)focusCursorImageView
//{
//    if (_focusCursorImageView == nil) {
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"focus"]];
//        _focusCursorImageView = imageView;
//        [self.view addSubview:_focusCursorImageView];
//    }
//    return _focusCursorImageView;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    self.title = @"视频采集";
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    [self setupCaputureVideo];
//    
//}
//
//// 捕获音视频
//- (void)setupCaputureVideo
//{
//    // 1.创建捕获会话,必须要强引用，否则会被释放
//    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
//    _captureSession = captureSession;
//    
//    // 2.获取摄像头设备，默认是后置摄像头
//    AVCaptureDevice *videoDevice = [self getVideoDevice:AVCaptureDevicePositionFront];
//    
//    // 3.获取声音设备
//    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
//    
//    // 4.创建对应视频设备输入对象
//    AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
//    _currentVideoDeviceInput = videoDeviceInput;
//    
//    // 5.创建对应音频设备输入对象
//    AVCaptureDeviceInput *audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
//    
//    // 6.添加到会话中
//    // 注意“最好要判断是否能添加输入，会话不能添加空的
//    // 6.1 添加视频
//    if ([captureSession canAddInput:videoDeviceInput]) {
//        [captureSession addInput:videoDeviceInput];
//    }
//    // 6.2 添加音频
//    if ([captureSession canAddInput:audioDeviceInput]) {
//        [captureSession addInput:audioDeviceInput];
//    }
//    
//    // 7.获取视频数据输出设备
//    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
//    // 7.1 设置代理，捕获视频样品数据
//    // 注意：队列必须是串行队列，才能获取到数据，而且不能为空
//    dispatch_queue_t videoQueue = dispatch_queue_create("Video Capture Queue", DISPATCH_QUEUE_SERIAL);
//    [videoOutput setSampleBufferDelegate:self queue:videoQueue];
//    if ([captureSession canAddOutput:videoOutput]) {
//        [captureSession addOutput:videoOutput];
//    }
//    
//    // 8.获取音频数据输出设备
//    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
//    // 8.2 设置代理，捕获视频样品数据
//    // 注意：队列必须是串行队列，才能获取到数据，而且不能为空
//    dispatch_queue_t audioQueue = dispatch_queue_create("Audio Capture Queue", DISPATCH_QUEUE_SERIAL);
//    [audioOutput setSampleBufferDelegate:self queue:audioQueue];
//    if ([captureSession canAddOutput:audioOutput]) {
//        [captureSession addOutput:audioOutput];
//    }
//    
//    // 9.获取视频输入与输出连接，用于分辨音视频数据
//    _videoConnection = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
//    
//    // 10.添加视频预览图层
//    AVCaptureVideoPreviewLayer *previedLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
//    previedLayer.frame = [UIScreen mainScreen].bounds;
//    [self.view.layer insertSublayer:previedLayer atIndex:0];
//    _previedLayer = previedLayer;
//    
//    // 11.启动会话
//    [captureSession startRunning];
//}
//
//// 指定摄像头方向获取摄像头
//- (AVCaptureDevice *)getVideoDevice:(AVCaptureDevicePosition)position
//{
//    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//    for (AVCaptureDevice *device in devices) {
//        if (device.position == position) {
//            return device;
//        }
//    }
//    return nil;
//}
//
//#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
//// 获取输入设备数据，有可能是音频有可能是视频
//- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
//{
//    if (_videoConnection == connection) {
//        NSLog(@"采集到视频数据");
//    } else {
//        NSLog(@"采集到音频数据");
//    }
//}
//
//// 切换摄像头
//- (IBAction)toggleCapture:(id)sender {
//    
//    // 获取当前设备方向
//    AVCaptureDevicePosition curPosition = _currentVideoDeviceInput.device.position;
//    
//    // 获取需要改变的方向
//    AVCaptureDevicePosition togglePosition = curPosition == AVCaptureDevicePositionFront?AVCaptureDevicePositionBack:AVCaptureDevicePositionFront;
//    
//    // 获取改变的摄像头设备
//    AVCaptureDevice *toggleDevice = [self getVideoDevice:togglePosition];
//    
//    // 获取改变的摄像头输入设备
//    AVCaptureDeviceInput *toggleDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:toggleDevice error:nil];
//    
//    // 移除之前摄像头输入设备
//    [_captureSession removeInput:_currentVideoDeviceInput];
//    
//    // 添加新的摄像头输入设备
//    [_captureSession addInput:toggleDeviceInput];
//    
//    // 记录当前摄像头输入设备
//    _currentVideoDeviceInput = toggleDeviceInput;
//    
//}
//
//// 点击屏幕，出现聚焦视图
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    // 获取点击位置
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self.view];
//    
//    // 把当前位置转换为摄像头点上的位置
//    CGPoint cameraPoint = [_previedLayer captureDevicePointOfInterestForPoint:point];
//    
//    // 设置聚焦点光标位置
//    [self setFocusCursorWithPoint:point];
//    
//    // 设置聚焦
//    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
//}
//
///**
// *  设置聚焦光标位置
// *
// *  @param point 光标位置
// */
//-(void)setFocusCursorWithPoint:(CGPoint)point{
//    self.focusCursorImageView.center=point;
//    self.focusCursorImageView.transform=CGAffineTransformMakeScale(1.5, 1.5);
//    self.focusCursorImageView.alpha=1.0;
//    [UIView animateWithDuration:1.0 animations:^{
//        self.focusCursorImageView.transform=CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        self.focusCursorImageView.alpha=0;
//        
//    }];
//}
//
///**
// *  设置聚焦
// */
//-(void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{
//    
//    AVCaptureDevice *captureDevice = _currentVideoDeviceInput.device;
//    // 锁定配置
//    [captureDevice lockForConfiguration:nil];
//    
//    // 设置聚焦
//    if ([captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
//        [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
//    }
//    if ([captureDevice isFocusPointOfInterestSupported]) {
//        [captureDevice setFocusPointOfInterest:point];
//    }
//    
//    // 设置曝光
//    if ([captureDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
//        [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
//    }
//    if ([captureDevice isExposurePointOfInterestSupported]) {
//        [captureDevice setExposurePointOfInterest:point];
//    }
//    
//    // 解锁配置
//    [captureDevice unlockForConfiguration];
//}
//
//

@end
