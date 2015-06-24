// Generated by Apple Swift version 1.2 (swiftlang-602.0.53.1 clang-602.0.53)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
#if __has_feature(nullability)
#  define SWIFT_NULLABILITY(X) X
#else
# if !defined(__nonnull)
#  define __nonnull
# endif
# if !defined(__nullable)
#  define __nullable
# endif
# if !defined(__null_unspecified)
#  define __null_unspecified
# endif
#  define SWIFT_NULLABILITY(X)
#endif
#if defined(__has_feature) && __has_feature(modules)
@import Foundation;
@import UIKit;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIView;


/// HUDController controls showing and hiding of the HUD, as well as its contents and touch response behavior.
SWIFT_CLASS("_TtC5PKHUD5PKHUD")
@interface PKHUD
+ (PKHUD * __nonnull)sharedHUD;
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic) BOOL dimsBackground;
@property (nonatomic) BOOL userInteractionOnUnderlyingViewsEnabled;
@property (nonatomic) UIView * __nonnull contentView;
- (void)show;
- (void)hideWithAnimated:(BOOL)anim;
- (void)hideAfterDelay:(NSTimeInterval)delay;
@end

@class UIImage;


/// Provides a set of default assets, like images, that can be supplied to the PKHUD's contentViews.
SWIFT_CLASS("_TtC5PKHUD11PKHUDAssets")
@interface PKHUDAssets
+ (UIImage * __nonnull)crossImage;
+ (UIImage * __nonnull)checkmarkImage;
+ (UIImage * __nonnull)progressImage;
@end

@class NSCoder;


/// Provides a square view, which you can subclass and add additional views to.
SWIFT_CLASS("_TtC5PKHUD19PKHUDSquareBaseView")
@interface PKHUDSquareBaseView : UIView
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIImageView;


/// Provides a square view, which you can use to display a single image.
SWIFT_CLASS("_TtC5PKHUD14PKHUDImageView")
@interface PKHUDImageView : PKHUDSquareBaseView
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithImage:(UIImage * __nullable)image OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
@property (nonatomic, readonly) UIImageView * __nonnull imageView;
@end



/// Provides a square (indeterminate) progress view.
SWIFT_CLASS("_TtC5PKHUD17PKHUDProgressView")
@interface PKHUDProgressView : PKHUDImageView
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@class UILabel;


/// Provides a square view, which you can use to display a picture, a title and a subtitle. This type of view replicates the Apple HUD one to one.
SWIFT_CLASS("_TtC5PKHUD15PKHUDStatusView")
@interface PKHUDStatusView : PKHUDImageView
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithTitle:(NSString * __nullable)title subtitle:(NSString * __nullable)subtitle image:(UIImage * __nullable)image OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
@property (nonatomic, readonly) UILabel * __nonnull titleLabel;
@property (nonatomic, readonly) UILabel * __nonnull subtitleLabel;
@end



/// Provides a square view, which you can use to display a picture and a subtitle (beneath the image).
SWIFT_CLASS("_TtC5PKHUD17PKHUDSubtitleView")
@interface PKHUDSubtitleView : PKHUDImageView
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithSubtitle:(NSString * __nullable)subtitle image:(UIImage * __nullable)image OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
@property (nonatomic, readonly) UILabel * __nonnull subtitleLabel;
@end



/// / Provides the system UIActivityIndicatorView as an alternative.
SWIFT_CLASS("_TtC5PKHUD32PKHUDSystemActivityIndicatorView")
@interface PKHUDSystemActivityIndicatorView : UIView
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end



/// Provides a wide base view, which you can subclass and add additional views to.
SWIFT_CLASS("_TtC5PKHUD17PKHUDWideBaseView")
@interface PKHUDWideBaseView : UIView
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end



/// Provides a wide, three line text view, which you can use to display information.
SWIFT_CLASS("_TtC5PKHUD13PKHUDTextView")
@interface PKHUDTextView : PKHUDWideBaseView
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithText:(NSString * __nullable)text OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
@property (nonatomic, readonly) UILabel * __nonnull titleLabel;
@end



/// Provides a square view, which you can use to display a picture and a title (above the image).
SWIFT_CLASS("_TtC5PKHUD14PKHUDTitleView")
@interface PKHUDTitleView : PKHUDImageView
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithTitle:(NSString * __nullable)title image:(UIImage * __nullable)image OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
@property (nonatomic, readonly) UILabel * __nonnull titleLabel;
@end


#pragma clang diagnostic pop