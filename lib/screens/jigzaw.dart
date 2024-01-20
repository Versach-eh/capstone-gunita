// Need to fix crop image error
// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_conditional_assignment




import 'dart:io';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as ui;
import 'dart:math' as math;
import 'package:audioplayers/audioplayers.dart';
import 'package:image_picker/image_picker.dart';




class PuzzleWidget extends StatefulWidget {
  PuzzleWidget({Key? key}) : super(key: key);




  @override
  _PuzzleWidgetState createState() => _PuzzleWidgetState();
}




class _PuzzleWidgetState extends State<PuzzleWidget> {


  File? _selectedImage; // Declare _selectedImage here


  bool _isPuzzleComplete = false;


  // lets setup our puzzle 1st


  // add test button to check crop work
  // well done.. let put callback for success put piece & complete all




  GlobalKey<_JigsawWidgetState> jigKey = new GlobalKey<_JigsawWidgetState>();




  // maybe intialize here
   AudioCache audioCache = AudioCache();


   // pick image
  //  File? _selectedImage;


  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        jigKey.currentState?.setNewImage(_selectedImage);

      });
    }
    // if (pickedFile != null) {
    //   setState(() {
    //     _selectedImage = File(pickedFile.path);
    //     jigKey.currentState?.setNewImage(_selectedImage);
    //   });
    // }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 59, 58, 61),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10,),
                // Allow user to pick an image
                // // Display the selected image or a default image
                // _selectedImage != null
                //     ? Image.file(
                //         _selectedImage!,
                //         width: 200,
                //         height: 200,
                //         fit: BoxFit.cover,
                //       )
                //     : Placeholder(
                //         fallbackHeight: 200,
                //         fallbackWidth: 200,
                //       ),


                // let make base for our puzzle widget
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: JigsawWidget(
                    callbackFinish: () {
                      // check function
                      print("callbackFinish");
                      setState(() {
              _isPuzzleComplete = true;
            });
            // Reset _isPuzzleComplete after 1 second
            Future.delayed(Duration(seconds: 1), () {
              setState(() {
                _isPuzzleComplete = false;
              });
            });
         
                    },
                    callbackSuccess: () {
                      print("callbackSuccess");
                      // lets fix error size
                    },
                    key: jigKey,
                    // set container for our jigsaw image
                    child: _selectedImage != null ?
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.file(
                        _selectedImage!,
                            fit: BoxFit.contain,
                      ),
                    )
                    : Container(
        // Center the text vertically and horizontally
        // put placeholder or default image here
        child: Center(
          child: Text(
            "Welcome to Mindful Merge!\nPick an image to get started!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24, // Adjust font size as needed
            ),
          ),
        ),
      ),

                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text("Pick Image",
          style: TextStyle(fontSize: 18),),
                      ),SizedBox(width: 10),
                      ElevatedButton(
                        child: Text("Reset",
          style: TextStyle(fontSize: 18),),
                        onPressed: () {
                          jigKey.currentState?.resetJigsaw();
                        },
                      ),SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          await jigKey.currentState?.generaJigsawCropImage();
                        },
                        child: Text("Start",
          style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
                          AnimatedOpacity(
          opacity: _isPuzzleComplete ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Text(
            "Congratulations, Puzzle Done!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        
              ], // try
             
            ),
           
          ),
         
        ),
       
      ),
     
    );
  }
}




// make new widget name JigsawWidget
// let move jigsaw blok
class JigsawWidget extends StatefulWidget {
 
  // maybe intialize here instead?




  Widget child;
  Function() callbackSuccess;
  Function() callbackFinish;
  JigsawWidget({required Key key, required this.child, required this.callbackFinish, required this.callbackSuccess})
      : super(key: key);




  @override
  _JigsawWidgetState createState() => _JigsawWidgetState();
}




class _JigsawWidgetState extends State<JigsawWidget> {
  File? _selectedImage; // Declare _selectedImage here


