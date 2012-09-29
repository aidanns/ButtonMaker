//
//  ButtonMakerViewController.m
//  ButtonMaker
//
//  Created by Dermot Daly on 22/04/2010.
//  Copyright tapadoo 2010. All rights reserved.
//

#import "ButtonMakerViewController.h"
#import <QuartzCore/QuartzCore.h>
@implementation ButtonMakerViewController

@synthesize redSlider;
@synthesize greenSlider;
@synthesize blueSlider;
@synthesize widthSlider;
@synthesize heightSlider;

@synthesize redValueLabel;
@synthesize greenValueLabel;
@synthesize blueValueLabel;
@synthesize heightLabel;
@synthesize widthLabel;

@synthesize addB, addG, addH, addR, addW, subB, subG, subH, subR, subW, nameField, textLabelField, matteGlossy;
@synthesize matteButtonStyleLabel, matteButtonStyleStepper, matteButtonBarStyleLabel, matteButtonStyleNameLabel;
@synthesize matteButtonBarStyleStepper, matteButtonBarStyleNameLabel;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
  // Force the first draw
    glossy = TRUE;
    [matteButtonBarStyleStepper setMaximumValue:4];
    [matteButtonBarStyleStepper setMinimumValue:0];
    [matteButtonBarStyleStepper setStepValue:1];
    [matteButtonStyleStepper setMaximumValue:6];
    [matteButtonStyleStepper setMinimumValue:0];
    [matteButtonStyleStepper setStepValue:1];
    [matteButtonBarStyleStepper setValue:0];
    [matteButtonStyleStepper setValue:0];
    [matteButtonStyleStepper setWraps:YES];
    [matteButtonBarStyleStepper setWraps:YES];
    [matteButtonBarStyleStepper setHidden:TRUE];
    [matteButtonStyleStepper setHidden:TRUE];
    [matteButtonBarStyleLabel setHidden:TRUE];
    [matteButtonBarStyleNameLabel setHidden:TRUE];
    [matteButtonStyleLabel setHidden:TRUE];
    [matteButtonStyleNameLabel setHidden:TRUE];
  [self colorSliderChanged:nil];
  [self sizeSlideChanged:nil];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

  // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}


- (void)dealloc {
  [theButton release];
    [super dealloc];
}

-(void) updateButton {
  if(theButton != nil) {
    [theButton removeFromSuperview];
    [theButton release];
    theButton = nil;
  }
  // OK - Create it
  CGFloat width = roundf(widthSlider.value);
  CGFloat height = roundf(heightSlider.value);
  CGFloat x = nameField.frame.origin.x+nameField.frame.size.width/2 - width/2;
  CGFloat y = ((textLabelField.center.y+matteButtonStyleStepper.center.y)-height)/2;
  CGFloat red = roundf(redSlider.value)/255.0;
  CGFloat green = roundf(greenSlider.value)/255.0;
  CGFloat blue = roundf(blueSlider.value)/255.0;

    Class theClass;

  if(glossy) {
        theClass = NSClassFromString(@"UIGlassButton");
    }
    else {
        theClass = NSClassFromString(@"UINavigationButton");
    }
  theButton = [[theClass alloc] initWithFrame:CGRectMake(x, y, width, height)];
  if(glossy || matteButtonBarStyle == 4) {
        [theButton setValue:[UIColor colorWithRed:red green:green blue:blue alpha:1.0] forKey:@"tintColor"];
    }
    else {
        [theButton setValue:[NSNumber numberWithInt:matteButtonBarStyle] forKey:@"barStyle"];
        [theButton setValue:[NSNumber numberWithInt:matteButtonStyle] forKey:@"style"];
    }
  [theButton setTitle:textLabelField.text forState:UIControlStateNormal];

  [self.view addSubview:theButton];
}

-(IBAction) textLabelChanged:(id)sender {
    [self updateButton];
}

