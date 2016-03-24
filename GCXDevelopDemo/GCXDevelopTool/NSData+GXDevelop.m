//
//  NSData+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/3/21.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "NSData+GXDevelop.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (GXDevelop)

- (NSData *)gxAES256EncryptWithKey:(NSString *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        //        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        NSData * data = [NSData dataWithBytes:buffer length:numBytesEncrypted];
        free(buffer);
        return data;
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSData *)gxAES256DecryptWithKey:(NSString *)key {
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        //        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        //        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted freeWhenDone:YES];
        NSData * data = [NSData dataWithBytes:buffer length:numBytesDecrypted];
        free(buffer);
        return data;
    }
    
    free(buffer); //free the buffer;
    return nil;
}


@end
