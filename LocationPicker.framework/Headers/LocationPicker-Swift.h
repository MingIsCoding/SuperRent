// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.1 clang-703.0.29)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

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
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
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
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
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
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import ObjectiveC;
@import Foundation;
@import MapKit;
@import CoreLocation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class LocationItem;
@class UIImageView;
@class UILabel;
@class UIView;
enum LocationType : NSInteger;
@class NSCoder;

SWIFT_CLASS("_TtC14LocationPicker12LocationCell")
@interface LocationCell : UITableViewCell
@property (nonatomic, strong) LocationItem * _Nullable locationItem;
@property (nonatomic, readonly, strong) UIImageView * _Nonnull iconView;
@property (nonatomic, readonly, strong) UILabel * _Nonnull locationNameLabel;
@property (nonatomic, readonly, strong) UILabel * _Nonnull locationAddressLabel;
@property (nonatomic, readonly, strong) UIView * _Nonnull containerView;
- (nonnull instancetype)initWithLocationType:(enum LocationType)locationType locationItem:(LocationItem * _Nullable)locationItem;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class MKMapItem;


/// A MKMapItem encapsulation class to save you from importing MapKit everywhere in you project and provide some convenience.\Important 
///
/// 
/// This class is a encapsulation of <code>MKMapItem
/// </code>, you can access the <code>MKMapItem
/// </code> object via <code>mapItem
/// </code> property.\Note 
///
/// 
/// <code>LocationItem
/// </code> provides some get-only computed property to access properties of <code>MKMapItem
/// </code> object more easily.<code> var name: String
///  var coordinate: (latitude: Double, longitude: Double)
///  var addressDictionary: [NSObject: AnyObject]?
///  var formattedAddressString: String?
/// 
/// </code>
///
/// This class provides two initialization methods, you can either provide a <code>MKMapItem
/// </code> object or provide a coordinate and an address dictionary to initialize.
///
/// This class is hashable, the hash value of this class is the hash value of the combined string of latitude and longitude.
///
/// This class is equalable, objects have the same latitude and longitude are equal.
///
/// Objects of this class can be encoded and decoded.
///
/// <code>   let locationData = NSKeyedArchiver.archivedDataWithRootObject(locationItem)
///    let locationItem = NSKeyedUnarchiver.unarchiveObjectWithData(locationData) as! LocationItem
/// 
/// </code>
SWIFT_CLASS("_TtC14LocationPicker12LocationItem")
@interface LocationItem : NSObject <NSCoding>
@property (nonatomic, readonly, strong) MKMapItem * _Nonnull mapItem;

/// The name of the location. A reference to MKMapItem object's property name.
@property (nonatomic, readonly, copy) NSString * _Nonnull name;

/// The address dictionary of the location. A reference to MKMapItem object's property placemark.addressDictionary\Note 
///
/// This dictionary along with a coordinate can be used to create a <code>MKPlacemark
/// </code> object which can create a <code>MKMapItem
/// </code> object.
@property (nonatomic, readonly, copy) NSDictionary * _Nullable addressDictionary;

/// The address of the location. This is the value to the key "FormattedAddressLines" in addressDictionary. It is the address text formatted according to user's region.\Note 
///
/// If you would like to format the address yourself, you can use <code>addressDictionary
/// </code> property to create one.
@property (nonatomic, readonly, copy) NSString * _Nullable formattedAddressString;
@property (nonatomic, readonly) NSInteger hashValue;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)initWithMapItem:(MKMapItem * _Nonnull)mapItem OBJC_DESIGNATED_INITIALIZER;
- (BOOL)isEqual:(id _Nullable)object;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)decoder;
- (void)encodeWithCoder:(NSCoder * _Nonnull)coder;
@end

@protocol LocationPickerDelegate;
@protocol LocationPickerDataSource;
@class UIAlertController;
@class UIColor;
@class UIImage;
@class UISearchBar;
@class UITableView;
@class MKMapView;
@class UIBarButtonItem;
enum NavigationItemOrientation : NSInteger;
@class UIGestureRecognizer;
@class NSIndexPath;
@class CLLocationManager;
@class NSError;
@class CLLocation;
@class NSBundle;