-(IBAction) colorSliderChanged:(id)sender {
  // Update all the color labels
  redValueLabel.text = [NSString stringWithFormat:@"%.0f", roundf(redSlider.value)];
  blueValueLabel.text = [NSString stringWithFormat:@"%.0f", roundf(blueSlider.value)];
  greenValueLabel.text = [NSString stringWithFormat:@"%.0f", roundf(greenSlider.value)];
  [self updateButton];
}
-(IBAction) sizeSlideChanged:(id)sender {
  widthLabel.text = [NSString stringWithFormat:@"%.0f", roundf(widthSlider.value)];
  heightLabel.text = [NSString stringWithFormat:@"%.0f", roundf(heightSlider.value)];
  [self updateButton];
}

- (void) saveImageToFile: (NSString *) filePath isRetina:(BOOL)isRetina
{
  if (isRetina)
  {
    if (UIGraphicsBeginImageContextWithOptions == NULL)
    {
      return;
    }
    UIGraphicsBeginImageContextWithOptions(theButton.frame.size, NO, 2.0);
  }
  else
  {
    UIGraphicsBeginImageContext(theButton.frame.size);
  }

  CGContextRef theContext = UIGraphicsGetCurrentContext();
  [theButton.layer renderInContext:theContext];
        CGRect          overDrawRects[] = {CGRectMake(10, 0, 1, theButton.frame.size.height), CGRectMake(theButton.frame.size.width - 11, 0, 1, theButton.frame.size.height)};

  [[UIColor clearColor] set];

  for (int i = 0; i < 2; i++) {
    UIRectFill(overDrawRects[i]);
    CGContextSaveGState(theContext);
    CGContextClipToRect(theContext, overDrawRects[i]);
    CGContextTranslateCTM(theContext, -1, 0);
    [theButton.layer renderInContext:theContext];
    CGContextRestoreGState(theContext);
  }

  UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
  NSData *theData = UIImagePNGRepresentation(theImage);
  [theData writeToFile: filePath atomically:NO];
  UIGraphicsEndImageContext();
}

-(IBAction) saveTapped:(id)sender {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];

  // the path to write file
  NSString *buttonFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@", [nameField text], @"button.png"]];
  NSString *buttonHighlightFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@", [nameField text], @"button_highlight.png"]];
  NSString *buttonRetinaFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@", [nameField text], @"button@2x.png"]];
  NSString *buttonRetinaHighlightFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@", [nameField text], @"button-highlight@2x.png"]];

  [self saveImageToFile: buttonFile isRetina:NO];
  [self saveImageToFile: buttonRetinaFile isRetina:YES];

  [theButton setHighlighted:YES];

  [self saveImageToFile: buttonHighlightFile isRetina:NO];
  [self saveImageToFile: buttonRetinaHighlightFile isRetina:YES];

  [theButton setHighlighted:NO];
  NSString *msg = [NSString stringWithFormat:@"Wrote files to %@", documentsDirectory];
  UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Done" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
  [alertView show];
}

-(IBAction)addButtonPressed:(id)sender {
    unichar which;
    if(sender == addR) which = 'R';
    if(sender == addG) which = 'G';
    if(sender == addB) which = 'B';
    if(sender == addH) which = 'H';
    if(sender == addW) which = 'W';
    switch(which) {
        case 'R': {
            [redSlider setValue:[redSlider value]+1 animated:YES];
            [self colorSliderChanged:nil];
            break;
        }
        case 'G': {
            [greenSlider setValue:[greenSlider value]+1 animated:YES];
            [self colorSliderChanged:nil];
            break;
        }
        case 'B': {
            [blueSlider setValue:[blueSlider value]+1 animated:YES];
            [self colorSliderChanged:nil];
            break;
        }
        case 'W': {
            [widthSlider setValue:[widthSlider value]+1 animated:YES];
            [self sizeSlideChanged:nil];
            break;
        }
        case 'H': {
            [heightSlider setValue:[heightSlider value]+1 animated:YES];
            [self sizeSlideChanged:nil];
            break;
        }
    }
}

