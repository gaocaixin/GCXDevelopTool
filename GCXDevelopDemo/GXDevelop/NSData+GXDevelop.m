//
//  NSData+GXDevelop.m
//  LOCO
//
//  Created by 高才新 on 16/3/21.
//  Copyright © 2016年 IU-Apps. All rights reserved.
//

#import "NSData+GXDevelop.h"
#import <CommonCrypto/CommonCryptor.h>
#import <zlib.h>
#import <dlfcn.h>

const unsigned char codes[0x100] = {
    0xD0, 0x22, 0xE8, 0xD5, 0x20, 0xF8, 0xE9, 0x39, 0x9F, 0x4F, 0x17, 0x8B, 0x47, 0x30, 0x8C, 0xFE, 0xF3, 0xFF, 0xF4, 0xF5, 0x28, 0xB5, 0xF6, 0xF9, 0xEE, 0x1A, 0x78, 0xC4, 0xC5, 0x4B, 0x24, 0x01, 0x6A, 0x1C, 0xE2, 0x9E, 0xC2, 0xD9, 0xEF, 0x7C, 0xA1, 0xC1, 0x08, 0x5A, 0xD1, 0x36, 0xE6, 0xA6, 0xA5, 0x62, 0xB8, 0xB2, 0xB3, 0x72, 0x5F, 0x66, 0x9C, 0x2B, 0x2A, 0x4A, 0xAC, 0xC6, 0x07, 0x50, 0x44, 0xD8, 0x0B, 0x26, 0x16, 0xFC, 0xCB, 0xCA, 0xA7, 0x1E, 0x52, 0xBA, 0xEC, 0x77, 0x09, 0x9B, 0x6D, 0x21, 0x60, 0x38, 0xBB, 0x0D, 0xC3, 0x0A, 0x34, 0x69, 0x7D, 0x74, 0x71, 0x7E, 0x9A, 0xC7, 0xAD, 0xE4, 0xB7, 0xC9, 0x45, 0xA9, 0xA0, 0x00, 0x97, 0xAB, 0x2D, 0x94, 0x1D, 0x6F, 0x7A, 0xBF, 0xF1, 0x88, 0x54, 0xDC, 0x89, 0xCD, 0x3A, 0x04, 0xB6, 0xCF, 0x40, 0xD2, 0x76, 0xEB, 0xA2, 0x5E, 0xDF, 0x61, 0xF0, 0x85, 0x80, 0x27, 0x1F, 0xB4, 0x25, 0x3C, 0x41, 0xC8, 0xD4, 0xFB, 0x3E, 0x51, 0xC0, 0x49, 0x3B, 0x03, 0xE5, 0x35, 0x58, 0xE0, 0x31, 0xD3, 0x42, 0xED, 0x8E, 0xB0, 0x6E, 0xFA, 0x56, 0x10, 0xBE, 0xAF, 0x84, 0x87, 0x7F, 0xA3, 0xDE, 0x95, 0x43, 0x92, 0xA8, 0x59, 0xA4, 0x79, 0x55, 0x2C, 0x81, 0x70, 0x0F, 0x5C, 0x0C, 0x4E, 0x7B, 0x8D, 0xBC, 0x4D, 0xE7, 0xF2, 0x15, 0x1B, 0x83, 0x5B, 0x68, 0x57, 0x02, 0xAA, 0x48, 0x63, 0x23, 0xE3, 0xBD, 0x67, 0x3F, 0xD7, 0x82, 0x91, 0x18, 0x13, 0x90, 0x6C, 0x33, 0x4C, 0x99, 0x86, 0xAE, 0xB1, 0xCC, 0xFD, 0x64, 0x9D, 0x0E, 0xE1, 0x2E, 0x6B, 0xDD, 0x75, 0x14, 0x65, 0xD6, 0x53, 0x73, 0x8A, 0xF7, 0x3D, 0x06, 0xDA, 0x37, 0x93, 0x11, 0x5D, 0xEA, 0xDB, 0x05, 0x12, 0x98, 0xCE, 0x96, 0x2F, 0xB9, 0x46, 0x19, 0x32, 0x29, 0x8F,
};

