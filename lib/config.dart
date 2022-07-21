class Config {
  static const String appName = "Helmet.sys";
  static const String apiURL = "10.0.2.2:5000";
  static const String studentAPI = "api/getdatastudent";
  static const String addDataAPI = "api/insertdatabyapp";
  static const String addPlateImage = "api/upload-file-image";
  static const String addIdCard = "api/upload-file-card-image";
  // static const String checkIdCard = "api/upload-file-check-card";
  static const String checkDataAPI = "api/check-data";
  static const String showDataDetails = "api/show-data";
  static const String startProgramImage = "api/video/startProgramImage";
  static const String startProgramCardImage = "api/video/startProgramCardImage";
  static const String startProgramCheckCard = "api/video/startProgramCheckCard";
  static const String addStudentAPI = "api/insertstudent";
  static const String getImageData = "api/data/image/data-";
  // static const String dataAPI = "api/data/getalldata";
  static const String dataAPI = "api/show-data";
  static const String userAPI = "api/getuser";
  static const String registerAPI = "api/signup";
  static const String loginAPI = "api/signin";
  static const int pageSize = 10;
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
  static List<dynamic> cityList = [
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
