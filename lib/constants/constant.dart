import 'package:AgriNet/models/recommendedModal.dart';
import 'package:AgriNet/models/reviewModal.dart';
import 'package:flutter/material.dart';

const COLOR_BLACK = Color.fromRGBO(48, 47, 48, 1.0);
const COLOR_GREY = Color.fromRGBO(141, 141, 141, 1.0);

const COLOR_WHITE = Colors.white;
const COLOR_DARK_BLUE = Color.fromRGBO(20, 25, 45, 1.0);

const kPrimaryColor = Color(0xFFFF8084);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);
const kTransparent = Colors.transparent;

const kRadius = 0.0;

const kDefaultPadding = 24.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;
const kLess = 4.0;

const kShape = 30.0;

const kSubTextStyle = TextStyle(
    fontSize: 18.0,
    color: kLightColor,
);

const kSmallDivider = Divider(
    color: kAccentColor,
    thickness: 5.0,
);

const TextTheme TEXT_THEME_DEFAULT = TextTheme(
    headline1: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 26),
    headline2: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
    headline3: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 16),
    headline5: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
    headline6: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    bodyText1: TextStyle(
        color: COLOR_BLACK, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    bodyText2: TextStyle(
        color:  COLOR_GREY, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    subtitle1:
    TextStyle(color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w400),
    subtitle2: TextStyle(
        color: COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w400));

const TextTheme TEXT_THEME_SMALL = TextTheme(
    headline1: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
    headline2: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
    headline3: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 18),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
    headline5: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    headline6: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 10),
    bodyText1: TextStyle(
        color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    bodyText2: TextStyle(
        color:  COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    subtitle1:
    TextStyle(color: COLOR_BLACK, fontSize: 10, fontWeight: FontWeight.w400),
    subtitle2: TextStyle(
        color: COLOR_GREY, fontSize: 10, fontWeight: FontWeight.w400));

final reviewList = [
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "John Travolta",
        rating: 3.5,
        date: "01 Jan 2021",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Scarlett Johansson",
        rating: 2.5,
        date: "21 Feb 2021",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Jennifer Lawrence",
        rating: 4.5,
        date: "17 Mar 2021",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Michael Jordan",
        rating: 1.5,
        date: "12 Apr 2021",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Nicole Kidman",
        rating: 2.0,
        date: "28 May 2021",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "James Franco",
        rating: 4.0,
        date: "14 Nov 2020",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Margot Robbie",
        rating: 1.0,
        date: "14 Nov 2020",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Nicolas Cage",
        rating: 3.0,
        date: "14 Nov 2020",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Emma Stone",
        rating: 5.0,
        date: "14 Nov 2020",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Johnny Depp",
        rating: 3.5,
        date: "14 Nov 2020",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Natalie Portman",
        rating: 3.5,
        date: "14 Nov 2020",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Anne Hathaway",
        rating: 3.5,
        date: "14 Nov 2020",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
    ReviewModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        name: "Charlize Theron",
        rating: 3.5,
        date: "14 Nov 2020",
        comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    ),
];
final recommendedList = [
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "Apple iMac All-In-One Desktop",
        price: 1712.34,
        rating: 7.8,
        sale: 449),
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "SEIKO",
        price: 557.84,
        rating: 4.2,
        sale: 249),
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "Carpe Diem",
        price: 24.89,
        rating: 5.6,
        sale: 223),
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "Xbox Wireless Controller",
        price: 76.12,
        rating: 8.9,
        sale: 826),
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "Nike Air Max 270",
        price: 120.00,
        rating: 7.6,
        sale: 924),
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "Cockatoo Dumbbell",
        price: 78.56,
        rating: 6.6,
        sale: 762),
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "Nivia Simbolo Football",
        price: 18.00,
        rating: 5.5,
        sale: 456),
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "Checked Casual Shirt",
        price: 21.45,
        rating: 7.8,
        sale: 685),
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "Wolper Lounge Chair",
        price: 315.00,
        rating: 7.9,
        sale: 528),
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "Sony WH-XB700 Wireless Bluetooth Headphones",
        price: 128.26,
        rating: 8.4,
        sale: 785),
    RecommendedModal(
        image: "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
        title: "Canon EOS M50 Mirrorless Camera",
        price: 756.22,
        rating: 8.8,
        sale: 864),
];