//
//  ODContentFilterEditRule.m
//  Odyssey
//
//  Created by Terminator on 4/24/17.
//  Copyright © 2017 home. All rights reserved.
//

#import "ODContentFilterEditRule.h"
#import "ODDelegate.h"

@interface ODContentFilterEditRule ()
{
    IBOutlet NSTextView *_textView;
    BOOL _wasCancelled;
}


-(IBAction)okButtonClicked:(id)sender;
-(IBAction)cancelButtonClicked:(id)sender;

@end

@implementation ODContentFilterEditRule

-(NSString *)nibName 
{
    return [self className];
}

-(void)editRule:(NSString *)rule withReply:(void (^)(NSString *))respond
{
    
    NSView *view = self.view;
    //NSRect viewFrame = view.frame;
    _textView.string = rule;
    _wasCancelled = YES;
    
//    NSInteger styleMask = NSTitledWindowMask | NSTexturedBackgroundWindowMask | NSUtilityWindowMask;
//    NSPanel *window = [[NSPanel alloc] initWithContentRect:viewFrame styleMask:styleMask backing:NSBackingStoreBuffered defer:YES];
//    [window setBackgroundColor:[NSColor blackColor]];
//    NSRect frame = [[NSApp mainWindow] frame];
//    NSPoint point =  NSMakePoint(NSMinX(frame) + ((NSWidth(frame) - NSWidth(viewFrame)) / 2),
//                                 NSMinY(frame) + ((NSHeight(frame) - NSHeight(viewFrame)) / 2));
//    [window setFrameOrigin:point];
//    [window.contentView addSubview:view];
    NSPanel *window = [(ODDelegate *)[NSApp delegate] modalDialogWithView:view];
    [window setInitialFirstResponder:_textView];
    [window makeKeyAndOrderFront:nil];
    
    [NSApp runModalForWindow:window];
    // sheet is up here...
    
    [NSApp endSheet:window];
    [window orderOut:self];
    
    if (!_wasCancelled) {
        rule = _textView.string;
    } else {
        rule = nil;
    }
    respond(rule);
}

-(void)okButtonClicked:(id)sender
{
    _wasCancelled = NO;
    [NSApp stopModal];
}

-(void)cancelButtonClicked:(id)sender
{
    _wasCancelled = YES;
    [NSApp stopModal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

@end
