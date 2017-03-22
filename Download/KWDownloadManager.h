//
//  KWDownloadManager.h
//  AutoGenSync
//
//  Created by 魏志强 on 15/9/28.
//  Copyright (c) 2015年 yeelion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDownloadObserver.h"
#import "KWDownloader.h"

@interface KWDownloadManager : NSObject

+(instancetype)shareDownloadManager;
+(instancetype)shareDownloadManager2DownloadMusic;

//-(BOOL) startUploadLog:(NSURL *)url
//              bodyData:(NSData*)bodyData
//        httpMethodType:(KWHTTPMethodType)methodType
//              callback:(id<IDownloadObserver>)observer;
// 下载其他歌曲信息等
-(BOOL)startDownload:(NSURL *)url
       httpMethodType:(KWHTTPMethodType)methodType
             callback:(id<IDownloadObserver>)observer
           offsetSize:(NSInteger)offset;

// 下载歌曲
-(BOOL)startDownload2DownloadMusic:(NSURL *)url
                    httpMethodType:(KWHTTPMethodType)methodType
                          callback:(id<IDownloadObserver>)observer
                        offsetSize:(NSInteger)offset;

-(BOOL) stopDownload:(NSURL*)url;

@end