  GlobalKey _globalKey = GlobalKey();
   ui.Image? fullImage;
   Size? size;




  List<List<BlockClass>> images = <List<BlockClass>>[];
  ValueNotifier<List<BlockClass>> blocksNotifier =
      new ValueNotifier<List<BlockClass>>(<BlockClass>[]);
  late CarouselController _carouselController;




  // to save current touch down offset & current index puzzle
  Offset _pos = Offset.zero;
  late int? _index;

  AudioCache audioCache = AudioCache();


  // Add this method to update the image
  Future<void> setNewImage(File? newImage) async {
    await _getImageFromWidget();
  }

// pasted from NO SOUND JIGSAW
  _getImageFromWidget() async {
final RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;




    size = boundary.size;
    var img = await boundary.toImage();
    var byteData = await img?.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData?.buffer.asUint8List();




    return ui.decodeImage(pngBytes!);
  }






// FROM CHAT GPT
  // Future<ui.Image?> _getImageFromWidget() async {
  //   if (_selectedImage == null) {
  //   return null;
  // }
  // final RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;




  // fullImage = _selectedImage != null ? await ui.decodeImage(_selectedImage!.readAsBytesSync()) : null;
   


  //   size = boundary.size;
  //   var img = await boundary?.toImage();
  //   var byteData = await img?.toByteData(format: ImageByteFormat.png);
  //   var pngBytes = byteData?.buffer.asUint8List();


  //   // Update the fullImage with the new image


   




  //   return ui.decodeImage(pngBytes!);
  // }






  resetJigsaw() {
    images.clear();
    blocksNotifier =
        new ValueNotifier<List<BlockClass>>(<BlockClass>[]);
    // _carouselController = new CarouselController();
    blocksNotifier.notifyListeners();
    setState(() {});


    // Check if puzzle is complete and call callbackFinish
    // if (isPuzzleComplete) {
    //   widget.callbackFinish.call();
    // }
  }


 




