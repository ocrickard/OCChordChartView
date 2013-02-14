//
//  ChordView.h
//  ChordViewer
//
//  Created by Oliver Rickard on 10/16/12.
//  Copyright (c) 2012 Runway 20. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCChordView : UIView {
    NSArray *chordArray;
    NSArray *tuningArray;
    NSArray *fingerArray;
    
    UIColor *fillColor;
}

@property (nonatomic, strong) NSArray *chordArray;
@property (nonatomic, strong) NSArray *tuningArray;
@property (nonatomic, strong) NSArray *fingerArray;

@property (nonatomic, strong) UIColor *fillColor;

@end
