import 'package:flutter/material.dart';
import 'size_config.dart';

// clolors that we use in our app
const kMainColor = Colors.white;
const kActiveColor = Color.fromRGBO(247,108,42, 1);
const kAccentColor = Color(0xFFEF9920);
// const kBodyTextColor = Color(0xFF868686);
const kBodyTextColor = Colors.black;
const kInputColor = Color(0xFFFBFBFB);
const kBgColor = Colors.white;

// Text Styles
final TextStyle kH1TextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(34),
  fontWeight: FontWeight.w500,
  letterSpacing: 0.22,
);

final TextStyle kH2TextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.w600,
  letterSpacing: 0.18,
);

final TextStyle kH3TextStyle = kH2TextStyle.copyWith(
  fontSize: getProportionateScreenWidth(20),
  letterSpacing: 0.14,
);

final TextStyle kHeadlineTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(30),
  fontWeight: FontWeight.bold,
);

final TextStyle kSubHeadTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.w500,
  color: kMainColor,
  letterSpacing: 0.44,
);

final TextStyle kBodyTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(16),
  color: kBodyTextColor,
  height: 1.5,
);

final TextStyle kSecondaryBodyTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(14),
  fontWeight: FontWeight.w500,
  color: kMainColor,
  // height: 1.5,
);

final TextStyle kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: getProportionateScreenWidth(14),
  fontWeight: FontWeight.bold,
);

final TextStyle kCaptionTextStyle = TextStyle(
  color: kMainColor.withOpacity(0.64),
  fontSize: getProportionateScreenWidth(12),
  fontWeight: FontWeight.w600,
);

// padding
const double kDefaultPadding = 20.0;
final EdgeInsets kTextFieldPadding = EdgeInsets.symmetric(
  horizontal: kDefaultPadding,
  vertical: getProportionateScreenHeight(kDefaultPadding),
);

// Default Animation Duration
const Duration kDefaultDuration = Duration(milliseconds: 250);

// Text Field Decoration
const OutlineInputBorder kDefaultOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(6)),
  borderSide: BorderSide(
    color: Color(0xFFF3F2F2),
  ),
);

const InputDecoration otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.zero,
  counterText: "",
  errorStyle: TextStyle(height: 0),
);

const kErrorBorderSide = BorderSide(color: Colors.red, width: 1);

// Validator
// final passwordValidator = MultiValidator([
//   RequiredValidator(errorText: 'Password is required'),
//   MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
//   PatternValidator(r'(?=.*?[#?!@$%^&*-/])',
//       errorText: 'Passwords must have at least one special character')
// ]);

// final emailValidator = MultiValidator([
//   RequiredValidator(errorText: 'Email is required'),
//   EmailValidator(errorText: 'Enter a valid email address')
// ]);

// final requiredValidator =
//     RequiredValidator(errorText: 'This field is required');
// final matchValidator = MatchValidator(errorText: 'passwords do not match');

// final phoneNumberValidator = MinLengthValidator(10,
//     errorText: 'Phone Number must be at least 10 digits long');

// Common Text
final Center kOrText = Center(
    child: Text("Or", style: TextStyle(color: kMainColor.withOpacity(0.7))));

