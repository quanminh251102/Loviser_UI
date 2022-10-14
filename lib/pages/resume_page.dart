import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ResumePage extends StatefulWidget {
  ResumePage({Key? key}) : super(key: key);

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.02),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    'SƠ YẾU LÍ LỊCH',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Bỏ qua',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.009,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sơ yếu lí lịch hoặc CV',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    DottedBorder(
                      color: const Color(0xFF356899),
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(24),
                      dashPattern: const [10, 5],
                      child: Container(
                        height: width * 0.7,
                        width: width * 0.85,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(24.0),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.6,
                          child: const Text(
                            'Tải lên sơ yếu lí lịch hoặc CV của bạn và sử dụng nó khi bạn nộp đơn xin việc',
                            style: TextStyle(
                              color: Color(0xFF95969D),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Container(
                          width: width * 0.7,
                          height: height * 0.1,
                          decoration: BoxDecoration(
                            // ignore: use_full_hex_values_for_flutter_colors
                            color: const Color(0xff3f2f2f3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: TextButton(
                              child: const Text('Tải lên Doc/Docx/PDF',
                                  style: TextStyle(
                                    color: Color(0xFF356899),
                                  )),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        InkWell(
                          hoverColor: Colors.transparent,
                          onTap: () {},
                          child: Container(
                            width: width * 0.5,
                            height: height * 0.1,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEC1C24),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: Text(
                                'Tải lên',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.05),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tiêu đề CV',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width * 0.9,
                height: height * 0.1,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: const Center(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ghi ngắn gọn tiêu đề cho CV của bạn',
                      hintStyle: TextStyle(
                        color: Color(0xFF616161),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: width * 0.85,
                  height: height * 0.08,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCACBCE),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      'Lưu',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
