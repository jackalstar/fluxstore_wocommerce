import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/constants.dart';
import 'frameworks/vendor/route.dart';
import 'models/entities/blog.dart';
import 'models/index.dart' show Order, Product, SearchModel, User;
import 'screens/blog/models/list_blog_model.dart';
import 'screens/blog/views/blog_detail_screen.dart';
import 'screens/blog/views/list_blog_screen.dart';
import 'screens/index.dart'
    show
        CartScreen,
        CategoriesScreen,
        CategorySearch,
        Checkout,
        HomeScreen,
        LoginScreen,
        NotificationScreen,
        ProductDetailScreen,
        RegistrationScreen,
        SearchScreen,
        UserScreen,
        WishListScreen,
        ProductsScreen;
import 'screens/order_history/models/list_order_history_model.dart';
import 'screens/order_history/views/list_order_history_screen.dart';
import 'screens/order_history/views/order_history_detail_screen.dart';
import 'screens/users/user_update.dart';
import 'tabbar.dart';
import 'widgets/home/search/home_search_page.dart';

class Routes {
  static Map<String, WidgetBuilder> getAll() => _routes;

  static Route getRouteGenerate(RouteSettings settings) =>
      _routeGenerate(settings);

  static final Map<String, WidgetBuilder> _routes = {
    RouteList.home: (context) => const HomeScreen(),
    RouteList.dashboard: (context) => MainTabs(),
    RouteList.login: (context) => LoginScreen(),
    RouteList.register: (context) => RegistrationScreen(),
    RouteList.products: (context) => ProductsScreen(),
    RouteList.wishlist: (context) => WishListScreen(),
    RouteList.checkout: (context) => Checkout(),
    RouteList.notify: (context) => NotificationScreen(),
    RouteList.category: (context) => CategoriesScreen(),
    RouteList.cart: (context) => CartScreen(),
    RouteList.search: (context) => ChangeNotifierProvider(
          create: (_) => SearchModel(),
          child: SearchScreen(),
        ),
    RouteList.profile: (context) => UserScreen(),
    RouteList.updateUser: (context) => UserUpdate(),
    ...VendorRoute.getAll(),
  };

  static Route _routeGenerate(RouteSettings settings) {
    switch (settings.name) {
      case RouteList.homeSearch:
        return _buildRouteFade(
          settings,
          ChangeNotifierProvider(
            create: (context) => SearchModel(),
            child: HomeSearchPage(),
          ),
        );
      case RouteList.productDetail:
        Product product;
        if (settings.arguments is Product) {
          product = settings.arguments;
          return _buildRoute(
            settings,
            ProductDetailScreen(
              product: product,
            ),
          );
        }
        return _errorRoute();
      case RouteList.storeDetail:
        return MaterialPageRoute(
          builder: VendorRoute.getRoutesWithSettings(settings)[settings.name],
        );
      case RouteList.categorySearch:
        return _buildRouteFade(
          settings,
          CategorySearch(),
        );
      case RouteList.detailBlog:
        final blog = settings.arguments;
        if (blog is Blog) {
          return _buildRoute(settings, BlogDetailScreen(blog: blog));
        }
        return _errorRoute();
      case RouteList.orderDetail:
        final order = settings.arguments;
        if (order is Order) {
          return _buildRoute(settings, OrderHistoryDetailScreen(order: order));
        }
        return _errorRoute();
      case RouteList.orders:
        final user = settings.arguments;
        if (user is User) {
          return _buildRoute(
            settings,
            ChangeNotifierProvider<ListOrderHistoryModel>(
              create: (context) => ListOrderHistoryModel(user: user),
              child: ListOrderHistoryScreen(),
            ),
          );
        }
        return _errorRoute();
      case RouteList.blogs:
        return _buildRoute(
          settings,
          ListBlogScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: getRouteByName(settings.name),
          // maintainState: false,
          // fullscreenDialog: true,
        );
    }
  }

  static WidgetBuilder getRouteByName(String name) {
    if (_routes.containsKey(name) == false) {
      return _routes[RouteList.home];
    }
    return _routes[name];
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }

  static PageRouteBuilder _buildRouteFade(
    RouteSettings settings,
    Widget builder,
  ) {
    return _FadedTransitionRoute(
      settings: settings,
      widget: builder,
    );
  }

  static MaterialPageRoute _buildRoute(
    RouteSettings settings,
    Widget builder,
  ) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({this.widget, this.settings})
      : super(
            settings: settings,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: const Duration(milliseconds: 100),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
                child: child,
              );
            });
}
