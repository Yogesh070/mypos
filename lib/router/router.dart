import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mypos/screens/addon/addon_screen.dart';
import 'package:mypos/screens/auth/bussiness_registration.dart';
import 'package:mypos/screens/auth/entercode_screen.dart';
import 'package:mypos/screens/auth/sign_in.dart';
import 'package:mypos/screens/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:mypos/screens/category/category_screen.dart';
import 'package:mypos/screens/home/home.dart';
import 'package:mypos/screens/open%20ticket/ticketedit_screen.dart';
import 'package:mypos/screens/others/splash_screen.dart';
import 'package:mypos/screens/payment/cash_payment.dart';

class DefaultRouter {
  static final GoRouter route = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      // GoRoute(
      //   path: '/',
      //   builder: (BuildContext context, GoRouterState _goRouterState) =>
      //       const AddonListScreen(),
      // ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/addon',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const AddonListScreen(),
        // const CategoryScreen(),
      ),
      GoRoute(
        path: '/category',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const CategoryScreen(),
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const Homepage(),
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
      GoRoute(
        path: '/ticket',
        builder: (BuildContext context, GoRouterState _goRouterState) =>
            const TicketEditScreen(),
        routes: [
          GoRoute(
              path: 'pay',
              builder: (BuildContext context, GoRouterState _goRouterState) =>
                  const CategoryScreen(),
              routes: [
                //           GoRoute(
                //   path: 'cash',
                //   builder: (BuildContext context, GoRouterState _goRouterState) =>
                //        CashPayment(),
                // ),
              ]),
        ],
      ),
    ],
  );
}
