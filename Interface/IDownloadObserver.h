//
//  IDownloadObserver.h
//  AutoGenSync
//
//  Created by 魏志强 on 15/9/28.
//  Copyright (c) 2015年 yeelion. All rights reserved.
//

//#ifndef AutoGenSync_IDownloadObserver_h
//#define AutoGenSync_IDownloadObserver_h
//#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "KWOperation.h"
//#import "KWCache.h"


typedef enum _downloadStatus
{
    DownloadStatus_Ready,
    DownloadStatus_Start,
    DownloadStatus_Downloading,
    DownloadStatus_DownloadComplete,
    DownloadStatus_Error
}DownloadStatus;

extern const NSInteger CUSTOM_URL_ACQUIRE_ERROR_CODE;
extern NSError* g_customAcquireURLError;
 //NSURLErrorDomain,
 /*
 enum
 {
 NSURLErrorUnknown = -1,
 NSURLErrorCancelled = -999,
 NSURLErrorBadURL = -1000,
 NSURLErrorTimedOut = -1001,
 NSURLErrorUnsupportedURL = -1002,
 NSURLErrorCannotFindHost = -1003,
 NSURLErrorCannotConnectToHost = -1004,
 NSURLErrorDataLengthExceedsMaximum = -1103,
 NSURLErrorNetworkConnectionLost = -1005,
 NSURLErrorDNSLookupFailed = -1006,
 NSURLErrorHTTPTooManyRedirects = -1007,
 NSURLErrorResourceUnavailable = -1008,
 NSURLErrorNotConnectedToInternet = -1009,
 NSURLErrorRedirectToNonExistentLocation = -1010,
 NSURLErrorBadServerResponse = -1011,
 NSURLErrorUserCancelledAuthentication = -1012,
 NSURLErrorUserAuthenticationRequired = -1013,
 NSURLErrorZeroByteResource = -1014,
 NSURLErrorCannotDecodeRawData = -1015,
 NSURLErrorCannotDecodeContentData = -1016,
 NSURLErrorCannotParseResponse = -1017,
 NSURLErrorInternationalRoamingOff = -1018,
 NSURLErrorCallIsActive = -1019,
 NSURLErrorDataNotAllowed = -1020,
 NSURLErrorRequestBodyStreamExhausted = -1021,
 NSURLErrorFileDoesNotExist = -1100,
 NSURLErrorFileIsDirectory = -1101,
 NSURLErrorNoPermissionsToReadFile = -1102,
 NSURLErrorSecureConnectionFailed = -1200,
 NSURLErrorServerCertificateHasBadDate = -1201,
 NSURLErrorServerCertificateUntrusted = -1202,
 NSURLErrorServerCertificateHasUnknownRoot = -1203,
 NSURLErrorServerCertificateNotYetValid = -1204,
 NSURLErrorClientCertificateRejected = -1205,
 NSURLErrorClientCertificateRequired = -1206,
 NSURLErrorCannotLoadFromNetwork = -2000,
 NSURLErrorCannotCreateFile = -3000,
 NSURLErrorCannotOpenFile = -3001,
 NSURLErrorCannotCloseFile = -3002,
 NSURLErrorCannotWriteToFile = -3003,
 NSURLErrorCannotRemoveFile = -3004,
 NSURLErrorCannotMoveFile = -3005,
 NSURLErrorDownloadDecodingFailedMidStream = -3006,
 NSURLErrorDownloadDecodingFailedToComplete = -3007
 }
//*/

@protocol IDownloadObserver<NSObject>

@property(nonatomic, retain) id<KWOperation> downloadOperation;
//@property(nonatomic, retain) KWCache* cache;
-(BOOL)buildURL:(char*)URL len:(int)len;
-(void)notifyDownloadStart:(long)expectSize;//开始下载
-(void)notifyDownloadStatus:(DownloadStatus)ds withError:(NSError*)error;//通知下载的状态
-(void)notifyProgress:(NSData*)data size:(long)receiveSize expectedSize:(long)expectSize;

@end

//#endif
