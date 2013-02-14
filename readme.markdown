#OCChordChartView#

So I got tired of seeing guitar apps come out that would either have really awfully rendered chord charts, or would rip off images they had no rights to.  So I spent a Saturday writing this little view.  It's fast, tiny, and generates beautifully rendered, readable guitar chord charts.

##Installation##

Drag in OCChordView.h and .m into your project.  Make sure your project links against CoreGraphics.

##Usage##

It's super simple, here's an example:

```
OCChordView *cv = [[OCChordView alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 100.f)];
cv.chordArray = @[@3,@2,@0,@0,@3,@3];
cv.fingerArray = @[@2,@1,@0,@0,@3,@4];
cv.tuningArray = @[@"E",@"A",@"D",@"G",@"B",@"E"];
[self.view addSubview:cv];
```

The chord array defines the fretting of the strings, the finger array defines the fingers used to form that chord, and the tuningArray provides the labels for the strings.

##License: MIT##

Copyright (c) 2013 Oliver C. Rickard

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.