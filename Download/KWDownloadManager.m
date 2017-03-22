//
//  KWDownloadManager.m
//  AutoGenSync
//
//  Created by 魏志强 on 15/9/28.
//  Copyright (c) 2015年 yeelion. All rights reserved.
//

#import "KWDownloadManager.h"
#import "KWDownloader.h"
#import "KWUtility.h"

@interface KWDownloadManager()
@property(nonatomic, retain) NSRecursiveLock* containerLock;
@property(nonatomic, retain) NSMutableDictionary* dictDownload; //<url, IDownloadObserver*>
@end

@implementation KWDownloadManager

+(instancetype)shareDownloadManager
{
    static KWDownloadManager* dlm;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dlm = [[KWDownloadManager alloc] init];
    });
    return dlm;
}

+(instancetype)shareDownloadManager2DownloadMusic
{
    static KWDownloadManager* dlm2Music;
    static dispatch_once_t once2Music;
    dispatch_once(&once2Music, ^{
        dlm2Music = [[KWDownloadManager alloc] init];
    });
    return dlm2Music;
}

-(instancetype)init
{
    if(self = [super init])
    {
        _containerLock = [[NSRecursiveLock alloc]init];
        _dictDownload = [NSMutableDictionary new];
    }
    return self;
}

//-(BOOL) startUploadLog:(NSURL *)url
//              bodyData:(NSData*)bodyData
//        httpMethodType:(KWHTTPMethodType)methodType
//              callback:(id<IDownloadObserver>)observer
//{
//    [[KWDownloader sharedDownloader] setBody:bodyData];
//    return [self executeHttpRequest:url httpMethodType:methodType callback:observer];
//
//}

-(BOOL) startDownload:(NSURL *)url
       httpMethodType:(KWHTTPMethodType)methodType
             callback:(id<IDownloadObserver>)observer
           offsetSize:(NSInteger)offset
{
//    return [self executeHttpRequest:url httpMethodType:methodType callback:observer];
//}
//
//-(BOOL) executeHttpRequest:(NSURL *)url
//            httpMethodType:(KWHTTPMethodType)methodType
//                  callback:(id<IDownloadObserver>)observer
//{
    id <KWOperation> dlOp = [[KWDownloader sharedDownloader] downloadWithURL:url
                                                              httpMethodType:methodType
                                                                     options:KWDownloaderUseNSURLCache
                                                                       start:^(NSInteger expectedSize) {
                                                                           [observer notifyDownloadStart:expectedSize];
                                                                           [observer notifyDownloadStatus:DownloadStatus_Start withError:nil];
                                                                       }
                                                                    progress:^(NSData* data, NSInteger receivedSize, NSInteger expectedSize) {
//                                                                        NSLog(@"progress: receiveSize=%ld, expectedSize=%ld", receivedSize, expectedSize);
                                                                        [observer notifyDownloadStatus:DownloadStatus_Downloading withError:nil];
                                                                        [observer notifyProgress:data size:receivedSize expectedSize:expectedSize];
                                                                    }
                                                                   completed:^(NSError *error, BOOL finished) {
                                                                       if(error!=nil)
                                                                       {
                                                                           NSLog(@"complete:下载出现错误，错误code=%ld", [error code]);
                                                                           [observer notifyDownloadStatus:DownloadStatus_Error withError:error];
                                                                       }
                                                                       else
                                                                       {
                                                                           NSLog(@"complete:下载成功");
                                                                           [observer notifyDownloadStatus:DownloadStatus_DownloadComplete withError:nil];
                                                                       }
                                                                       [_containerLock lock];
                                                                       [_dictDownload removeObjectForKey:url];//直接使用捕获的url
                                                                       [_containerLock unlock];
                                                                   }
                                                                  offsetSize:offset
                             ];
    if(dlOp!=nil)
    {
        observer.downloadOperation = dlOp;
        [_containerLock lock];
        [_dictDownload setObject:observer forKey:url];
        [_containerLock unlock];
    }
    
    return YES;
}

-(BOOL)startDownload2DownloadMusic:(NSURL *)url
                    httpMethodType:(KWHTTPMethodType)methodType
                          callback:(id<IDownloadObserver>)observer
                        offsetSize:(NSInteger)offset
{
    id <KWOperation> dlOp = [[KWDownloader sharedDownloader2DownloadMusic] downloadWithURL:url
                                                              httpMethodType:methodType
                                                                     options:KWDownloaderUseNSURLCache
                                                                       start:^(NSInteger expectedSize) {
                                                                           [observer notifyDownloadStart:expectedSize];
                                                                           [observer notifyDownloadStatus:DownloadStatus_Start withError:nil];
                                                                       }
                                                                    progress:^(NSData* data, NSInteger receivedSize, NSInteger expectedSize) {
                                                                        //                                                                        NSLog(@"progress: receiveSize=%ld, expectedSize=%ld", receivedSize, expectedSize);
                                                                        [observer notifyDownloadStatus:DownloadStatus_Downloading withError:nil];
                                                                        [observer notifyProgress:data size:receivedSize expectedSize:expectedSize];
                                                                    }
                                                                   completed:^(NSError *error, BOOL finished) {
                                                                       if(error!=nil)
                                                                       {
                                                                           NSLog(@"complete:下载出现错误，错误code=%ld", [error code]);
                                                                           [observer notifyDownloadStatus:DownloadStatus_Error withError:error];
                                                                       }
                                                                       else
                                                                       {
                                                                           NSLog(@"complete:下载成功");
                                                                           [observer notifyDownloadStatus:DownloadStatus_DownloadComplete withError:nil];
                                                                       }
                                                                       [_containerLock lock];
                                                                       [_dictDownload removeObjectForKey:url];//直接使用捕获的url
                                                                       [_containerLock unlock];
                                                                   }
                                                                  offsetSize:offset
                             ];
    if(dlOp!=nil)
    {
        observer.downloadOperation = dlOp;
        [_containerLock lock];
        [_dictDownload setObject:observer forKey:url];
        [_containerLock unlock];
    }
    
    return YES;
}

-(BOOL) stopDownload:(NSURL*)url
{
    if(_dictDownload==nil)
    {
        return NO;
    }
    [_containerLock lock];
    [_dictDownload enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([url isEqual:key])
        {
            id curOP = ((id<IDownloadObserver>)obj).downloadOperation;
            if(curOP!=nil)
            {
                [curOP cancel];
            }
        }
    }];
    [_containerLock unlock];
    
    return YES;
}


@end