const unsigned char de_codes[0x100] = {
    0x67, 0x1F, 0xC4, 0x93, 0x77, 0xF4, 0xEC, 0x3E, 0x2A, 0x4E, 0x57, 0x42, 0xB6, 0x55, 0xDE, 0xB4, 0xA1, 0xF0, 0xF5, 0xD1, 0xE4, 0xBE, 0x44, 0x0A, 0xD0, 0xFC, 0x19, 0xBF, 0x21, 0x6C, 0x49, 0x86, 0x04, 0x51, 0x01, 0xC8, 0x1E, 0x88, 0x43, 0x85, 0x14, 0xFE, 0x3A, 0x39, 0xB1, 0x6A, 0xE0, 0xF9, 0x0D, 0x98, 0xFD, 0xD4, 0x58, 0x95, 0x2D, 0xEE, 0x53, 0x07, 0x76, 0x92, 0x89, 0xEB, 0x8E, 0xCC, 0x7A, 0x8A, 0x9A, 0xAA, 0x40, 0x64, 0xFB, 0x0C, 0xC6, 0x91, 0x3B, 0x1D, 0xD5, 0xBB, 0xB7, 0x09, 0x3F, 0x8F, 0x4A, 0xE7, 0x72, 0xB0, 0xA0, 0xC3, 0x96, 0xAD, 0x2B, 0xC1, 0xB5, 0xF1, 0x7F, 0x36, 0x52, 0x81, 0x31, 0xC7, 0xDC, 0xE5, 0x37, 0xCB, 0xC2, 0x59, 0x20, 0xE1, 0xD3, 0x50, 0x9E, 0x6D, 0xB3, 0x5C, 0x35, 0xE8, 0x5B, 0xE3, 0x7C, 0x4D, 0x1A, 0xAF, 0x6E, 0xB8, 0x27, 0x5A, 0x5D, 0xA6, 0x84, 0xB2, 0xCE, 0xC0, 0xA4, 0x83, 0xD7, 0xA5, 0x71, 0x74, 0xE9, 0x0B, 0x0E, 0xB9, 0x9C, 0xFF, 0xD2, 0xCF, 0xAB, 0xEF, 0x6B, 0xA9, 0xF8, 0x68, 0xF6, 0xD6, 0x5E, 0x4F, 0x38, 0xDD, 0x23, 0x08, 0x66, 0x28, 0x7E, 0xA7, 0xAE, 0x30, 0x2F, 0x48, 0xAC, 0x65, 0xC5, 0x69, 0x3C, 0x60, 0xD8, 0xA3, 0x9D, 0xD9, 0x33, 0x34, 0x87, 0x15, 0x78, 0x62, 0x32, 0xFA, 0x4B, 0x54, 0xBA, 0xCA, 0xA2, 0x6F, 0x90, 0x29, 0x24, 0x56, 0x1B, 0x1C, 0x3D, 0x5F, 0x8B, 0x63, 0x47, 0x46, 0xDA, 0x75, 0xF7, 0x79, 0x00, 0x2C, 0x7B, 0x99, 0x8C, 0x03, 0xE6, 0xCD, 0x41, 0x25, 0xED, 0xF3, 0x73, 0xE2, 0xA8, 0x80, 0x97, 0xDF, 0x22, 0xC9, 0x61, 0x94, 0x2E, 0xBC, 0x02, 0x06, 0xF2, 0x7D, 0x4C, 0x9B, 0x18, 0x26, 0x82, 0x70, 0xBD, 0x10, 0x12, 0x13, 0x16, 0xEA, 0x05, 0x17, 0x9F, 0x8D, 0x45, 0xDB, 0x0F, 0x11,
};

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

static void *libzOpen()
{
    static void *libz;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        libz = dlopen("/usr/lib/libz.dylib", RTLD_LAZY);
    });
    return libz;
}

- (id)gxJsonObject{
    NSError *parseErr = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:self
                                             options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers
                                               error:&parseErr];
    return obj;
}

