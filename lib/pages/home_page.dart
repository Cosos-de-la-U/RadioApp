import 'package:ai_radio/model/radio.dart';
import 'package:ai_radio/utils/ai_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MyRadio> radios;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    fetchRadios();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    //print(radios);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      drawer: Drawer(),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(LinearGradient(colors: [
                AIUtils.primaryColor1,
                AIUtils.primaryColor2,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight))
              .make(),
          AppBar(
            title: "AI Radio".text.xl4.bold.white.make().shimmer(
                  duration: const Duration(seconds: 3),
                  primaryColor: Vx.pink500,
                  secondaryColor: Vx.pink300,
                ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ).h(100.0).p16(),
          VxSwiper.builder(
            itemCount: radios.length,
            aspectRatio: 1.0,
            itemBuilder: (context, index) {
              final rad = radios[index];

              return VxBox(
                      child: ZStack(
                [
                  Positioned(
                      top: 0.0,
                      left: 0.0,
                      child: VxBox(
                              child: rad.category.text.uppercase.teal100
                                  .make()
                                  .px16())
                          .height(40)
                          .pink700
                          .alignBottomCenter
                          .withRounded(value: 5.0)
                          .make()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VStack(
                      [
                        rad.name.text.xl3.pink200.bold.make(),
                        5.heightBox,
                        rad.tagline.text.sm.pink100.semiBold.make(),
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      // ignore: prefer_const_constructors
                      child: [
                        const Icon(
                          CupertinoIcons.play_circle,
                          color: Vx.teal100,
                        ),
                        10.heightBox,
                        "Doble tap para reproducir".text.teal100.make()
                      ].vStack())
                ],
                clip: Clip.antiAlias,
              ))
                  .clip(Clip.antiAlias)
                  .bgImage(
                    DecorationImage(
                        image: NetworkImage(rad.image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken)),
                  )
                  .border(color: Vx.pink700, width: 1.0)
                  .withRounded(value: 60.0)
                  .make()
                  .onDoubleTap(() {})
                  .p16();
            },
          ).centered(),
          // ignore: prefer_const_constructors
          Align(
            alignment:Alignment.bottomCenter,
            // ignore: prefer_const_constructors
            child: Icon(
              CupertinoIcons.stop_circle, color: Colors.white, size: 50.0
              ),
          ).pOnly(bottom: context.percentHeight * 12)
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