SWIFT_CLASS("_TtC14LocationPicker14LocationPicker")
@interface LocationPicker : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate, UIBarPositioningDelegate, UISearchBarDelegate>

/// Completion closure executed after everytime user select a location.\Important 
///
/// 
/// If you override <code>func locationDidSelect(locationItem: LocationItem)
/// </code> without calling <code>super
/// </code>, this closure would not be called.\Note 
///
/// 
/// This closure would be executed multiple times, because user may change selection before final decision.
///
/// To get user's final decition, use <code>var pickCompletion
/// </code> instead.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Delegate</li></ul>
/// <ol><li>conform to <code>protocol LocationPickerDelegate
/// </code></li><li>set the <code>var delegate
/// </code></li><li>implement <code>func locationDidSelect(locationItem: LocationItem)
/// </code></li></ol>
/// <ul><li>Overrride</li></ul>
/// <ol><li>create a subclass of <code>class LocationPicker
/// </code></li><li>override <code>func locationDidSelect(locationItem: LocationItem)
/// </code></li></ol>\See 
/// 
/// <code>var pickCompletion: ((LocationItem) -> Void)?
/// </code>
///
/// <code>func locationDidSelect(locationItem: LocationItem)
/// </code>
///
/// <code>protocol LocationPickerDelegate
/// </code>
@property (nonatomic, copy) void (^ _Nullable selectCompletion)(LocationItem * _Nonnull);

/// Completion closure executed after user finally pick a location.\Important 
///
/// 
/// If you override <code>func locationDidPick(locationItem: LocationItem)
/// </code> without calling <code>super
/// </code>, this closure would not be called.\Note 
///
/// 
/// This closure would be executed only once in <code>func viewWillDisappear(animated: Bool)
/// </code> before this instance of <code>LocationPicker
/// </code> dismissed.
///
/// To get user's every selection, use <code>var selectCompletion
/// </code> instead.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Delegate</li></ul>
/// <ol><li>conform to <code>protocol LocationPickerDelegate
/// </code></li><li>set the <code>var delegate
/// </code></li><li>implement <code>func locationDidPick(locationItem: LocationItem)
/// </code></li></ol>
/// <ul><li>Override</li></ul>
/// <ol><li>create a subclass of <code>class LocationPicker
/// </code></li><li>override <code>func locationDidPick(locationItem: LocationItem)
/// </code></li></ol>\See 
/// 
/// <code>var selectCompletion: ((LocationItem) -> Void)?
/// </code>
///
/// <code>func locationDidPick(locationItem: LocationItem)
/// </code>
///
/// <code>protocol LocationPickerDelegate
/// </code>
@property (nonatomic, copy) void (^ _Nullable pickCompletion)(LocationItem * _Nonnull);

/// Completion closure executed after user delete an alternative location.\Important 
///
/// 
/// If you override <code>func alternativeLocationDidDelete(locationItem: LocationItem)
/// </code> without calling <code>super
/// </code>, this closure would not be called.\Note 
///
/// 
/// This closure would be executed when user delete a location cell from <code>tableView
/// </code>.
///
/// User can only delete the location provided in <code>var alternativeLocations
/// </code> or <code>dataSource
/// </code> method <code>alternativeLocationAtIndex(index: Int) -> LocationItem
/// </code>.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Delegate</li></ul>
/// <ol><li>conform to <code>protocol LocationPickerDataSource
/// </code></li><li>set the <code>var dataSource
/// </code></li><li>implement <code>func commitAlternativeLocationDeletion(locationItem: LocationItem)
/// </code></li></ol>
/// <ul><li>Override</li></ul>
/// <ol><li>create a subclass of <code>class LocationPicker
/// </code></li><li>override <code>func alternativeLocationDidDelete(locationItem: LocationItem)
/// </code></li></ol>\See 
/// 
/// <code>func alternativeLocationDidDelete(locationItem: LocationItem)
/// </code>
///
/// <code>protocol LocationPickerDataSource
/// </code>
@property (nonatomic, copy) void (^ _Nullable deleteCompletion)(LocationItem * _Nonnull);