-(IBAction)subtractButtonPressed:(id)sender {
    unichar which;
    if(sender == subR) which = 'R';
    if(sender == subG) which = 'G';
    if(sender == subB) which = 'B';
    if(sender == subH) which = 'H';
    if(sender == subW) which = 'W';
    switch(which) {
        case 'R': {
            [redSlider setValue:[redSlider value]-1 animated:YES];
            [self colorSliderChanged:nil];
            break;
        }
        case 'G': {
            [greenSlider setValue:[greenSlider value]-1 animated:YES];
            [self colorSliderChanged:nil];
            break;
        }
        case 'B': {
            [blueSlider setValue:[blueSlider value]-1 animated:YES];
            [self colorSliderChanged:nil];
            break;
        }
        case 'W': {
            [widthSlider setValue:[widthSlider value]-1 animated:YES];
            [self sizeSlideChanged:nil];
            break;
        }
        case 'H': {
            [heightSlider setValue:[heightSlider value]-1 animated:YES];
            [self sizeSlideChanged:nil];
            break;
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(IBAction)matteGlossyChanged:(id)sender {
    if([matteGlossy selectedSegmentIndex] == 0) {
        //Glossy; default
        glossy = TRUE;
        [self updateButton];
        [matteButtonBarStyleStepper setHidden:TRUE];
        [matteButtonStyleStepper setHidden:TRUE];
        [matteButtonBarStyleLabel setHidden:TRUE];
        [matteButtonBarStyleNameLabel setHidden:TRUE];
        [matteButtonStyleLabel setHidden:TRUE];
        [matteButtonStyleNameLabel setHidden:TRUE];
    }
    else {
        //Matte
        glossy = FALSE;
        [self updateButton];
        [matteButtonBarStyleStepper setHidden:FALSE];
        [matteButtonStyleStepper setHidden:FALSE];
        [matteButtonBarStyleLabel setHidden:FALSE];
        [matteButtonBarStyleNameLabel setHidden:FALSE];
        [matteButtonStyleLabel setHidden:FALSE];
        [matteButtonStyleNameLabel setHidden:FALSE];
    }
}

-(IBAction)barStyleStepped:(id)sender {
    matteButtonBarStyle = [(UIStepper *)sender value];
    switch(matteButtonBarStyle) {
        case 0: {
            [matteButtonBarStyleLabel setText:@"Default"];
            break;
        }
        case 1: {
            [matteButtonBarStyleLabel setText:@"Black"];
            break;
        }
        case 2: {
            [matteButtonBarStyleLabel setText:@"Black T"];
            break;
        }
        case 3: {
            [matteButtonBarStyleLabel setText:@"Popover"];
            break;
        }
        case 4: {
            [matteButtonBarStyleLabel setText:@"Custom tint"];
            break;
        }
    }
    [self updateButton];
}

-(IBAction)styleStepped:(id)sender {
    matteButtonStyle = [(UIStepper *)sender value];
    switch(matteButtonStyle) {
        case 0: {
            [matteButtonStyleLabel setText:@"Default"];
            break;
        }
        case 1: {
            [matteButtonStyleLabel setText:@"Back"];
            break;
        }
        case 2: {
            [matteButtonStyleLabel setText:@"Done"];
            break;
        }
        case 3: {
            [matteButtonStyleLabel setText:@"Cancel"];
            break;
        }
        case 4: {
            [matteButtonStyleLabel setText:@"White"];
            break;
        }
        case 5: {
            [matteButtonStyleLabel setText:@"Red"];
            break;
        }
    }
    [self updateButton];
}

// http://stackoverflow.com/questions/1126726/how-to-make-a-uitextfield-move-up-when-keyboard-is-present
-(void)textFieldDidBeginEditing:(id)sender
{
    if ([sender isEqual:nameField] || [sender isEqual:textLabelField])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)keyboardWillShow:(NSNotification *)notif
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
    
    if (([nameField isFirstResponder] || [textLabelField isFirstResponder]) && self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)notif
{
    if (([nameField isFirstResponder] || [textLabelField isFirstResponder]) && self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }    
}

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification object:self.view.window]; 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) 
                                                 name:UIKeyboardWillHideNotification object:self.view.window]; 
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil]; 
}

@end
