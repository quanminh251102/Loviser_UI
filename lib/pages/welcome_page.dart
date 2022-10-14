import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Size padding = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Padding(
                          padding:  EdgeInsets.only(top: padding.height * 0.3),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: const Image(
                              image: AssetImage('assets/images/loviser.png'),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: const Image(
                            image: AssetImage('assets/images/heart.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.13,),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          'from',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Image(
                            image: AssetImage('assets/images/logo.png'),
                          ),
                          Text(
                            'NOVA',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'roboto',
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          )
                        ]),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