/// Handler closure executed when user try to fetch current location without location access.\Important 
///
/// 
/// If you override <code>func locationDidDeny(locationPicker: LocationPicker)
/// </code> without calling <code>super
/// </code>, this closure would not be called.\Note 
///
/// 
/// If this neither this closure is not set and the delegate method with the same purpose is not provided, an alert view controller will be presented, you can configure it using <code>func setLocationDeniedAlertControllerTitle
/// </code> or provide a fully cutomized <code>UIAlertController
/// </code> to <code>var locationDeniedAlertController
/// </code>.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Delegate</li></ul>
/// <ol><li>conform to <code>protocol LocationPickerDelegate
/// </code></li><li>set the <code>var delegate
/// </code></li><li>implement <code>func locationDidDeny(locationPicker: LocationPicker)
/// </code></li></ol>
/// <ul><li>Override</li></ul>
/// <ol><li>create a subclass of <code>class LocationPicker
/// </code></li><li>override <code>func locationDidDeny(locationPicker: LocationPicker)
/// </code></li></ol>\See 
/// 
/// <code>func locationDidDeny(locationPicker: LocationPicker)
/// </code>
///
/// <code>protocol LocationPickerDelegate
/// </code>
///
/// <code>var locationDeniedAlertController
/// </code>
///
/// <code>func setLocationDeniedAlertControllerTitle
/// </code>
@property (nonatomic, copy) void (^ _Nullable locationDeniedHandler)(LocationPicker * _Nonnull);

/// Delegate of protocol LocationPickerDelegate
@property (nonatomic, strong) id <LocationPickerDelegate> _Nullable delegate;

/// DataSource of protocol LocationPickerDataSource
@property (nonatomic, strong) id <LocationPickerDataSource> _Nullable dataSource;

/// Locations that show in the location list.\Note 
///
/// 
/// Alternatively, <code>LocationPicker
/// </code> can obtain locations via DataSource:
///
/// <ol><li>conform to <code>protocol LocationPickerDataSource
/// </code></li><li>set the <code>var dataSource
/// </code></li><li>implement <code>func numberOfAlternativeLocations() -> Int
/// </code> to tell the <code>tableView
/// </code> how many rows to display</li><li>implement <code>func alternativeLocationAtIndex(index: Int) -> LocationItem
/// </code></li></ol>\See 
/// 
/// <code>func numberOfAlternativeLocations() -> Int
/// </code>
///
/// <code>func alternativeLocationAtIndex(index: Int) -> LocationItem
/// </code>
///
/// <code>protocol LocationPickerDataSource
/// </code>
@property (nonatomic, copy) NSArray<LocationItem *> * _Nullable alternativeLocations;

/// Alert Controller shows when user try to fetch current location without location permission.\Note 
///
/// 
/// If you are content with the default alert controller, don't set this property, just change the text in it by calling <code>func setLocationDeniedAlertControllerTitle
/// </code> or change the following text directly.<code> var locationDeniedAlertTitle
///  var locationDeniedAlertMessage
///  var locationDeniedGrantText
///  var locationDeniedCancelText
/// 
/// </code>\See 
///
/// 
/// <code>func setLocationDeniedAlertControllerTitle
/// </code>
///
/// <code>var locationDeniedHandler: ((LocationPicker) -> Void)?
/// </code>
///
/// <code>func locationDidDeny(locationPicker: LocationPicker)
/// </code>
///
/// <code>protocol LocationPickerDelegate
/// </code>
@property (nonatomic, strong) UIAlertController * _Nullable locationDeniedAlertController;

/// Text that indicates user's current location. Default is "Current Location".
@property (nonatomic, copy) NSString * _Nonnull currentLocationText;

