import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:final_pro/pages/Login/Login.dart';

class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  final List<String> policy1 = [
    "Ⅰ.   Нийтлэг үндэслэл",
    "Ⅱ.   Ашиглах журам",
    "Ⅲ.  Компанийн хариуцлагын хязгаарлалт",
    "Ⅳ.  Үйлчилгээний нөхцөлийн хамрах хугацаа",
    "Ⅴ.   Бусад"
  ];

  final List<String> policy2 = [
    '1.1. Рубик Эй Ай ХХК (цаашид "Компани" гэх) нь IOS, Android үйлдлийн системтэй гар утасны Car Care аппликейшн дээр үзүүлэх үйлчилгээний нөхцөлийг нийтэлж байна.',
    '1.2. Энэхүү нөхцөл нь Хэрэглэгч (цаашид "Хэрэглэгч" гэх) сайтаар үйлчилүүлэхээсээ өмнө хүлээн зөвшөөрч баталгаажуулсны үндсэн дээр хэрэгжинэ.',
    '1.3. Энэхүү нөхцөлд өөрөөр заагаагүй бол дараах нэр томьёог дор дурдсан утгаар ойлгоно:'
  ];

  final List<String> policy3 = [
    'Компани – Рубик Эй Ай ХХК'
        'Аппликейшн – iOS, Android үйлдлийн системтэй гар утасны аппликейшн болох Car Care нь хэрэглэгчдэд авто машины үйлчилгээг хялбар хурдан авахад зориулагдсан аппликейшн юм. (цаашид “Аппликейшн” гэх)',
    'Хэрэглэгч – энэхүү нөхцөлийг хүлээн зөвшөөрөн Компанийн үйлчилгээг авч буй хувь хүн болон хуулийн этгээд',
    'Car care үйлчилгээ – аппликейшний туслалцаатай Компанийн үзүүлж буй төлбөргүй болон төлбөртэй үйлчилгээ.',
  ];

  final List<String> policy4 = [
    '1.4.    Car care үйлчилгээг ашиглаж эхлэх, аппликэйшн суулгах эсвэл бүртгүүлснээр Хэрэглэгч нь үйлчилгээний нөхцөлийг бүрэн эхээр нь хүлээн зөвшөөрсөнд тооцно. Хэрэв Хэрэглэгч энэхүү нөхцөлийн аль нэг заалтыг хүлээн зөвшөөрөөгүй тохиолдолд Car care аппликейшний үйлчилгээг авах эрхгүй болно.',
    '1.5.    Хэрэглэгчдийн дунд явагдаж буй бүх хэлэлцээр Компанийн оролцоогүйгээр явагддаг болно. Компани нь хялбар хурдан холбох платформоор л хангадаг болно.',
  ];
  final List<String> policy5 = [
    '2.1.    Хэрэглэгч сайтын гишүүнээр саадгүй бүртгүүлэх бүрэн эрхтэй бөгөөд бүртгэлд өөрт ирсэн нууц кодоороо аппликейшнд нэвтэрч, аппликейшний үйлчилгээг авах эрхтэй.',
    '2.2.    Аппликейшний үйлчилгээг авснаар энэхүү үйлчилгээний нөхцөлд заасан дүрэм журмыг заавал мөрдөх шаардлагыг хүлээн зөвшөөрсөнд тооцно.',
    '2.3.    Хэрэглэгч Аппликейшн-руу ордог өөрийн нууц кодоо нууцалж, нууц кодтой холбоотой бүх асуудлын хариуцлагыг өөрөө үүрнэ. Хэрэглэгч зөвхөн өөрийн утасны дугаар, нууц код ашиглан сайтын үйлчилгээг авах эрхтэй.',
    '2.4.    Хэрэглэгч (Аппликейшн) руу ордог өөрийн нууц кодоо нууцалж, гуравдагч этгээдэд өгөхгүй байх үүрэгтэй.',
    '2.5.    Авто үйлчилгээ эрхлэгч нь борлуулж буй бараа бүтээгдэхүүн, үйлчилгээнийхээ чанар, аюулгүй байдал, хууль дүрэмд харшлахгүй байх тал дээр бүрэн хариуцна.',
    '2.6.   Хэрэглэгч үйлчилгээний хугацаа, чанар аюулгүйн байдлыг, түүнчлэн санал болгосон үйлчилгээнийх нь тусгай зөвшөөрлийг нэхэмжилсэн тохиолдолд авто үйлчилгээ эрхлэгч талаас батлан дааж, тэдний хүсэлтийг биелүүлэх үүрэгтэй.',
    '2.7.    Компани нь нийтлэгдсэн авто үйлчилгээ эрхлэгчийн Аппликейшн дахь байршлыг өөрчлөх эрхтэй.  Хэрэв авто үйлчилгээ эрхлэгч нь Аппликейшний дотоод журам болон хууль дүрмийг зөрчиж, алдаатай мэдээлэл нийтэлсэн тохиолдолд Компани мэдээллийг хориглож, устгах эрхтэй.'
  ];
  final List<String> policy6 = [
    '3.1.    Аппликейшн үйлчилгээг ашигласнаар, Хэрэглэгч нь өөрийн бүх эрсдэлийг үүрнэ. ',
    '3.2.    Компани нь Хэрэглэгч авто үйлчилгээ эрхлэгчдийн хоорондын харилцааг зохицуулах байгууллага биш болно.',
    '3.3.    Компани нь авто үйлчилгээ эрхлэгчдийн мэдээллийн бодит байдлыг хянах боломжгүй юм. Компани нь хэлцэл хийгч талуудын аливаа нэгэн зохисгүй зан, эсвэл гарсан хохиролд хариуцлага хүлээхгүй болно.',
    '3.4.    Компани нь авто үйлчилгээ эрхлэгчийн санал болгож буй бараа/үйлчилгээнд хариуцлага үүрэхгүй. Хэрэглэгчдийн хооронд гарсан маргаан, зөрчил нь Компанийн оролцоогүйгээр Хэрэглэгч, авто үйлчилгээ эрхлэгчийн хооронд шийдвэрлэгдэнэ.',
    '3.5.    Авто үйлчилгээ эрхлэгчдийн мэдээлсэн бараа/үйлчилгээний чанар, аюулгүй байдал, хуулиар зөвшөөрөгдсөн байдал болон тайлбартайгаа нийцэх асуудал Компанийн хяналтаас гадуур байгаа болно.',
    '3.6.    Хэрэглэгч Аппликейшнийг ашиглаж байх үедээ анхаарал болгоомжтой байхыг компани зөвлөж байна. Хэрэглэгч Аппликейшн хэрэглэснээр дээрх эрсдэлийг болон бусад Хэрэглэгчийн үйлдэлд компани хариуцлага үүрэхгүй болохыг хүлээн зөвшөөрсөнд тооцно.',
    '3.7.    Аппликейшний Хэрэглэгч нь өөрийн хийсэн үйлдэлд бүрэн хариуцлага үүрнэ.',
    '3.8.  Аппликейшнийг буруу хэрэглэснээс гарсан хохирлыг компани хариуцахгүй болно.',
  ];

  final List<String> policy7 = [
    '4.1.    Энэхүү нөхцөлийг Хэрэглэгч аппликейшнийг ашиглаж эхэлсэн үеэс мөрдөх бөгөөд энэхүү нөхцөл нь хугацаагүй болно.',
    '4.2.    Хэрэглэгч нь өөрийн бүртгэлийг аппликейшнаас устгахдаа компанид урьдчилан мэдэгдэж, тайлбар өгөлгүй устгуулах эрхтэй.',
    '4.3.    Хэрэв компани 7 дугаар бүлэгт заасанчлан Үйлчилгээний нөхцөлд нэмэлт өөрчлөлтөөр оруулсан аль нэг заалтыг Хэрэглэгч хүлээн зөвшөөрөхгүй байгаа тохиолдолд Хэрэглэгч аппликейшний үйлчилгээг ашиглахаа дуусгавар болгох үүрэгтэй. Хэрэглэгч аппликейшнийг ашигласан хэвээр байгаа тохиолдолд нэмэлт өөрчлөлтийг хүлээн зөвшөөрсөнд тооцно.'
  ];
  final List<String> policy8 = [
    '5.1.    Компани нь хэрэглэгчдэд урьдчилан мэдэгдэлгүйгээр үйлчилгээний нөхцөлд нэмэлт өөрчлөлт оруулах эрхтэй.',
    '5.2. Үйлчилгээтэй холбоотой санал, гомдол, асуудал, маргааныг талууд эв зүйгээр харилцан зөвшилцөх замаар шийдвэрлэнэ. Хэрэв шийдвэрлэх боломжгүй бол Монгол Улсын хууль, тогтоомжид заасны дагуу шийдвэрлүүлнэ.',
    '5.3. Хэрэглэгч нь Платформын талаар санал гомдол, шинэ санал, шүүмж зэргийг Платформын журмын дагуу илэрхийлэх, илгээх эрхтэй.',
    '5.4. “Car Care”-ийн Платформд байгаа бүх тэмдэгтүүд нь “Рубик Эй Ай”ХХК-ийн онцгой өмч бөгөөд барааны тэмдэг, нэр, бүтээгдэхүүн, үйлчилгээнүүдийг хуулах, олшруулах, дуурайх, өөр бусад ямар ч зүйлд ашиглахыг хориглоно.',
  ];

  bool isApproved = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text('Үйлчилгээний нөхцөл',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Үйлчилгээний нөхцөл',
                  style: TextStyle(fontSize: 13, fontFamily: 'Inter'),
                ),
                const SizedBox(height: 13),
                for (String policy in policy1)
                  Text(
                    policy,
                    style: const TextStyle(fontSize: 13, fontFamily: 'Inter'),
                  ),
                const SizedBox(height: 13),
                const Text('Ⅰ. Нийтлэг үндэслэл'),
                for (String policy in policy2)
                  Text(
                    '$policy\n',
                    style: const TextStyle(fontSize: 13, fontFamily: 'Inter'),
                  ),
                const SizedBox(height: 13),
                const Text('Компани - Рубик Эй Ай ХХК;'),
                for (String policy in policy3)
                  Text(
                    policy,
                    style: const TextStyle(fontSize: 13, fontFamily: 'Inter'),
                  ),
                for (String policy in policy4)
                  Text(
                    '\n$policy\n',
                    style: const TextStyle(fontSize: 13, fontFamily: 'Inter'),
                  ),
                const Text('II. Ашиглах журам' '\n'),
                for (String policy in policy5)
                  Text(
                    '$policy\n',
                    style: const TextStyle(fontSize: 13, fontFamily: 'Inter'),
                  ),
                const Text('\nIII. Компанийн хариуцлагын хязгаарлалт\n'),
                for (String policy in policy6)
                  Text(
                    '$policy\n',
                    style: const TextStyle(fontSize: 13, fontFamily: 'Inter'),
                  ),
                const Text('\nIV. Үйлчилгээний нөхцөлийн хамрах хугацаа\n'),
                for (String policy in policy7)
                  Text(
                    '$policy\n',
                    style: const TextStyle(fontSize: 13, fontFamily: 'Inter'),
                  ),
                const Text('\nV. Үйлчилгээний нөхцөлийн нэмэлт өөрчлөлт\n'),
                for (String policy in policy8)
                  Text(
                    '$policy\n',
                    style: const TextStyle(fontSize: 13, fontFamily: 'Inter'),
                  ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: null,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isApproved = !isApproved;
                          });
                        },
                        child: isApproved
                            ? SvgPicture.asset('images/checkbox_on.svg')
                            : SvgPicture.asset('images/checkbox_off.svg'),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Үйлчилгээний нөхцөл',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const Text(' зөвшөөрч байна'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.78,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff404040),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: isApproved
                            ? () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              }
                            : null,
                        child: const Text(
                          'Үргэлжлүүлэх',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