class Dropdown {
   static List<dynamic> chargeList = [
    {"id": "ไม่สวมหมวกนิรภัย", "name": "ไม่สวมหมวกนิรภัย"},
    {"id": "ซ้อน 3", "name": "ซ้อน 3"},
    {"id": "ย้อนศร", "name": "ย้อนศร"},
    {"id": "จอดในที่ห้ามจอด", "name": "จอดในที่ห้ามจอด"},
  ];
  static List<dynamic> facultyList = [
    {"id": "เกษตรศาสตร์", "name": "เกษตรศาสตร์"},
    {"id": "วิทยาศาสตร์", "name": "วิทยาศาสตร์"},
    {"id": "วิศวกรรมศาสตร์", "name": "วิศวกรรมศาสตร์"},
    {"id": "สถาปัตยกรรมศาสตร์", "name": "สถาปัตยกรรมศาสตร์"},
    {"id": "ทันตแพทยศาสตร์", "name": "ทันตแพทยศาสตร์"},
    {"id": "แพทยศาสตร์", "name": "แพทยศาสตร์"},
    {"id": "พยาบาลศาสตร์", "name": "พยาบาลศาสตร์"},
    {"id": "วิทยาศาสตร์การแพทย์", "name": "วิทยาศาสตร์การแพทย์"},
    {"id": "สหเวชศาสตร์", "name": "สหเวชศาสตร์"},
    {"id": "สาธารณสุขศาสตร์", "name": "สาธารณสุขศาสตร์"},
    {"id": "มนุษยศาสตร์", "name": "มนุษยศาสตร์"},
    {"id": "นิติศาสตร์", "name": "นิติศาสตร์"},
    {"id": "บริหารธุรกิจ เศรษฐศาสตร์และการสื่อสาร", "name": "บริหารธุรกิจ"},
    {"id": "ศึกษาศาสตร์", "name": "ศึกษาศาสตร์"},
    {"id": "สังคมศาสตร์", "name": "สังคมศาสตร์"},
    {"id": "วิทยาลัยนานาชาติ", "name": "วิทยาลัยนานาชาติ"},
  ];
  static List<dynamic> provinceList = [
    {"id": "กรุงเทพมหานคร", "name": "กรุงเทพมหานคร"},
    {"id": "กระบี่", "name": "กระบี่"},
    {"id": "กาญจนบุรี", "name": "กาญจนบุรี"},
    {"id": "กาฬสินธุ์", "name": "กาฬสินธุ์"},
    {"id": "กำแพงเพชร", "name": "กำแพงเพชร"},
    {"id": "ขอนแก่น", "name": "ขอนแก่น"},
    {"id": "จันทบุรี", "name": "จันทบุรี"},
    {"id": "ฉะเชิงเทรา", "name": "ฉะเชิงเทรา"},
    {"id": "ชลบุรี", "name": "ชลบุรี"},
    {"id": "ชัยนาท", "name": "ชัยนาท"},
    {"id": "ชัยภูมิ", "name": "ชัยภูมิ"},
    {"id": "ชุมพร", "name": "ชุมพร"},
    {"id": "เชียงราย", "name": "เชียงราย"},
    {"id": "เชียงใหม่", "name": "เชียงใหม่"},
    {"id": "ตรัง", "name": "ตรัง"},
    {"id": "ตราด", "name": "ตราด"},
    {"id": "ตาก", "name": "ตาก"},
    {"id": "นครนายก", "name": "นครนายก"},
    {"id": "นครปฐม", "name": "นครปฐม"},
    {"id": "นครพนม", "name": "นครพนม"},
    {"id": "นครราชสีมา", "name": "นครราชสีมา"},
    {"id": "นครศรีธรรมราช", "name": "นครศรีธรรมราช"},
    {"id": " นครสวรรค์", "name": "นครสวรรค์"},
    {"id": "นนทบุรี", "name": "นนทบุรี"},
    {"id": "นราธิวาส", "name": "นราธิวาส"},
    {"id": "น่าน", "name": "น่าน"},
    {"id": "บึงกาฬ", "name": "บึงกาฬ"},
    {"id": "บุรีรัมย์", "name": "บุรีรัมย์"},
    {"id": "ปทุมธานี", "name": "ปทุมธานี"},
    {"id": "ประจวบคีรีขันธ์", "name": "ประจวบคีรีขันธ์"},
    {"id": "ปราจีนบุรี", "name": "ปราจีนบุรี"},
    {"id": "ปัตตานี", "name": "ปัตตานี"},
    {"id": "พระนครศรีอยุธยา", "name": "พระนครศรีอยุธยา"},
    {"id": "พังงา", "name": "พังงา"},
    {"id": "พัทลุง", "name": "พัทลุง"},
    {"id": "พิจิตร", "name": "พิจิตร"},
    {"id": "พิษณุโลก", "name": "พิษณุโลก"},
    {"id": "เพชรบุรี", "name": "เพชรบุรี"},
    {"id": "เพชรบูรณ์", "name": "เพชรบูรณ์"},
    {"id": "แพร่", "name": "แพร่"},
    {"id": "พะเยา", "name": "พะเยา"},
    {"id": "ภูเก็ต", "name": "ภูเก็ต"},
    {"id": "มหาสารคาม", "name": "มหาสารคาม"},
    {"id": "มุกดาหาร", "name": "มุกดาหาร"},
    {"id": "แม่ฮ่องสอน", "name": "แม่ฮ่องสอน"},
    {"id": "ยะลา", "name": "ยะลา"},
    {"id": "ยโสธร", "name": "ยโสธร"},
    {"id": "ร้อยเอ็ด", "name": "ร้อยเอ็ด"},
    {"id": "ระนอง", "name": "ระนอง"},
    {"id": "ระยอง", "name": "ระยอง"},
    {"id": "ราชบุรี", "name": "ราชบุรี"},
    {"id": "ลพบุรี", "name": "ลพบุรี"},
    {"id": "ลำปาง", "name": "ลำปาง"},
    {"id": "ลำพูน", "name": "ลำพูน"},
    {"id": "เลย", "name": "เลย"},
    {"id": "ศรีสะเกษ", "name": "ศรีสะเกษ"},
    {"id": "สกลนคร", "name": "สกลนคร"},
    {"id": "สงขลา", "name": "สงขลา"},
    {"id": "สตูล", "name": "สตูล"},
    {"id": "สมุทรปราการ", "name": "สมุทรปราการ"},
    {"id": "สมุทรสงคราม", "name": "สมุทรสงคราม"},
    {"id": "สมุทรสาคร", "name": "สมุทรสาคร"},
    {"id": "สระแก้ว", "name": "สระแก้ว"},
    {"id": "สระบุรี", "name": "สระบุรี"},
    {"id": "สิงห์บุรี", "name": "สิงห์บุรี"},
    {"id": "สุโขทัย", "name": "สุโขทัย"},
    {"id": "สุพรรณบุรี", "name": "สุพรรณบุรี"},
    {"id": "สุราษฎร์ธานี", "name": "สุราษฎร์ธานี"},
    {"id": "สุรินทร์", "name": "สุรินทร์"},
    {"id": "หนองคาย", "name": "หนองคาย"},
    {"id": "หนองบัวลำภู", "name": "หนองบัวลำภู"},
    {"id": "อ่างทอง", "name": " อ่างทอง"},
    {"id": "อุดรธานี", "name": "อุดรธานี"},
    {"id": "อุทัยธานี", "name": "อุทัยธานี"},
    {"id": "อุตรดิตถ์", "name": "อุตรดิตถ์"},
    {"id": "อุบลราชธานี", "name": "อุบลราชธานี"},
    {"id": "อำนาจเจริญ", "name": "อำนาจเจริญ"},
  ];
}