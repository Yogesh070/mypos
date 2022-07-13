import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mypos/controllers/category_controller.dart';
import 'package:mypos/controllers/customer_controller.dart';
import 'package:mypos/controllers/product_controller.dart';
import 'package:mypos/controllers/ticket_controller.dart';
import 'package:mypos/screens/addon/addon_screen.dart';
import 'package:mypos/screens/auth/bussiness_registration.dart';
import 'package:mypos/screens/auth/entercode_screen.dart';
import 'package:mypos/screens/auth/sign_in.dart';
import 'package:mypos/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:mypos/screens/category/add_category.dart';
import 'package:mypos/screens/category/category_screen.dart';
import 'package:mypos/screens/customer/create_customer.dart';
import 'package:mypos/screens/customer/customer_screen.dart';
import 'package:mypos/screens/home/home.dart';
import 'package:mypos/screens/item/add_item.dart';
import 'package:mypos/screens/item/itemlist_screen.dart';
import 'package:mypos/screens/open%20ticket/ticketedit_screen.dart';
import 'package:mypos/screens/open%20ticket/tickets_screen.dart';
import 'package:mypos/screens/others/splash_screen.dart';
import 'package:mypos/screens/payment/cash_payment.dart';
import 'package:mypos/screens/payment/payment_method.dart';
import 'package:mypos/screens/profile/profile.dart';
import 'package:mypos/screens/reciept/reciept_screen.dart';
import 'package:provider/provider.dart';

class DefaultRouter {
  static final GoRouter route = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/addon',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const AddonListScreen(),
      ),
      GoRoute(
        path: '/category',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const CategoryScreen(),
        routes: [
          GoRoute(
            name: 'add-category',
            path: 'add-category',
            builder: (BuildContext context, GoRouterState _goRouterState) =>
                const AddCategory(),
          ),
          GoRoute(
            name: 'edit-category',
            path: 'edit/:iid',
            builder: (BuildContext context, GoRouterState _goRouterState) {
              final toEditCategory = Provider.of<CategoryController>(context)
                  .allCategory
                  .where(
                      (element) => element.id == _goRouterState.params['iid']!)
                  .first;
              return AddCategory(forEdit: true, category: toEditCategory);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/bill',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const RecieptScreen(),
      ),
      GoRoute(
        path: '/item',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const ItemScreen(),
        routes: [
          GoRoute(
            name: 'add-item',
            path: 'add-item',
            builder: (BuildContext context, GoRouterState _goRouterState) =>
                const AddItem(),
          ),
          GoRoute(
            name: 'edit-item',
            path: 'edit/:iid',
            builder: (BuildContext context, GoRouterState _goRouterState) {
              final toEditItem = Provider.of<ProductController>(context)
                  .allItem
                  .where(
                      (element) => element.id == _goRouterState.params['iid']!)
                  .first;
              return AddItem(forEdit: true, toEditItem: toEditItem);
            },
          ),
        ],
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const Homepage(),
        routes: [
          GoRoute(
            name: 'profile',
            path: 'profile/:uid',
            builder: (BuildContext context, GoRouterState _goRouterState) {
              final customer = Provider.of<CustomerController>(context,
                      listen: false)
                  .allCustomers
                  .firstWhere(
                      (element) => element.id == _goRouterState.params['uid']!);
              return Profile(
                customer: customer,
              );
            },
            routes: [
              GoRoute(
                name: 'edit-profile',
                path: 'edit',
                builder: (BuildContext context, GoRouterState _goRouterState) {
                  final customer =
                      Provider.of<CustomerController>(context, listen: false)
                          .allCustomers
                          .firstWhere((element) =>
                              element.id == _goRouterState.params['uid']!);
                  return CreateCustomer(
                    forEdit: true,
                    toEditCustomer: customer,
                  );
                },
              ),
            ],
          ),
          GoRoute(
              name: 'customers',
              path: 'customers',
              builder: (BuildContext context, GoRouterState _goRouterState) =>
                  const CustomerScreen(),
              routes: [
                GoRoute(
                  name: 'add-customer',
                  path: 'add-customer',
                  builder:
                      (BuildContext context, GoRouterState _goRouterState) =>
                          const CreateCustomer(),
                ),
              ]),
          GoRoute(
            name: 'open-ticket',
            path: 'open-ticket',
            builder: (BuildContext context, GoRouterState _goRouterState) =>
                const TicketsScreen(),
          ),
          GoRoute(
            name: 'ticket',
            path: 'ticket',
            builder: (BuildContext context, GoRouterState _goRouterState) =>
                const TicketEditScreen(),
            routes: [
              GoRoute(
                name: 'payment-method',
                path: 'pay',
                builder: (BuildContext context, GoRouterState _goRouterState) =>
                    PaymentMethod(
                  totalAmount: Provider.of<TicketController>(context,
                          listen: false)
                      .calculateTotal(
                          Provider.of<TicketController>(context, listen: false)
                              .ticketList),
                ),
                routes: [
                  GoRoute(
                      name: 'cash',
                      path: 'cash',
                      builder: (BuildContext context,
                              GoRouterState _goRouterState) =>
                          CashPayment(
                            totalAmount: Provider.of<TicketController>(context,
                                    listen: false)
                                .calculateTotal(Provider.of<TicketController>(
                                        context,
                                        listen: false)
                                    .ticketList),
                          ),
                      routes: [
                        //             GoRoute(
                        //   name: 'complete',
                        //   path: 'complete',
                        //   builder: (BuildContext context, GoRouterState _goRouterState) =>
                        //       CompleteActionPayment(
                        //                   totalAmount: totalAmount!,
                        //                   paidAmount: _amountController.text,
                        //                 ),
                        // ),
                      ]),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: 'signin',
        path: '/signin',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const LoginScreen(),
      ),
      GoRoute(
        name: 'signup',
        path: '/register',
        builder: (BuildContext context, GoRouterState state) => const SignUp(),
        routes: [
          GoRoute(
            name: 'business-reg',
            path: 'business-registration',
            builder: (BuildContext context, GoRouterState state) =>
                BussinessRegistationScreen(token: state.extra as String),
          ),
        ],
      ),
      GoRoute(
        name: 'business',
        path: '/business-registration',
        builder: (BuildContext context, GoRouterState state) =>
            BussinessRegistationScreen(token: state.extra as String),
      ),
      GoRoute(
        name: 'code',
        path: '/code',
        builder: (BuildContext context, GoRouterState state) => EnterCodeScreen(
          verifyCode: state.extra as VerifyCode,
        ),
      ),
    ],
  );
}
