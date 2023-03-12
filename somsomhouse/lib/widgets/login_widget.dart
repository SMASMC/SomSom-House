import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:somsomhouse/views/map/comment.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _authentication =
      FirebaseAuth.instance; //firebaseauth로 firebase에 값을 저장하는 역할을 함.
  bool isLoginScreen = true;
  final _formKey = GlobalKey<FormState>();
  static String passwordcheck = '';
  FocusNode rentalFocusNode = FocusNode();
  FocusNode floorFocusNode = FocusNode();
//전체적으로 form안에 있는 값을 넘겨주는 역할을 함.
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  String userPasswordCheck = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); //화면을 눌렀을 경우에 키보드릴 내리게 하는 역할을 함
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '솜솜 하우스',
            style: TextStyle(
                fontSize: 65,
                color: Color.fromARGB(232, 105, 183, 255),
                fontFamily: 'Jua'),
          ),
          //메인 텍스트 명
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width -
                    50, //화면이 돌아가도 자동으로 양옆의 길이를 조절해주는 역할
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0), //둥글기 조절
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15, //그림자
                      // spreadRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      //동작을 인식하는 역할을 함.
                      onTap: () {
                        setState(() {
                          isLoginScreen = true;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '로그인',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isLoginScreen
                                  ? Colors.black
                                  : const Color.fromARGB(255, 129, 129, 129),
                            ),
                          ),
                          if (isLoginScreen)
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              height: 2,
                              width: 55,
                              color: Colors.black,
                            ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoginScreen = false;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '회원가입',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: !isLoginScreen
                                      ? Colors.black
                                      : const Color.fromARGB(
                                          255, 129, 129, 129),
                                ),
                              ),
                            ],
                          ),
                          if (!isLoginScreen)
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              height: 2,
                              width: 65,
                              color: Colors.black,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //text 폼 필드
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            height: isLoginScreen ? 210 : 350,
            width: MediaQuery.of(context).size.width -
                50, //화면이 돌아가도 자동으로 양옆의 길이를 조절해주는 역할
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0), //둥글기 조절
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15, //그림자
                  // spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                if (!isLoginScreen) //로그인 버튼이 아닐경우
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              key: ValueKey(1), //Status가 뒤엉키지 않게 key값을 가져옴.
                              validator: (value) {
                                //사용자가 입력한 유효성 검사를 하는 validation 기능을 구현
                                if (value!.isEmpty || value.length > 4) {
                                  return '이름 입력은 5글자 이내로 해주세요!';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                userName = newValue!;
                              },
                              onChanged: (value) {
                                //value 값을 가져오는 역할을 함.
                                userName = value;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 129, 129, 129),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                hintText: '사용자 명을 입력하세요',
                                hintStyle: TextStyle(fontSize: 14),
                                contentPadding: EdgeInsets.all(
                                    10), //텍스트 박스 전체 사이즈르 padding으로 맞춤
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType
                                  .emailAddress, //email을 입력할 수 있도록 키보드에서 @버튼을 추가해줌
                              key: ValueKey(2), //key값을 가져옴.
                              onSaved: (newValue) {
                                userEmail = newValue!;
                              },
                              onChanged: (value) {
                                userEmail = value; //값을 전달할 수 있는 역할을 해줌.
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 129, 129, 129),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                hintText: 'ID를 입력하세요',
                                hintStyle: TextStyle(fontSize: 14),
                                contentPadding: EdgeInsets.all(
                                    10), //텍스트 박스 전체 사이즈르 padding으로 맞춤
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              key: ValueKey(3), //key값을 가져옴.
                              obscureText: true, //비밀번호 표시를 위한 선언
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return '비밀번호는 6글자 이상으로 해주세요!';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                userPassword = newValue!;
                              },
                              onChanged: (value) {
                                userPassword = value; //값을 전달할 수 있는 역할을 해줌.
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 129, 129, 129),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                hintText: '비밀번호를 입력하세요',
                                hintStyle: TextStyle(fontSize: 14),
                                contentPadding: EdgeInsets.all(
                                    10), //텍스트 박스 전체 사이즈르 padding으로 맞춤
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              key: ValueKey(4), //key값을 가져옴.
                              obscureText: true, //비밀번호 표시를 위한 선언
                              onSaved: (newValue) {
                                userPasswordCheck = newValue!;
                              },
                              onChanged: (value) {
                                userPasswordCheck = value;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 129, 129, 129),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                hintText: '비밀번호를 다시 입력하세요',
                                hintStyle: TextStyle(fontSize: 14),
                                contentPadding: EdgeInsets.all(
                                    10), //텍스트 박스 전체 사이즈르 padding으로 맞춤
                              ),
                            ),
                          ],
                        )),
                  ),
                if (isLoginScreen) //로그인 버튼일 경우
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            key: const ValueKey(5), //key값을 가져옴.
                            onSaved: (newValue) {
                              userEmail = newValue!;
                            },
                            onChanged: (value) {
                              userEmail = value;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35),
                                ),
                              ),
                              hintText: 'ID를 입력하세요',
                              hintStyle: TextStyle(fontSize: 14),
                              contentPadding: EdgeInsets.all(
                                  10), //텍스트 박스 전체 사이즈르 padding으로 맞춤
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            key: ValueKey(6), //key값을 가져옴.
                            obscureText: true, //비밀번호 표시를 위한 선언
                            onSaved: (newValue) {
                              userPassword = newValue!;
                            },
                            onChanged: (value) {
                              userPassword = value;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.key,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(35),
                                ),
                              ),

                              hintText: '비밀번호를 입력하세요',

                              hintStyle: TextStyle(fontSize: 14),
                              contentPadding: EdgeInsets.all(
                                  10), //텍스트 박스 전체 사이즈르 padding으로 맞춤
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          //텍스트 폼 필드
          SizedBox(
            height: isLoginScreen ? 100 : 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (!isLoginScreen) {
                        _tryValidation(); //값을 넘겨주는 함수
                        try {
                          final addUser = await _authentication
                              .createUserWithEmailAndPassword(
                            email: userEmail.trim(), //email형식에 공백이 들어가면 안됨
                            password: userPassword,
                          );

                          await FirebaseFirestore.instance
                              .collection('user')
                              .doc(addUser.user!.uid)
                              .set({
                            'userName': userName,
                            'email': userEmail,
                            'password': userPassword,
                          });
                          //collection의 역할은 바로 firebase에 컬렉션을 생성해준다.
                          //doc은 데이터를 전달하는 역할을 한다.
                          //set은 엑스트라 데이터를 생성해주는 역할을 한다.
                          if (addUser.user != null) {
                            // firebase에 user가 있다면 다음페이지로 이동
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Comment();
                              },
                            ));
                          }
                        } catch (e) {
                          print(e);
                        }
                      } //isLoginScreen이 false일경우 이메일과 비밀번호를 firebase에 넣어준다.
                      if (isLoginScreen) {
                        _tryValidation();
                        try {
                          final addUser =
                              await _authentication.signInWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword,
                          );
                        } catch (e) {
                          print(e);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('정보 입력을 확인해 주세요!'),
                              backgroundColor: Colors.grey,
                            ));
                          }
                        }
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 214, 163, 255),
                            Color.fromARGB(232, 105, 183, 255),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight, //그라데이션의 위치 같은거
                        ),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //값을 넘겨주는 버튼
        ],
      ),
    );
  }

  // ----------------------------------------------------------------
  /// form 키의 value값을 가져온 뒤에 save해주는 함수
  /// 만든 날짜 : 2023.1.11
  /// 만든이 : 송명철
  void _tryValidation() {
    final isValid = _formKey.currentState!
        .validate(); //이 method로 인해 폼필드 validator를 작동시킬 수 있다.
    //! null check
    if (isValid) {
      _formKey.currentState!.save(); // form키의 value값을 가져온 뒤에 save를 해주는 역할을 한다.
      //모든 onSaved 메소드를 불러옴
    }
  }

  //회원가입 완료시 로그인 창으로 이동하도록 생성한 Dialog 2023.01.13
  _showDialoglogin(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, //user must tap the button!
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('로그인 실패!'),
          content: const Text('아이디 혹은 비밀번호를 확인해 주세요'),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Text('이전'))
          ],
        );
      },
    );
  }

  //회원가입이 완료되지 않았을 경우 팝업창
  _showDialogsignup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, //user must tap the button!
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('회원가입 불가!'),
          content: const Text('입력사항을 다시 한번 확인해 주세요!'),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Text('이전'))
          ],
        );
      },
    );
  }
}//End
