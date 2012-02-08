//
//  ButtonMakerViewController.h
//  ButtonMaker
//
//  Created by Dermot Daly on 22/04/2010.
//  Copyright tapadoo 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kOFFSET_FOR_KEYBOARD 60.0

@interface ButtonMakerViewController : UIViewController <UITextFieldDelegate>{
	UISlider *redSlider;
	UISlider *greenSlider;
	UISlider *blueSlider;
	UISlider *widthSlider;
	UISlider *heightSlider;
	
	UILabel *redValueLabel;
	UILabel *greenValueLabel;
	UILabel *blueValueLabel;
	UILabel *heightLabel;
	UILabel *widthLabel;
	
	UIButton *theButton;
    
    UIButton * addR;
    UIButton * subR;
    UIButton * addG;
    UIButton * subG;
    UIButton * addB;
    UIButton * subB;
    UIButton * addW;
    UIButton * subW;
    UIButton * addH;
    UIButton * subH;
    
    UISegmentedControl * matteGlossy;
    BOOL glossy;
    
    UILabel * matteButtonStyleLabel;
    UILabel * matteButtonBarStyleLabel;
    UILabel * matteButtonStyleNameLabel;
    UILabel * matteButtonBarStyleNameLabel;
    UIStepper * matteButtonStyleStepper;
    UIStepper * matteButtonBarStyleStepper;
    
    int matteButtonBarStyle;
    int matteButtonStyle;
    
    UITextField * nameField;
    UITextField * textLabelField;
}

@property(nonatomic, retain) IBOutlet UISlider *redSlider;
@property(nonatomic, retain) IBOutlet UISlider *greenSlider;
@property(nonatomic, retain) IBOutlet UISlider *blueSlider;
@property(nonatomic, retain) IBOutlet UISlider *widthSlider;
@property(nonatomic, retain) IBOutlet UISlider *heightSlider;

@property(nonatomic, retain) IBOutlet UILabel *redValueLabel;
@property(nonatomic, retain) IBOutlet UILabel *greenValueLabel;
@property(nonatomic, retain) IBOutlet UILabel *blueValueLabel;
@property(nonatomic, retain) IBOutlet UILabel *heightLabel;
@property(nonatomic, retain) IBOutlet UILabel *widthLabel;

@property(nonatomic, retain) IBOutlet UIButton * addR;
@property(nonatomic, retain) IBOutlet UIButton * subR;
@property(nonatomic, retain) IBOutlet UIButton * addG;
@property(nonatomic, retain) IBOutlet UIButton * subG;
@property(nonatomic, retain) IBOutlet UIButton * addB;
@property(nonatomic, retain) IBOutlet UIButton * subB;
@property(nonatomic, retain) IBOutlet UIButton * addW;
@property(nonatomic, retain) IBOutlet UIButton * subW;
@property(nonatomic, retain) IBOutlet UIButton * addH;
@property(nonatomic, retain) IBOutlet UIButton * subH;

@property(nonatomic, retain) IBOutlet UITextField * nameField;
@property(nonatomic, retain) IBOutlet UITextField * textLabelField;

@property(nonatomic, retain) IBOutlet UISegmentedControl * matteGlossy;

@property (nonatomic, retain) IBOutlet UILabel * matteButtonStyleLabel;
@property (nonatomic, retain) IBOutlet UILabel * matteButtonBarStyleLabel;
@property (nonatomic, retain) IBOutlet UILabel * matteButtonStyleNameLabel;
@property (nonatomic, retain) IBOutlet UILabel * matteButtonBarStyleNameLabel;
@property (nonatomic, retain) IBOutlet UIStepper * matteButtonStyleStepper;
@property (nonatomic, retain) IBOutlet UIStepper * matteButtonBarStyleStepper;

-(IBAction) colorSliderChanged:(id)sender;
-(IBAction) sizeSlideChanged:(id)sender;
-(IBAction) saveTapped:(id)sender;

-(IBAction) addButtonPressed:(id)sender;
-(IBAction) subtractButtonPressed:(id)sender;

-(IBAction) matteGlossyChanged:(id)sender;

-(IBAction)barStyleStepped:(id)sender;
-(IBAction)styleStepped:(id)sender;

-(IBAction) textLabelChanged:(id)sender;

@end