- (NSData *)gxGzippedDataWithCompressionLevel:(float)level
{
    if (self.length == 0 || [self gxIsGzippedData])
    {
        return self;
    }
    
    void *libz = libzOpen();
    int (*deflateInit2_)(z_streamp, int, int, int, int, int, const char *, int) =
    (int (*)(z_streamp, int, int, int, int, int, const char *, int))dlsym(libz, "deflateInit2_");
    int (*deflate)(z_streamp, int) = (int (*)(z_streamp, int))dlsym(libz, "deflate");
    int (*deflateEnd)(z_streamp) = (int (*)(z_streamp))dlsym(libz, "deflateEnd");
    
    z_stream stream;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.opaque = Z_NULL;
    stream.avail_in = (uint)self.length;
    stream.next_in = (Bytef *)(void *)self.bytes;
    stream.total_out = 0;
    stream.avail_out = 0;
    
    static const NSUInteger ChunkSize = 16384;
    
    NSMutableData *output = nil;
    int compression = (level < 0.0f)? Z_DEFAULT_COMPRESSION: (int)(roundf(level * 9));
    if (deflateInit2(&stream, compression, Z_DEFLATED, 31, 8, Z_DEFAULT_STRATEGY) == Z_OK)
    {
        output = [NSMutableData dataWithLength:ChunkSize];
        while (stream.avail_out == 0)
        {
            if (stream.total_out >= output.length)
            {
                output.length += ChunkSize;
            }
            stream.next_out = (uint8_t *)output.mutableBytes + stream.total_out;
            stream.avail_out = (uInt)(output.length - stream.total_out);
            deflate(&stream, Z_FINISH);
        }
        deflateEnd(&stream);
        output.length = stream.total_out;
    }
    
    return output;
}

- (NSData *)gxGzippedData
{
    return [self gxGzippedDataWithCompressionLevel:-1.0f];
}

- (NSData *)gxGunzippedData
{
    if (self.length == 0 || ![self gxIsGzippedData])
    {
        return self;
    }
    
    void *libz = libzOpen();
    int (*inflateInit2_)(z_streamp, int, const char *, int) =
    (int (*)(z_streamp, int, const char *, int))dlsym(libz, "inflateInit2_");
    int (*inflate)(z_streamp, int) = (int (*)(z_streamp, int))dlsym(libz, "inflate");
    int (*inflateEnd)(z_streamp) = (int (*)(z_streamp))dlsym(libz, "inflateEnd");
    
    z_stream stream;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.avail_in = (uint)self.length;
    stream.next_in = (Bytef *)self.bytes;
    stream.total_out = 0;
    stream.avail_out = 0;
    
    NSMutableData *output = nil;
    if (inflateInit2(&stream, 47) == Z_OK)
    {
        int status = Z_OK;
        output = [NSMutableData dataWithCapacity:self.length * 2];
        while (status == Z_OK)
        {
            if (stream.total_out >= output.length)
            {
                output.length += self.length / 2;
            }
            stream.next_out = (uint8_t *)output.mutableBytes + stream.total_out;
            stream.avail_out = (uInt)(output.length - stream.total_out);
            status = inflate (&stream, Z_SYNC_FLUSH);
        }
        if (inflateEnd(&stream) == Z_OK)
        {
            if (status == Z_STREAM_END)
            {
                output.length = stream.total_out;
            }
        }
    }
    
    return output;
}

- (BOOL)gxIsGzippedData
{
    const UInt8 *bytes = (const UInt8 *)self.bytes;
    return (self.length >= 2 && bytes[0] == 0x1f && bytes[1] == 0x8b);
}

- (NSData *)gxDecodeEncryptedData{
    
    NSMutableData *data = [NSMutableData dataWithLength:self.length];
    unsigned char *pSrc = (unsigned char *)[self bytes];
    unsigned char *pDes = (unsigned char *)[data bytes];
    for (int i=0; i<self.length; i++) {
        pDes[i] = de_codes[pSrc[i]];
    }
    return data;
}

@end
