import 'package:mypos/model/addon.dart';
import 'package:mypos/model/bill.dart';
import 'package:mypos/model/category.dart';
import 'package:mypos/model/customer.dart';
import 'package:mypos/model/item.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Category> getCategory() => Hive.box<Category>('category');
  static Box<Addon> getAddon() => Hive.box<Addon>('addon');
  static Box<Item> getItem() => Hive.box<Item>('item');
  static Box<Customer> getCustomer() => Hive.box<Customer>('customer');
  static Box<Bill> getBills() => Hive.box<Bill>('bill');
}
