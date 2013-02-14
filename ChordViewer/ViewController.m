//
//  ViewController.m
//  ChordViewer
//
//  Created by Oliver Rickard on 10/16/12.
//  Copyright (c) 2012 Runway 20. All rights reserved.
//

#import "ViewController.h"
#import "OCChordView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    OCChordView *cv = [[OCChordView alloc] initWithFrame:CGRectMake(floorf(self.view.bounds.size.width*0.5f - 200.f*0.5f), floorf(self.view.bounds.size.height*0.5f - 200.f*0.5f), 200.f, 200.f)];
    cv.chordArray = @[@3,@2,@0,@0,@3,@3];
    cv.fingerArray = @[@2,@1,@0,@0,@3,@4];
    cv.tuningArray = @[@"E",@"A",@"D",@"G",@"B",@"E"];
    [self.view addSubview:cv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