  Future<void> generaJigsawCropImage() async {
  // 1st we need to create a class for block image
  images = <List<BlockClass>>[];


  // get image from our boundary
  if (fullImage == null) {
    fullImage = await _getImageFromWidget();
  }


  // // Check if fullImage is still null
  // if (fullImage == null) {
  //   // Handle the case where fullImage is null
  //   print("Error: Full image is null.");
  //   return;
  // }


  // split image using crop
  int xSplitCount = 3;
  int ySplitCount = 3;


    // i think i know what the problom width & height not correct!
    double widthPerBlock =
        fullImage!.width / xSplitCount; // change back to width
    double heightPerBlock = fullImage!.height / ySplitCount;




    for (var y = 0; y < ySplitCount; y++) {
      // temporary images
      List<BlockClass> tempImages = <BlockClass>[];




      images.add(tempImages);
      for (var x = 0; x < xSplitCount; x++) {
        int randomPosRow = math.Random().nextInt(2) % 2 == 0 ? 1 : -1;
        int randomPosCol = math.Random().nextInt(2) % 2 == 0 ? 1 : -1;




        Offset offsetCenter = Offset(widthPerBlock / 2, heightPerBlock / 2);




        // make random jigsaw pointer in or out




        ClassJigsawPos jigsawPosSide = new ClassJigsawPos(
          bottom: y == ySplitCount - 1 ? 0 : randomPosCol,
          left: x == 0
              ? 0
              : -images[y][x - 1]
                  .jigsawBlockWidget
                  .imageBox
                  .posSide
                  .right, // ops.. forgot to dclare
          right: x == xSplitCount - 1 ? 0 : randomPosRow,
          top: y == 0
              ? 0
              : -images[y - 1][x].jigsawBlockWidget.imageBox.posSide.bottom,
        );




        double xAxis = widthPerBlock * x;
        double yAxis = heightPerBlock * y; // this is culprit.. haha




        // size for pointing
        double minSize = math.min(widthPerBlock, heightPerBlock) / 15 * 4;




        offsetCenter = Offset(
          (widthPerBlock / 2) + (jigsawPosSide.left == 1 ? minSize : 0),
          (heightPerBlock / 2) + (jigsawPosSide.top == 1 ? minSize : 0),
        );




        // change axis for posSideEffect
        xAxis -= jigsawPosSide.left == 1 ? minSize : 0;
        yAxis -= jigsawPosSide.top == 1 ? minSize : 0;




        // get width & height after change Axis Side Effect
        double widthPerBlockTemp = widthPerBlock +
            (jigsawPosSide.left == 1 ? minSize : 0) +
            (jigsawPosSide.right == 1 ? minSize : 0);
        double heightPerBlockTemp = heightPerBlock +
            (jigsawPosSide.top == 1 ? minSize : 0) +
            (jigsawPosSide.bottom == 1 ? minSize : 0);




        // create crop image for each block
        ui.Image temp = ui.copyCrop(
          fullImage!,
          x: xAxis.round(),
          y: yAxis.round(),
          width: widthPerBlockTemp.round(),
          height: heightPerBlockTemp.round(),
        );




        // get offset for each block show on center base later
        Offset offset = Offset(size!.width / 2 - widthPerBlockTemp / 2,
            size!.height / 2 - heightPerBlockTemp / 2);




        ImageBox imageBox = new ImageBox(
          image: Image.memory(
            ui.encodePng(temp),
            fit: BoxFit.contain,
          ),
          isDone: false,
          offsetCenter: offsetCenter,
          posSide: jigsawPosSide,
          radiusPoint: minSize,
          size: Size(widthPerBlockTemp, heightPerBlockTemp),
        );




        images[y].add(
          new BlockClass(
              jigsawBlockWidget: JigsawBlockWidget(
                imageBox: imageBox,
              ),
              offset: offset,
              offsetDefault: Offset(xAxis, yAxis)),
        );
      }
    }




    blocksNotifier.value = images.expand((image) => image).toList();
    // let random a bit so blok puzzle not in incremet order
    // ops..bug .. i found culprit.. seem RepaintBoundary return wrong width on render..fix 1st using height
    // as well
    blocksNotifier.value.shuffle();
    blocksNotifier.notifyListeners();
    //  _index = 0;
    setState(() {});
   


   


   
  }




  @override
  void initState() {
    // let generate split image
    // forgot to initiate.. haha
    _index = 0;
    _carouselController = new CarouselController();
    super.initState();




    AudioCache audioCache = AudioCache();
    audioCache.load('images/sound.mp3'); // Replace 'snap_sound.mp3' with your sound file

  }




  void playSnapSound() async {
  AudioPlayer result = await audioCache.play('images/sound.mp3'); // Replace 'snap_sound.mp3' with your sound file
  if (result == 1) {
    // success
    print("Sound played successfully");
  } else {
    print("Error playing sound");
  }


 
}