/// Text of search bar's placeholder. Default is "Search for location".
@property (nonatomic, copy) NSString * _Nonnull searchBarPlaceholder;

/// Text of location denied alert title. Default is "Location access denied"
@property (nonatomic, copy) NSString * _Nonnull locationDeniedAlertTitle;

/// Text of location denied alert message. Default is "Grant location access to use current location"
@property (nonatomic, copy) NSString * _Nonnull locationDeniedAlertMessage;

/// Text of location denied alert Grant button. Default is "Grant"
@property (nonatomic, copy) NSString * _Nonnull locationDeniedGrantText;

/// Text of location denied alert Cancel button. Default is "Cancel"
@property (nonatomic, copy) NSString * _Nonnull locationDeniedCancelText;

/// Longitudinal distance in meters that the map view shows when user select a location and before zoom in or zoom out. Default is 1000.
@property (nonatomic) double defaultLongitudinalDistance;

/// Distance in meters that is used to search locations. Default is 10000
@property (nonatomic) double searchDistance;

/// mapView.zoomEnabled will be set to this property's value after view is loaded. Default is true
@property (nonatomic) BOOL mapViewZoomEnabled;

/// mapView.showsUserLocation is set to this property's value after view is loaded. Default is true
@property (nonatomic) BOOL mapViewShowsUserLocation;

/// mapView.scrollEnabled is set to this property's value after view is loaded. Default is true
@property (nonatomic) BOOL mapViewScrollEnabled;

/// Whether the locations provided in var alternativeLocations or obtained from func alternativeLocationAtIndex(index: Int) -> LocationItem can be deleted. Default is false\Important 
///
/// 
/// If this property is set to <code>true
/// </code>, remember to update your models by closure, delegate, or override.
@property (nonatomic) BOOL alternativeLocationEditable;

/// tableView.backgroundColor is set to this property's value afte view is loaded. Default is UIColor.whiteColor()
@property (nonatomic, strong) UIColor * _Nonnull tableViewBackgroundColor;

/// The color of the icon showed in current location cell. Default is UIColor(hue: 0.447, saturation: 0.731, brightness: 0.569, alpha: 1)
@property (nonatomic, strong) UIColor * _Nonnull currentLocationIconColor;

/// The color of the icon showed in search result location cells. Default is UIColor(hue: 0.447, saturation: 0.731, brightness: 0.569, alpha: 1)
@property (nonatomic, strong) UIColor * _Nonnull searchResultLocationIconColor;

/// The color of the icon showed in alternative location cells. Default is UIColor(hue: 0.447, saturation: 0.731, brightness: 0.569, alpha: 1)
@property (nonatomic, strong) UIColor * _Nonnull alternativeLocationIconColor;

/// The color of the pin showed in the center of map view. Default is UIColor(hue: 0.447, saturation: 0.731, brightness: 0.569, alpha: 1)
@property (nonatomic, strong) UIColor * _Nonnull pinColor;

/// The color of primary text color. Default is UIColor(colorLiteralRed: 0.34902, green: 0.384314, blue: 0.427451, alpha: 1)
@property (nonatomic, strong) UIColor * _Nonnull primaryTextColor;

/// The color of secondary text color. Default is UIColor(colorLiteralRed: 0.541176, green: 0.568627, blue: 0.584314, alpha: 1)
@property (nonatomic, strong) UIColor * _Nonnull secondaryTextColor;

/// The image of the icon showed in current location cell. If this property is set, the var currentLocationIconColor won't be adopted.
@property (nonatomic, strong) UIImage * _Nullable currentLocationIconImage;

/// The image of the icon showed in search result location cells. If this property is set, the var searchResultLocationIconColor won't be adopted.
@property (nonatomic, strong) UIImage * _Nullable searchResultLocationIconImage;

/// The image of the icon showed in alternative location cells. If this property is set, the var alternativeLocationIconColor won't be adopted.
@property (nonatomic, strong) UIImage * _Nullable alternativeLocationIconImage;

