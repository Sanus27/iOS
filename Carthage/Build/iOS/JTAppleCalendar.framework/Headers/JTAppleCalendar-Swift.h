// Generated by Apple Swift version 4.1 effective-3.3 (swiftlang-902.0.48 clang-902.0.37.1)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
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
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
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
# if __has_attribute(objc_subclassing_restricted)
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
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR __attribute__((enum_extensibility(open)))
# else
#  define SWIFT_ENUM_ATTR
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="JTAppleCalendar",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

@class UICollectionViewLayout;
@class NSCoder;

/// An instance of JTAppleCalendarView (or simply, a calendar view) is a
/// means for displaying and interacting with a gridstyle layout of date-cells
SWIFT_CLASS("_TtC15JTAppleCalendar19JTAppleCalendarView")
@interface JTAppleCalendarView : UICollectionView
/// Configures the size of your date cells
@property (nonatomic) CGFloat cellSize;
/// Enables/Disables the stretching of date cells. When enabled cells will stretch to fit the width of a month in case of a <= 5 row month.
@property (nonatomic) BOOL allowsDateCellStretching SWIFT_DEPRECATED_OBJC("Swift property 'JTAppleCalendarView.allowsDateCellStretching' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Alerts the calendar that range selection will be checked. If you are
/// not using rangeSelection and you enable this,
/// then whenever you click on a datecell, you may notice a very fast
/// refreshing of the date-cells both left and right of the cell you
/// just selected.
@property (nonatomic) BOOL isRangeSelectionUsed SWIFT_DEPRECATED_OBJC("Swift property 'JTAppleCalendarView.isRangeSelectionUsed' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Implemented by subclasses to initialize a new object (the receiver) immediately after memory for it has been allocated.
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
/// Initializes and returns a newly allocated collection view object with the specified frame and layout.
- (nonnull instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout * _Nonnull)layout OBJC_DESIGNATED_INITIALIZER SWIFT_UNAVAILABLE_MSG("Please use JTAppleCalendarView() instead. It manages its own layout.");
/// Initializes using decoder object
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic) UIEdgeInsets sectionInset SWIFT_DEPRECATED_OBJC("Swift property 'JTAppleCalendarView.sectionInset' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
@property (nonatomic) CGFloat minimumInteritemSpacing SWIFT_DEPRECATED_OBJC("Swift property 'JTAppleCalendarView.minimumInteritemSpacing' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
@property (nonatomic) CGFloat minimumLineSpacing SWIFT_DEPRECATED_OBJC("Swift property 'JTAppleCalendarView.minimumLineSpacing' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
@end




SWIFT_AVAILABILITY(ios,introduced=9.0)
@interface JTAppleCalendarView (SWIFT_EXTENSION(JTAppleCalendar))
/// A semantic description of the view’s contents, used to determine whether the view should be flipped when switching between left-to-right and right-to-left layouts.
@property (nonatomic) UISemanticContentAttribute semanticContentAttribute;
@end

@class UIScrollView;

@interface JTAppleCalendarView (SWIFT_EXTENSION(JTAppleCalendar)) <UIScrollViewDelegate>
/// Inform the scrollViewDidEndDecelerating
/// function that scrolling just occurred
- (void)scrollViewDidScrollToTop:(UIScrollView * _Nonnull)scrollView;
- (void)saveLastContentOffset:(CGPoint)offset SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.saveLastContentOffset(_:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Tells the delegate when the user finishes scrolling the content.
- (void)scrollViewWillEndDragging:(UIScrollView * _Nonnull)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(CGPoint * _Nonnull)targetContentOffset;
/// Tells the delegate when a scrolling
/// animation in the scroll view concludes.
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView * _Nonnull)scrollView;
/// Tells the delegate that the scroll view has
/// ended decelerating the scrolling movement.
- (void)scrollViewDidEndDecelerating:(UIScrollView * _Nonnull)scrollView;
/// Tells the delegate that a scroll occured
- (void)scrollViewDidScroll:(UIScrollView * _Nonnull)scrollView;
@end



@class UICollectionReusableView;
@class UICollectionViewCell;

@interface JTAppleCalendarView (SWIFT_EXTENSION(JTAppleCalendar)) <UICollectionViewDataSource, UICollectionViewDelegate>
/// Asks your data source object to provide a
/// supplementary view to display in the collection view.
- (UICollectionReusableView * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView viewForSupplementaryElementOfKind:(NSString * _Nonnull)kind atIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
- (void)collectionView:(UICollectionView * _Nonnull)collectionView willDisplayCell:(UICollectionViewCell * _Nonnull)cell forItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
/// Asks your data source object for the cell that corresponds
/// to the specified item in the collection view.
- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
/// Asks your data sourceobject for the number of sections in
/// the collection view. The number of sections in collectionView.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView * _Nonnull)collectionView SWIFT_WARN_UNUSED_RESULT;
/// Asks your data source object for the number of items in the
/// specified section. The number of rows in section.
- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView numberOfItemsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
/// Asks the delegate if the specified item should be selected.
/// true if the item should be selected or false if it should not.
- (BOOL)collectionView:(UICollectionView * _Nonnull)collectionView shouldSelectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
/// Asks the delegate if the specified item should be deselected.
/// true if the item should be deselected or false if it should not.
- (BOOL)collectionView:(UICollectionView * _Nonnull)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
/// Tells the delegate that the item at the specified index
/// path was selected. The collection view calls this method when the
/// user successfully selects an item in the collection view.
/// It does not call this method when you programmatically
/// set the selection.
- (void)collectionView:(UICollectionView * _Nonnull)collectionView didSelectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
/// Tells the delegate that the item at the specified path was deselected.
/// The collection view calls this method when the user successfully
/// deselects an item in the collection view.
/// It does not call this method when you programmatically deselect items.
- (void)collectionView:(UICollectionView * _Nonnull)collectionView didDeselectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (CGRect)sizeOfDecorationViewWithIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.sizeOfDecorationView(indexPath:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
@end


@interface JTAppleCalendarView (SWIFT_EXTENSION(JTAppleCalendar))
/// Lays out subviews.
- (void)layoutSubviews;
- (void)reloadData SWIFT_UNAVAILABLE;
@end

@protocol UIViewControllerTransitionCoordinator;
@class UINib;
@class JTAppleCollectionReusableView;
@class JTAppleCell;

@interface JTAppleCalendarView (SWIFT_EXTENSION(JTAppleCalendar))
/// Deselect all selected dates
/// <ul>
///   <li>
///     Parameter: this funciton triggers a delegate call by default. Set this to false if you do not want this
///   </li>
/// </ul>
- (void)deselectAllDatesWithTriggerSelectionDelegate:(BOOL)triggerSelectionDelegate SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.deselectAllDates(triggerSelectionDelegate:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Deselect dates
/// <ul>
///   <li>
///     Parameter: Dates - The dates to deselect
///   </li>
///   <li>
///     Parameter: triggerSelectionDelegate - this funciton triggers a delegate call by default. Set this to false if you do not want this
///   </li>
/// </ul>
- (void)deselectWithDates:(NSArray<NSDate *> * _Nonnull)dates triggerSelectionDelegate:(BOOL)triggerSelectionDelegate SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.deselect(dates:triggerSelectionDelegate:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Notifies the container that the size of its view is about to change.
- (void)viewWillTransitionTo:(CGSize)size with:(id <UIViewControllerTransitionCoordinator> _Nonnull)coordinator anchorDate:(NSDate * _Nullable)anchorDate SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.viewWillTransition(to:with:anchorDate:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Generates a range of dates from from a startDate to an
/// endDate you provide
/// Parameter startDate: Start date to generate dates from
/// Parameter endDate: End date to generate dates to
/// returns:
/// - An array of the successfully generated dates
- (NSArray<NSDate *> * _Nonnull)generateDateRangeFrom:(NSDate * _Nonnull)startDate to:(NSDate * _Nonnull)endDate SWIFT_WARN_UNUSED_RESULT SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.generateDateRange(from:to:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Registers a class for use in creating supplementary views for the collection view.
/// For now, the calendar only supports: ‘UICollectionElementKindSectionHeader’ for the forSupplementaryViewOfKind(parameter)
- (void)registerClass:(Class _Nullable)viewClass forSupplementaryViewOfKind:(NSString * _Nonnull)elementKind withReuseIdentifier:(NSString * _Nonnull)identifier;
/// Registers a class for use in creating supplementary views for the collection view.
/// For now, the calendar only supports: ‘UICollectionElementKindSectionHeader’ for the forSupplementaryViewOfKind(parameter)
- (void)registerNib:(UINib * _Nullable)nib forSupplementaryViewOfKind:(NSString * _Nonnull)kind withReuseIdentifier:(NSString * _Nonnull)identifier;
/// Dequeues re-usable calendar cells
- (JTAppleCollectionReusableView * _Nonnull)dequeueReusableJTAppleSupplementaryViewWithReuseIdentifier:(NSString * _Nonnull)identifier for:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier:for:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Registers a nib for use in creating Decoration views for the collection view.
- (void)registerDecorationViewWithNib:(UINib * _Nullable)nib SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.registerDecorationView(nib:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Registers a class for use in creating Decoration views for the collection view.
- (void)registerWithViewClass:(Class _Nullable)className forDecorationViewOfKind:(NSString * _Nonnull)kind SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.register(viewClass:forDecorationViewOfKind:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Dequeues a reuable calendar cell
- (JTAppleCell * _Nonnull)dequeueReusableJTAppleCellWithReuseIdentifier:(NSString * _Nonnull)identifier for:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.dequeueReusableJTAppleCell(withReuseIdentifier:for:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// \param date An anchordate that the calendar will
/// scroll to after reload completes
///
/// \param animation Scroll is animated if this is set to true
///
/// \param completionHandler This closure will run after
/// the reload is complete
///
- (void)reloadDataWithWithanchor:(NSDate * _Nullable)date completionHandler:(void (^ _Nullable)(void))completionHandler SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.reloadData(withanchor:completionHandler:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Reload the date of specified date-cells on the calendar-view
/// \param dates Date-cells with these specified
/// dates will be reloaded
///
- (void)reloadDates:(NSArray<NSDate *> * _Nonnull)dates SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.reloadDates(_:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Select a date-cell range
/// \param startDate Date to start the selection from
///
/// \param endDate Date to end the selection from
///
/// \param triggerDidSelectDelegate Triggers the delegate
/// function only if the value is set to true.
/// Sometimes it is necessary to setup some dates without triggereing
/// the delegate e.g. For instance, when youre initally setting up data
/// in your viewDidLoad
///
/// \param keepSelectionIfMultiSelectionAllowed This is only
/// applicable in allowedMultiSelection = true.
/// This overrides the default toggle behavior of selection.
/// If true, selected cells will remain selected.
///
- (void)selectDatesFrom:(NSDate * _Nonnull)startDate to:(NSDate * _Nonnull)endDate triggerSelectionDelegate:(BOOL)triggerSelectionDelegate keepSelectionIfMultiSelectionAllowed:(BOOL)keepSelectionIfMultiSelectionAllowed SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.selectDates(from:to:triggerSelectionDelegate:keepSelectionIfMultiSelectionAllowed:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Deselect all selected dates within a range
- (void)deselectDatesFrom:(NSDate * _Nonnull)start to:(NSDate * _Nullable)end triggerSelectionDelegate:(BOOL)triggerSelectionDelegate SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.deselectDates(from:to:triggerSelectionDelegate:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Select a date-cells
/// \param date The date-cell with this date will be selected
///
/// \param triggerDidSelectDelegate Triggers the delegate function
/// only if the value is set to true.
/// Sometimes it is necessary to setup some dates without triggereing
/// the delegate e.g. For instance, when youre initally setting up data
/// in your viewDidLoad
///
- (void)selectDates:(NSArray<NSDate *> * _Nonnull)dates triggerSelectionDelegate:(BOOL)triggerSelectionDelegate keepSelectionIfMultiSelectionAllowed:(BOOL)keepSelectionIfMultiSelectionAllowed SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.selectDates(_:triggerSelectionDelegate:keepSelectionIfMultiSelectionAllowed:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
/// Scrolls the calendar view to the start of a section view header.
/// If the calendar has no headers registered, then this function does nothing
/// <ul>
///   <li>
///     Paramater date: The calendar view will scroll to the header of
///     a this provided date
///   </li>
/// </ul>
- (void)scrollToHeaderForDate:(NSDate * _Nonnull)date triggerScrollToDateDelegate:(BOOL)triggerScrollToDateDelegate withAnimation:(BOOL)animation extraAddedOffset:(CGFloat)extraAddedOffset completionHandler:(void (^ _Nullable)(void))completionHandler SWIFT_DEPRECATED_OBJC("Swift method 'JTAppleCalendarView.scrollToHeaderForDate(_:triggerScrollToDateDelegate:withAnimation:extraAddedOffset:completionHandler:)' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
@end


@interface JTAppleCalendarView (SWIFT_EXTENSION(JTAppleCalendar))
/// Workaround for Xcode bug that prevents you from connecting the delegate in the storyboard.
/// Remove this extra property once Xcode gets fixed.
@property (nonatomic, strong) IBOutlet id _Nullable ibCalendarDelegate;
/// Workaround for Xcode bug that prevents you from connecting the delegate in the storyboard.
/// Remove this extra property once Xcode gets fixed.
@property (nonatomic, strong) IBOutlet id _Nullable ibCalendarDataSource;
@property (nonatomic, strong) id <UICollectionViewDelegate> _Nullable delegate;
@property (nonatomic, strong) id <UICollectionViewDataSource> _Nullable dataSource;
/// Returns all selected dates
@property (nonatomic, readonly, copy) NSArray<NSDate *> * _Nonnull selectedDates SWIFT_DEPRECATED_OBJC("Swift property 'JTAppleCalendarView.selectedDates' uses '@objc' inference deprecated in Swift 4; add '@objc' to provide an Objective-C entrypoint");
@end


/// The JTAppleCell class defines the attributes and
/// behavior of the cells that appear in JTAppleCalendarView objects.
SWIFT_CLASS("_TtC15JTAppleCalendar11JTAppleCell")
@interface JTAppleCell : UICollectionViewCell
/// Cell view that will be customized
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
/// Returns an object initialized from data in a given unarchiver.
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
/// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
- (void)awakeFromNib;
@end


/// The header view class of the calendar
SWIFT_CLASS("_TtC15JTAppleCalendar29JTAppleCollectionReusableView")
@interface JTAppleCollectionReusableView : UICollectionReusableView
/// Initializes and returns a newly allocated view object with the specified frame rectangle.
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
/// Returns an object initialized from data in a given unarchiver.
/// self, initialized using the data in decoder.
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end



#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
