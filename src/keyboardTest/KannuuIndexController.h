//
//  KannuuIndexController.h
//  Kannuu
//
//  Created by Waqar Malik on 4/26/15.
//
//

@import Foundation;
#import "kannuuAPI.h"
#import <wchar.h>

#if defined(TARGET_RT_LITTLE_ENDIAN)
#define KannuuUTFUnicodeStringEncoding NSUTF32LittleEndianStringEncoding
#else
#define KannuuUTFUnicodeStringEncoding NSUTF32BigEndianStringEncoding
#endif

typedef NS_ENUM(NSInteger, KannuuControllerMode)
{
    KannuuControllerModeLookup,
    KannuuControllerModeCreate
};

extern NSString * __nonnull const KannuuLookupvCardSymbolString;
extern const NSUInteger KannuuLookupMaxStringSize;
extern const NSUInteger KannuuLookupOptionMaximum;
extern const NSUInteger KannuuLookupOptionDefault;

@interface KannuuIndexController : NSObject
@property (assign, nonatomic, readonly) KannuuControllerMode controllerMode;
@property (assign, nonatomic, readonly) NSUInteger numberOfOptions;
@property (nonnull, copy, nonatomic, readonly) NSString *indexFilePath;
@property (assign, nonatomic, readonly, getter=isComplete) BOOL complete;
@property (assign, nonatomic, readonly, getter=hasMoreOptions) BOOL moreOptions;
@property (assign, nonatomic, readonly) NSInteger optionCount;
@property (assign, nonatomic, readonly) BOOL atTop;
@property (nullable, strong, nonatomic, readonly) NSArray *options;
@property (nullable, strong, nonatomic, readonly) NSString *data;
@property (nullable, strong, nonatomic, readonly) NSString *entrySoFar;

- (nullable instancetype)initWithControllerMode:(KannuuControllerMode)controllerMode indexFilePath:(nonnull NSString *)indexFilePath numberOfOptions:(NSUInteger)numberOfOptions;

- (NSInteger)selectOption:(NSInteger)option;

- (NSInteger)restart;
- (NSInteger)more;
- (NSInteger)back;
- (NSInteger)end;

- (NSInteger)addIndex:(nonnull NSString *)item forData:(nonnull NSString *)data priority:(NSUInteger)priority error:(NSError * __nullable __autoreleasing * __nullable)error;
- (NSInteger)addIndicies:(nonnull NSArray *)indicies forData:(nonnull NSString *)data priority:(NSUInteger)priority error:(NSError * __nullable __autoreleasing * __nullable)error;
- (NSInteger)save;

- (NSInteger)listStart:(NSUInteger)level;
- (nullable NSString *)listNext;
- (NSInteger)listEnd;
@end

@interface NSString (Kannuu)
+ (nonnull NSString *)kannuu_stringWithWideCString:(nonnull wchar_t *)string;
- (nonnull wchar_t *)kannuu_wideCString;
@end