/// The image of the pin showed in the center of map view. If this property is set, the var pinColor won't be adopted.
@property (nonatomic, strong) UIImage * _Nullable pinImage;
@property (nonatomic, readonly, strong) UISearchBar * _Nonnull searchBar;
@property (nonatomic, readonly, strong) UITableView * _Nonnull tableView;
@property (nonatomic, readonly, strong) MKMapView * _Nonnull mapView;
@property (nonatomic, readonly, strong) UIImageView * _Nonnull pinView;
@property (nonatomic, readonly, strong) UIBarButtonItem * _Nullable doneButtonItem;
- (void)viewDidLoad;
- (void)viewWillDisappear:(BOOL)animated;

/// Add two bar buttons that confirm and cancel user's location pick.\Important 
///
/// 
/// If this method is called, only when user tap this button can the pick closure, method and delegate method be called.
/// If you don't provide <code>UIBarButtonItem
/// </code> object, default system style bar button will be used.\Note 
///
/// 
/// You don't need to set the <code>target
/// </code> and <code>action
/// </code> property of the buttons, <code>LocationPicker
/// </code> will handle the dismission of this view controller.
///
/// \param doneButtonItem An <code>UIBarButtonItem
/// </code> tapped to confirm selection, default is a <em>Done</em> <code>barButtonSystemItem
/// </code>
///
/// \param cancelButtonItem An <code>UIBarButtonITem
/// </code> tapped to cancel selection, default is a <em>Cancel</em> <code>barButtonSystemItem
/// </code>
///
/// \param doneButtonOrientation The direction of the done button, default is <code>.Right
/// </code>
- (void)addButtons:(UIBarButtonItem * _Nullable)doneButtonItem cancelButtonItem:(UIBarButtonItem * _Nullable)cancelButtonItem doneButtonOrientation:(enum NavigationItemOrientation)doneButtonOrientation;

/// If you are content with the icons provided in LocaitonPicker but not with the colors, you can change them by calling this method.
///
/// This mehod can also change the color of text color all over the UI.\Note 
///
/// 
/// You can set the color of three icons and the pin in map view by setting the attributes listed below, but to keep the UI consistent, this is not recommanded.<code> var currentLocationIconColor
///  var searchResultLocationIconColor
///  var alternativeLocationIconColor
///  var pinColor
/// 
/// </code>
///
/// If you are not satisified with the shape of icons and pin image, you can change them by setting the attributes below.
///
/// <code>   var currentLocationIconImage
///    var searchResultLocationIconImage
///    var alternativeLocationIconImage
///    var pinImage
/// 
/// </code>
/// \param themeColor The color of all icons
///
/// \param primaryTextColor The color of primary text
///
/// \param secondaryTextColor The color of secondary text
- (void)setColors:(UIColor * _Nullable)themeColor primaryTextColor:(UIColor * _Nullable)primaryTextColor secondaryTextColor:(UIColor * _Nullable)secondaryTextColor;

/// Set text of alert controller presented when user try to get current location but denied app's authorization.
///
/// If you are content with the default alert controller provided by <code>LocationPicker
/// </code>, just call this method to change the alert text to your any language you like.\Note 
///
/// 
/// If you are not satisfied with the default alert controller, just set <code>var locationDeniedAlertController
/// </code> to your fully customized alert controller. If you don't want to present an alert controller at all in such situation, you can customize the behavior of <code>LocationPicker
/// </code> by setting closure, using delegate or overriding.
///
/// \param title Text of location denied alert title
///
/// \param message Text of location denied alert message
///
/// \param grantText Text of location denied alert <em>Grant</em> button text
///
/// \param cancelText Text of location denied alert <em>Cancel</em> button text
- (void)setLocationDeniedAlertControllerTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message grantText:(NSString * _Nullable)grantText cancelText:(NSString * _Nullable)cancelText;

