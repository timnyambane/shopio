import 'package:flutter/material.dart';

import '../views/Parties/parties_list.dart';
import '../views/Sell/sell.dart';
import '../views/Purchase/purchase.dart';
import '../views/Products/products_list.dart';
import '../views/Due List/duelist.dart';
import '../views/Stock/stock.dart';
import '../views/Reports/reports.dart';
import '../views/Sales List/saleslist.dart';
import '../views/Loss & Profit/lossprofit.dart';
import '../views/Purchase List/purchaselist.dart';
import '../views/Expenses/expenses.dart';
import '../views/Net Overall/netoverall.dart';

class GridItems {
  final String title, icon;
  final Widget screen;

  GridItems({required this.screen, required this.title, required this.icon});
}

List<GridItems> gridIcons = [
  GridItems(title: 'Sell', icon: 'assets/sell.png', screen: SellScreen()),
  GridItems(
      title: 'Parties', icon: 'assets/parties.png', screen: PartiesScreen()),
  GridItems(
      title: 'Purchase',
      icon: 'assets/purchase.png',
      screen: const PurchaseScreen()),
  GridItems(
      title: 'Products',
      icon: 'assets/products.png',
      screen: const ProductsScreen()),
  GridItems(
      title: 'Due List',
      icon: 'assets/due_list.png',
      screen: const DueListScreen()),
  GridItems(
      title: 'Stock', icon: 'assets/stock.png', screen: const StockScreen()),
  GridItems(
      title: 'Reports',
      icon: 'assets/reports.png',
      screen: const ReportsScreen()),
  GridItems(
      title: 'Sales list',
      icon: 'assets/sales_list.png',
      screen: const SalesListScreen()),
  GridItems(
      title: 'Purchase List',
      icon: 'assets/purchase_list.png',
      screen: const PurchaseListScreen()),
  GridItems(
      title: 'Loss/Profit',
      icon: 'assets/profit.png',
      screen: const LossProfitScreen()),
  GridItems(
      title: 'Expense',
      icon: 'assets/expenses.png',
      screen: const ExpensesScreen()),
  GridItems(
      title: 'Net Overall',
      icon: 'assets/net_overall.png',
      screen: const NetOverallScreen()),
];