  @override
  Widget build(BuildContext context) {
    Size sizeBox = MediaQuery.of(context).size;




    return ValueListenableBuilder(
        valueListenable: blocksNotifier,
        builder: (context, List<BlockClass> blocks, child) {
          List<BlockClass> blockNotDone = blocks
              .where((block) => !block.jigsawBlockWidget.imageBox.isDone)
              .toList();
          List<BlockClass> blockDone = blocks
              .where((block) => block.jigsawBlockWidget.imageBox.isDone)
              .toList();




          return Container(
            // set height for jigsaw base
            child: Container(
              // color: Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: sizeBox.width,
                    child: Listener(
                      // listener for move event & up
                      // lets proceed 1st
                      onPointerUp: (event) {
                       
                        if (blockNotDone.length == 0) {
                          resetJigsaw();
                          // can set callback for complete all piece
                          widget.callbackFinish.call();
                        }




                        if (_index == null) {
                          // set carousel for change _index
                          _carouselController.nextPage(
                              duration: Duration(
                                  microseconds:
                                      600)); // lower to make fast move
                          setState(() {
                            // _index = 0;
                          });
                        }
                      },
                      onPointerMove: (event) {
                        if (_index == null || _index! >= blockNotDone.length) return;




                        Offset offset = event.localPosition - _pos;




                        blockNotDone[_index!].offset = offset;




                        if ((blockNotDone[_index!].offset - blockNotDone[_index!].offsetDefault).distance < 5)
                        {
                          // drag block close to default position will trigger this cond


                          blockNotDone[_index!]
                              .jigsawBlockWidget
                              .imageBox
                              .isDone = true;
                          blockNotDone[_index!].offset =
                              blockNotDone[_index!].offsetDefault;




                          // _index = (_index! + 1) % blockNotDone.length; // Move to the next index //causes the 8th piece to glith
                          _index = 0;
                          // not allow index change after success put piece




                          blocksNotifier.notifyListeners();




                          // can set callback success put piece
                          widget.callbackSuccess.call();
                          playSnapSound();




                        }




                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          if (blocks.length == 0) ...[
                            RepaintBoundary(
                              key: _globalKey,
                              child: Container(
                                color: Color.fromARGB(255, 125, 60, 179),
                                height: double.maxFinite,
                                width: double.maxFinite,
                                child: widget.child,
                              ),
                            )
                          ],




                          // no errors...let show.. let use ValueNotifier for easy use
                          //  hye .. :) lets proceed
                          Offstage(
                            offstage: !(blocks.length >
                                0), // sorry.. forgot about this
                            child: Container(
                              color: Colors.white,
                              width: size?.width,
                              height: size?.height,
                              child: CustomPaint(
                                // lets draw line base for jigsaw so player can know what shape they want match
                                painter: JigsawPainterBackground(blocks),
                                child: Stack(
                                  children: [
                                    // we need split up block which done and not done
                                    if (blockDone.length > 0)
                                      ...blockDone.map(
                                        (map) {
                                          return Positioned(
                                            left: map
                                                .offset.dx, // let turn off this
                                            top: map.offset.dy,
                                            child: Container(
                                              child: map.jigsawBlockWidget,
                                            ),
                                          );
                                        },
                                      ),
                                    if (blockNotDone.length > 0)
                                      ...blockNotDone.asMap().entries.map(
                                        (map) {
                                          return Positioned(
                                            left: map.value.offset
                                                .dx, // let set default so we can see progress 1st .. yeayyy
                                            top: map.value.offset.dy,
                                            child: Offstage(
                                              offstage: !(_index ==
                                                  map.key), // will hide blok which not same index
                                              child: GestureDetector(
                                                // for event touch down to capture current offset on blok
                                                onTapDown: (details) {
                                                  if (map
                                                      .value
                                                      .jigsawBlockWidget
                                                      .imageBox
                                                      .isDone) return;




                                                  setState(() {
                                                    _pos =
                                                        details.localPosition;
                                                    _index = map.key;
                                                    // maybe put sound player code here / audio
                                                  });
                                                },
                                                child: Container(
                                                  child: map
                                                      .value.jigsawBlockWidget,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      color: Colors.grey[850],
                      height: 100,
                      child: CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          initialPage: _index!,
                          height: 80,
                          aspectRatio: 1,
                          viewportFraction: 0.15,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          disableCenter: false,
                          onPageChanged: (index, reason) {
                            _index = index;
                            setState(() {});
                          },
                        ),
                        items: blockNotDone.map((block) {
                          Size sizeBlock =
                              block.jigsawBlockWidget.imageBox.size;
                          return FittedBox(
                            child: Container(
                              width: sizeBlock.width,
                              height: sizeBlock.height,
                              child: block.jigsawBlockWidget,
                            ),
                          );
                        }).toList(),
                      ))
                ],
              ),
            ),
          );
        });
  }


  // bool get isPuzzleComplete {
  //   // Check if all blocks are done
  //   return images.every((row) => row.every((block) => block.jigsawBlockWidget.imageBox.isDone));
  // }


}








class JigsawPainterBackground extends CustomPainter {
  List<BlockClass> blocks;




  JigsawPainterBackground(this.blocks);




  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = new Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black12
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    Path path = new Path();




    // loop blocks so we can draw line at base
    this.blocks.forEach((element) {
      Path pathTemp = getPiecePath(
        element.jigsawBlockWidget.imageBox.size,
        element.jigsawBlockWidget.imageBox.radiusPoint,
        element.jigsawBlockWidget.imageBox.offsetCenter,
        element.jigsawBlockWidget.imageBox.posSide,
      );




      path.addPath(pathTemp, element.offsetDefault);
    });




    canvas.drawPath(path, paint);
  }




  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




class BlockClass {
  Offset offset;
  Offset offsetDefault;
  JigsawBlockWidget jigsawBlockWidget;




  BlockClass({
    required this.offset,
    required this.jigsawBlockWidget,
    required this.offsetDefault,
  });
}




class ImageBox {
  Widget image;
  ClassJigsawPos posSide;
  Offset offsetCenter;
  Size size;
  double radiusPoint;
  bool isDone;




  ImageBox({
    required this.image,
    required this.posSide,
    required this.isDone,
    required this.offsetCenter,
    required this.radiusPoint,
    required this.size,
  });
}




class ClassJigsawPos {
  int top, bottom, left, right;




  ClassJigsawPos({required this.top, required this.bottom, required this.left, required this.right});
}




class JigsawBlockWidget extends StatefulWidget {
  ImageBox imageBox;
  JigsawBlockWidget({ Key? key, required this.imageBox}) : super(key: key);




  @override
  _JigsawBlockWidgetState createState() => _JigsawBlockWidgetState();
}




class _JigsawBlockWidgetState extends State<JigsawBlockWidget> {
  // lets start clip crop image so show like jigsaw puzzle




  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PuzzlePieceClipper(imageBox: widget.imageBox),
      child: CustomPaint(
        foregroundPainter: JigsawBlokPainter(imageBox: widget.imageBox),
        child: widget.imageBox.image,
      ),
    );
  }
}




class JigsawBlokPainter extends CustomPainter {




 
 
  ImageBox imageBox;




  JigsawBlokPainter({
    required this.imageBox,
  });
  @override
  void paint(Canvas canvas, Size size) {




   
    // we make function so later custom painter can use same path
    // yeayyyy
    Paint paint = new Paint()
      ..color = this.imageBox.isDone
          ? Colors.white.withOpacity(0.2)
          : Colors.white //will use later
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;




    canvas.drawPath(
        getPiecePath(size, this.imageBox.radiusPoint,
            this.imageBox.offsetCenter, this.imageBox.posSide),
        paint);




    if (this.imageBox.isDone) {
      Paint paintDone = new Paint()
        ..color = Colors.white.withOpacity(0.2)
        ..style = PaintingStyle.fill
        ..strokeWidth = 2;
      canvas.drawPath(
          getPiecePath(size, this.imageBox.radiusPoint,
              this.imageBox.offsetCenter, this.imageBox.posSide),
          paintDone);
     
    }
  }




  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}




class PuzzlePieceClipper extends CustomClipper<Path> {
  ImageBox imageBox;
  PuzzlePieceClipper({
    required this.imageBox,
  });
  @override
  Path getClip(Size size) {
    // we make function so later custom painter can use same path  
    return getPiecePath(size, this.imageBox.radiusPoint,
        this.imageBox.offsetCenter, this.imageBox.posSide);
  }




  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}




getPiecePath(
  Size size,
  double radiusPoint,
  Offset offsetCenter,
  ClassJigsawPos posSide,
) {
  Path path = new Path();




  Offset topLeft = Offset(0, 0);
  Offset topRight = Offset(size.width, 0);
  Offset bottomLeft = Offset(0, size.height);
  Offset bottomRight = Offset(size.width, size.height);




  // calculate top point on 4 point
  topLeft = Offset(posSide.left > 0 ? radiusPoint : 0,
          (posSide.top > 0) ? radiusPoint : 0) +
      topLeft;
  topRight = Offset(posSide.right > 0 ? -radiusPoint : 0,
          (posSide.top > 0) ? radiusPoint : 0) +
      topRight;
  bottomRight = Offset(posSide.right > 0 ? -radiusPoint : 0,
          (posSide.bottom > 0) ? -radiusPoint : 0) +
      bottomRight;
  bottomLeft = Offset(posSide.left > 0 ? radiusPoint : 0,
          (posSide.bottom > 0) ? -radiusPoint : 0) +
      bottomLeft;




  // calculate mid point for min & max
  double topMiddle = posSide.top == 0
      ? topRight.dy
      : (posSide.top > 0
          ? topRight.dy - radiusPoint
          : topRight.dy + radiusPoint);
  double bottomMiddle = posSide.bottom == 0
      ? bottomRight.dy
      : (posSide.bottom > 0
          ? bottomRight.dy + radiusPoint
          : bottomRight.dy - radiusPoint);
  double leftMiddle = posSide.left == 0
      ? topLeft.dx
      : (posSide.left > 0
          ? topLeft.dx - radiusPoint
          : topLeft.dx + radiusPoint);
  double rightMiddle = posSide.right == 0
      ? topRight.dx
      : (posSide.right > 0
          ? topRight.dx + radiusPoint
          : topRight.dx - radiusPoint);




  // solve.. wew




  path.moveTo(topLeft.dx, topLeft.dy);
  // top draw
  if (posSide.top != 0)
    path.extendWithPath(
        calculatePoint(Axis.horizontal, topLeft.dy,
            Offset(offsetCenter.dx, topMiddle), radiusPoint),
        Offset.zero);
  path.lineTo(topRight.dx, topRight.dy);
  // right draw
  if (posSide.right != 0)
    path.extendWithPath(
        calculatePoint(Axis.vertical, topRight.dx,
            Offset(rightMiddle, offsetCenter.dy), radiusPoint),
        Offset.zero);
  path.lineTo(bottomRight.dx, bottomRight.dy);
  if (posSide.bottom != 0)
    path.extendWithPath(
        calculatePoint(Axis.horizontal, bottomRight.dy,
            Offset(offsetCenter.dx, bottomMiddle), -radiusPoint),
        Offset.zero);
  path.lineTo(bottomLeft.dx, bottomLeft.dy);
  if (posSide.left != 0)
    path.extendWithPath(
        calculatePoint(Axis.vertical, bottomLeft.dx,
            Offset(leftMiddle, offsetCenter.dy), -radiusPoint),
        Offset.zero);
  path.lineTo(topLeft.dx, topLeft.dy);




  path.close();




  return path;
}




// design each point shape
calculatePoint(Axis axis, double fromPoint, Offset point, double radiusPoint) {
  Path path = new Path();




  if (axis == Axis.horizontal) {
    path.moveTo(point.dx - radiusPoint / 2, fromPoint);
    path.lineTo(point.dx - radiusPoint / 2, point.dy);
    path.lineTo(point.dx + radiusPoint / 2, point.dy);
    path.lineTo(point.dx + radiusPoint / 2, fromPoint);
  } else if (axis == Axis.vertical) {
    path.moveTo(fromPoint, point.dy - radiusPoint / 2);
    path.lineTo(point.dx, point.dy - radiusPoint / 2);
    path.lineTo(point.dx, point.dy + radiusPoint / 2);
    path.lineTo(fromPoint, point.dy + radiusPoint / 2);
  }




  return path;
}