/// This method would be called everytime user select a location including the change of region of the map view.\Important 
///
/// 
/// This method includes the following codes:<code> selectCompletion?(locationItem)
///  delegate?.locationDidSelect?(locationItem)
/// 
/// </code>
///
/// So, if you override it without calling <code>super.locationDidSelect(locationItem)
/// </code>, completion closure and delegate method would not be called.\Note 
///
/// 
/// This method would be called multiple times, because user may change selection before final decision.
///
/// To do something with user's final decition, use <code>func locationDidPick(locationItem: LocationItem)
/// </code> instead.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Closure</li></ul>
/// <ol><li>set <code>var selectCompletion
/// </code></li></ol>
/// <ul><li>Delegate</li></ul>
/// <ol><li>conform to <code>protocol LocationPickerDelegate
/// </code></li><li>set the <code>var delegate
/// </code></li><li>implement <code>func locationDidPick(locationItem: LocationItem)
/// </code></li></ol>\See 
/// 
/// <code>var selectCompletion: ((LocationItem) -> Void)?
/// </code>
///
/// <code>func locationDidPick(locationItem: LocationItem)
/// </code>
///
/// <code>protocol LocationPickerDelegate
/// </code>
///
/// \param locationItem The location item user selected
- (void)locationDidSelect:(LocationItem * _Nonnull)locationItem;

/// This method would be called after user finally pick a location.\Important 
///
/// 
/// This method includes the following codes:<code> pickCompletion?(locationItem)
///  delegate?.locationDidPick?(locationItem)
/// 
/// </code>
///
/// So, if you override it without calling <code>super.locationDidPick(locationItem)
/// </code>, completion closure and delegate method would not be called.\Note 
///
/// 
/// This method would be called only once in <code>func viewWillDisappear(animated: Bool)
/// </code> before this instance of <code>LocationPicker
/// </code> dismissed.
///
/// To get user's every selection, use <code>func locationDidSelect(locationItem: LocationItem)
/// </code> instead.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Closure</li></ul>
/// <ol><li>set <code>var pickCompletion
/// </code></li></ol>
/// <ul><li>Delegate</li></ul>
/// <ol><li>conform to <code>protocol LocationPickerDelegate
/// </code></li><li>set the <code>var delegate
/// </code></li><li>implement <code>func locationDidPick(locationItem: LocationItem)
/// </code></li></ol>\See 
/// 
/// <code>var pickCompletion: ((LocationItem) -> Void)?
/// </code>
///
/// <code>func locationDidSelect(locationItem: LocationItem)
/// </code>
///
/// <code>protocol LocationPickerDelegate
/// </code>
///
/// \param locationItem The location item user picked
- (void)locationDidPick:(LocationItem * _Nonnull)locationItem;

/// This method would be called after user delete an alternative location.\Important 
///
/// 
/// This method includes the following codes:<code> deleteCompletion?(locationItem)
///  dataSource?.commitAlternativeLocationDeletion?(locationItem)
/// 
/// </code>
///
/// So, if you override it without calling <code>super.alternativeLocationDidDelete(locationItem)
/// </code>, completion closure and delegate method would not be called.\Note 
///
/// 
/// This method would be called when user delete a location cell from <code>tableView
/// </code>.
///
/// User can only delete the location provided in <code>var alternativeLocations
/// </code> or <code>dataSource
/// </code> method <code>alternativeLocationAtIndex(index: Int) -> LocationItem
/// </code>.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Closure</li></ul>
/// <ol><li>set <code>var deleteCompletion
/// </code></li></ol>
/// <ul><li>Delegate</li></ul>
/// <ol><li>conform to <code>protocol LocationPickerDataSource
/// </code></li><li>set the <code>var dataSource
/// </code></li><li>implement <code>func commitAlternativeLocationDeletion(locationItem: LocationItem)
/// </code></li></ol>\See 
/// 
/// <code>var deleteCompletion: ((LocationItem) -> Void)?
/// </code>
///
/// <code>protocol LocationPickerDataSource
/// </code>
///
/// \param locationItem The location item needs to be deleted
- (void)alternativeLocationDidDelete:(LocationItem * _Nonnull)locationItem;

