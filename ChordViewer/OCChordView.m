//
//  ChordView.m
//  ChordViewer
//
//  Created by Oliver Rickard on 10/16/12.
//  Copyright (c) 2012 Runway 20. All rights reserved.
//

#import "OCChordView.h"

@implementation OCChordView
@synthesize chordArray;
@synthesize tuningArray;
@synthesize fingerArray;

@synthesize fillColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        self.fillColor = [UIColor blackColor];
        
        self.chordArray = nil;
        self.tuningArray = nil;
        self.fingerArray = nil;
    }
    return self;
}

- (void)dealloc {
    self.fillColor = nil;
    self.chordArray = nil;
    self.tuningArray = nil;
    self.fingerArray = nil;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
#if DEBUG
    //Assertions for the drawing
    if(tuningArray) {
        NSAssert(tuningArray.count == 6, @"tuningArray.count should be 6");
    }
    
    if(chordArray) {
        NSAssert(chordArray.count == 6, @"chordArray.count should be 6");
    }
#endif
    
    // Drawing code
    
    if(self.chordArray) {
        int maxFret = 0;
        int minFret = 15;
        
        UIColor *highlightColor = self.backgroundColor;
        
        for(NSNumber *fretNumber in chordArray) {
            int fret = fretNumber.intValue;
            
            if(fret > 0) {
                if(fret > maxFret) {
                    maxFret = fret;
                }
                if(fret < minFret) {
                    minFret = fret;
                }
            }
        }
        
        int minDisplayFret = minFret;
        int maxDisplayFret = maxFret + 1;
        
        if(minFret > 1) {
            minDisplayFret--;
        }
        
        int fretDisplayDifference = maxDisplayFret - minDisplayFret + 1;
        
        float stringLabelYOrigin = 5.f;
        
        float fretLineHeight = 1.f;
        
        
        //Nut
        float nutPositionYOrigin = floorf(self.frame.size.height*0.2f);
        
        float nutSize = (minDisplayFret == 1) ? floorf(self.frame.size.height*0.05f) : fretLineHeight;
        
        //Frets
        float fretBoardYOrigin = nutPositionYOrigin + nutSize;
        
        float stringHeight = floorf(self.bounds.size.height - fretBoardYOrigin*1.3f);
        
        float fretScreenYSpacing = floorf((stringHeight)/((float)fretDisplayDifference));
        
        float fretBoardXOrigin = self.bounds.size.height*0.2f;
        
        float fretLabelXOrigin = 5.f;
        
        float fretXWidth = floorf(self.bounds.size.width - fretBoardXOrigin*1.5f);
        
        
        //Strings
        float stringSpacing = floorf(fretXWidth / 5.f);
        
        
        
        float stringWidth = 1.f;
        
        float circleRadius = floorf(MIN(stringSpacing, fretScreenYSpacing)*0.4f);
        
        //Draw Nut
        CGRect nutRect = CGRectMake(fretBoardXOrigin, nutPositionYOrigin, fretXWidth + stringWidth, nutSize);
        [self.fillColor setFill];
        UIRectFill(nutRect);
        
        
        //Prepare the label font
        UIFont *chordLabelFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:floorf(self.frame.size.height*0.08f)];
        
        
        
        for(int i = 0; i < fretDisplayDifference; i++) {
            float fretYOrigin = fretBoardYOrigin + (i+1) * fretScreenYSpacing;
            CGRect fretRect = CGRectMake(fretBoardXOrigin, fretYOrigin, fretXWidth, fretLineHeight);
            [self.fillColor setFill];
            UIRectFill(fretRect);
            
            int thisFret = minDisplayFret + i;
            
            NSString *thisFretTitle = [NSString stringWithFormat:@"%d", thisFret];
            
            CGSize fretTitleSize = [thisFretTitle sizeWithFont:chordLabelFont];
            
            float fretLabelYOrigin = fretBoardYOrigin + (i)*fretScreenYSpacing + floorf(fretScreenYSpacing*0.5f - fretTitleSize.height*0.5f);
            
            CGRect fretLabelRect = CGRectMake(fretLabelXOrigin, fretLabelYOrigin, fretTitleSize.width, fretTitleSize.height);
            
            [self.fillColor setFill];
            [thisFretTitle drawInRect:fretLabelRect withFont:chordLabelFont];
            
            
        }
        
        for(int i = 0; i < 6; i++) {
            
            float stringXOrigin = i*stringSpacing + fretBoardXOrigin;
            
            if(tuningArray) {
                
                NSString *stringLabel = [tuningArray objectAtIndex:i];
                
                CGSize stringSize = [stringLabel sizeWithFont:chordLabelFont];
                
                CGRect stringLabelRect = CGRectMake(stringXOrigin - floorf(stringSize.width*0.5f), stringLabelYOrigin, stringSize.width, stringSize.height);
                
                [self.fillColor setFill];
                [stringLabel drawInRect:stringLabelRect withFont:chordLabelFont];
            }
            
            CGRect stringRect = CGRectMake(stringXOrigin, fretBoardYOrigin, stringWidth, stringHeight);
            [self.fillColor setFill];
            UIRectFill(stringRect);
            
            NSNumber *activeFretNumber = [self.chordArray objectAtIndex:i];
            int activeFret = activeFretNumber.intValue;
            
            if(activeFret > 0) {
                //Draw the circle where the 
                int displayFret = activeFret - minDisplayFret;
                
                float activeFretYOrigin = fretBoardYOrigin + displayFret * fretScreenYSpacing;
                
                float circleYOrigin = activeFretYOrigin + floorf(fretScreenYSpacing*0.5f) - circleRadius;
                
                float circleXOrigin = stringXOrigin - circleRadius;
                
                UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(circleXOrigin, circleYOrigin, circleRadius*2, circleRadius*2)];
                [self.fillColor setFill];
                [circlePath fill];
                
                
                if(self.fingerArray) {
                    //Draw the label for which finger should be used
                    NSNumber *activeFingerNumber = [self.fingerArray objectAtIndex:i];
                    int activeFinger = activeFingerNumber.intValue;
                    
                    NSString *activeFingerString = [NSString stringWithFormat:@"%d", activeFinger];
                    
                    CGSize activeFingerSize = [activeFingerString sizeWithFont:chordLabelFont];
                    
                    CGRect activeFingerRect = CGRectMake(circleXOrigin + circleRadius - floorf(activeFingerSize.width*0.5f), circleYOrigin + circleRadius - floorf(activeFingerSize.height*0.5f), activeFingerSize.width, activeFingerSize.height);
                    
                    [highlightColor setFill];
                    [activeFingerString drawInRect:activeFingerRect withFont:chordLabelFont];
                }
            }
            
        }
        
        
    }
    
}


@end
