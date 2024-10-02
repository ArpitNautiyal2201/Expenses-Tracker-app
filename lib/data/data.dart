import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionsData = [
  {
    'Icon': const FaIcon(FontAwesomeIcons.pizzaSlice),
    'Color': Colors.yellow,
    'Name': 'Food',
    'Total Amount': '- ₹400',
    'Date': 'Today',
  },
  {
    'Icon': const FaIcon(FontAwesomeIcons.basketShopping),
    'Color': Colors.pink,
    'Name': 'Shopping',
    'Total Amount': '- ₹250',
    'Date': 'Today',
  },
  {
    'Icon': const FaIcon(FontAwesomeIcons.heartCircleCheck),
    'Color': Colors.green,
    'Name': 'Health',
    'Total Amount': '- ₹100',
    'Date': 'Yesterday',
  },
  {
    'Icon': const FaIcon(FontAwesomeIcons.plane),
    'Color': Colors.blue,
    'Name': 'Travel',
    'Total Amount': '- ₹500',
    'Date': 'Yesterday',
  }
];