/// This method would be called when user try to fetch current location without granting location access.\Important 
///
/// 
/// This method includes the following codes:<code> locationDeniedHandler?(self)
///  delegate?.locationDidDeny?(self)
/// 
/// </code>
///
/// So, if you override it without calling <code>super.locationDidDeny(locationPicker)
/// </code>, completion closure and delegate method would not be called.\Note 
///
/// 
/// If you wish to present an alert view controller, just ignore this method. You can provide a fully cutomized <code>UIAlertController
/// </code> to <code>var locationDeniedAlertController
/// </code>, or configure the alert view controller provided by <code>LocationPicker
/// </code> using <code>func setLocationDeniedAlertControllerTitle
/// </code>.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Closure</li></ul>
/// <ol><li>set <code>var locationDeniedHandler
/// </code></li></ol>
/// <ul><li>Delegate</li></ul>
/// <ol><li>conform to <code>protocol LocationPickerDelegate
/// </code></li><li>set the <code>var delegate
/// </code></li><li>implement <code>func locationDidDeny(locationPicker: LocationPicker)
/// </code></li></ol>\See 
/// 
/// <code>var locationDeniedHandler: ((LocationPicker) -> Void)?
/// </code>
///
/// <code>protocol LocationPickerDelegate
/// </code>
///
/// <code>var locationDeniedAlertController
/// </code>
///
/// <code>func setLocationDeniedAlertControllerTitle
/// </code>
///
/// \param locationPicker <code>LocationPicker
/// </code> instance that needs to response to user's location request
- (void)locationDidDeny:(LocationPicker * _Nonnull)locationPicker;
- (BOOL)gestureRecognizer:(UIGestureRecognizer * _Nonnull)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer * _Nonnull)otherGestureRecognizer;
- (void)searchBar:(UISearchBar * _Nonnull)searchBar textDidChange:(NSString * _Nonnull)searchText;
- (void)searchBarSearchButtonClicked:(UISearchBar * _Nonnull)searchBar;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (BOOL)tableView:(UITableView * _Nonnull)tableView canEditRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)mapView:(MKMapView * _Nonnull)mapView regionWillChangeAnimated:(BOOL)animated;
- (void)mapView:(MKMapView * _Nonnull)mapView regionDidChangeAnimated:(BOOL)animated;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didFailWithError:(NSError * _Nonnull)error;
- (void)locationManager:(CLLocationManager * _Nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_PROTOCOL("_TtP14LocationPicker24LocationPickerDataSource_")
@protocol LocationPickerDataSource

/// Tell the tableView of LocationPicker how many locations you want to add to the location list.
///
/// \returns  The number of locations you would like to display in the list
- (NSInteger)numberOfAlternativeLocations;

/// Provide the location item to the location list.
///
/// \param index The index of the location item
///
/// \returns  The location item in the specific index
- (LocationItem * _Nonnull)alternativeLocationAtIndex:(NSInteger)index;
@optional

/// This delegate method would be called after user delete an alternative location.\Note 
///
/// 
/// This method would be called when user delete a location cell from <code>tableView
/// </code>.
///
/// User can only delete the location provided in <code>var alternativeLocations
/// </code> or <code>dataSource
/// </code> method <code>alternativeLocationAtIndex(index: Int) -> LocationItem
/// </code>.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Closure</li></ul>
/// <ol><li>set <code>var deleteCompletion
/// </code></li></ol>
/// <ul><li>Override</li></ul>
/// <ol><li>create a subclass of <code>class LocationPicker
/// </code></li><li>override <code>func alternativeLocationDidDelete(locationItem: LocationItem)
/// </code></li></ol>\See 
/// 
/// <code>var deleteCompletion: ((LocationItem) -> Void)?
/// </code>
///
/// <code>protocol LocationPickerDelegate
/// </code>
///
/// \param locationItem The location item needs to be deleted
- (void)commitAlternativeLocationDeletion:(LocationItem * _Nonnull)locationItem;
@end



/// All methods of this protocol are optional, they allow the delegate to perform actions.
SWIFT_PROTOCOL("_TtP14LocationPicker22LocationPickerDelegate_")
@protocol LocationPickerDelegate
@optional

/// This delegate method would be called everytime user select a location including the change of region of the map view.\Note 
///
/// 
/// This method would be called multiple times, because user may change selection before final decision.
///
/// To do something with user's final decition, use <code>func locationDidPick(locationItem: LocationItem)
/// </code> instead.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Closure</li></ul>
/// <ol><li>set <code>var selectCompletion
/// </code></li></ol>
/// <ul><li>Overrride</li></ul>
/// <ol><li>create a subclass of <code>class LocationPicker
/// </code></li><li>override <code>func locationDidSelect(locationItem: LocationItem)
/// </code></li></ol>\See 
/// 
/// <code>var selectCompletion: ((LocationItem) -> Void)?
/// </code>
///
/// <code>func locationDidPick(locationItem: LocationItem)
/// </code>
///
/// <code>protocol LocationPickerDataSource
/// </code>
///
/// \param locationItem The location item user selected
- (void)locationDidSelect:(LocationItem * _Nonnull)locationItem;

/// This delegate method would be called after user finally pick a location.\Note 
///
/// 
/// This method would be called only once in <code>func viewWillDisappear(animated: Bool)
/// </code> before this instance of <code>LocationPicker
/// </code> dismissed.
///
/// To get user's every selection, use <code>func locationDidSelect(locationItem: LocationItem)
/// </code> instead.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Closure</li></ul>
/// <ol><li>set <code>var pickCompletion
/// </code></li></ol>
/// <ul><li>Override</li></ul>
/// <ol><li>create a subclass of <code>class LocationPicker
/// </code></li><li>override <code>func locationDidPick(locationItem: LocationItem)
/// </code></li></ol>\See 
/// 
/// <code>var pickCompletion: ((LocationItem) -> Void)?
/// </code>
///
/// <code>func locationDidSelect(locationItem: LocationItem)
/// </code>
///
/// <code>protocol LocationPickerDataSource
/// </code>
///
/// \param locationItem The location item user picked
- (void)locationDidPick:(LocationItem * _Nonnull)locationItem;

/// This delegate method would be called when user try to fetch current location without granting location access.\Note 
///
/// 
/// If you wish to present an alert view controller, just ignore this method. You can provide a fully cutomized <code>UIAlertController
/// </code> to <code>var locationDeniedAlertController
/// </code>, or configure the alert view controller provided by <code>LocationPicker
/// </code> using <code>func setLocationDeniedAlertControllerTitle
/// </code>.
///
/// Alternatively, the same result can be achieved by:
///
/// <ul><li>Closure</li></ul>
/// <ol><li>set <code>var locationDeniedHandler
/// </code></li></ol>
/// <ul><li>Override</li></ul>
/// <ol><li>create a subclass of <code>class LocationPicker
/// </code></li><li>override <code>func locationDidDeny(locationPicker: LocationPicker)
/// </code></li></ol>\See 
/// 
/// <code>var locationDeniedHandler: ((LocationPicker) -> Void)?
/// </code>
///
/// <code>protocol LocationPickerDataSource
/// </code>
///
/// <code>var locationDeniedAlertController
/// </code>
///
/// <code>func setLocationDeniedAlertControllerTitle
/// </code>
///
/// \param locationPicker <code>LocationPicker
/// </code> instance that needs to response to user's location request
- (void)locationDidDeny:(LocationPicker * _Nonnull)locationPicker;
@end

typedef SWIFT_ENUM(NSInteger, LocationType) {
  LocationTypeCurrentLocation = 0,
  LocationTypeSearchLocation = 1,
  LocationTypeAlternativeLocation = 2,
};

typedef SWIFT_ENUM(NSInteger, NavigationItemOrientation) {
  NavigationItemOrientationLeft = 0,
  NavigationItemOrientationRight = 1,
};

#pragma clang diagnostic pop
