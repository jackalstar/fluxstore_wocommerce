// ignore_for_file: prefer_single_quotes, lines_longer_than_80_chars final
Map<String, dynamic> environment = {
  "appConfig": "lib/config/config_en.json",

  /// ➡️ lib/common/config.dart
  "serverConfig": {
    'type': 'wcfm',
    'url': 'https://www.yourfootballshirt.com',
    'consumerKey': 'ck_689aceec2f3c6e95d7f56f068a017dc2870fe7ea',
    'consumerSecret': 'cs_2addf18d9ac9d46bd41af50b4358c70629a11d84',
    'blog': 'https://www.yourfootballshirt.com/',


  },

  /// ➡️ lib/common/config/general.dart
  "defaultDarkTheme": false,
  "loginSMSConstants": {
    "countryCodeDefault": "VN",
    "dialCodeDefault": "+84",
    "nameDefault": "Vietnam"
  },
  "storeIdentifier": {
    "disable": true,
    "android": "com.inspireui.fluxstore",
    "ios": "1469772800"
  },
  "advanceConfig": {
    "DefaultLanguage": "en",
    "DetailedBlogLayout": "halfSizeImageType",
    "EnablePointReward": true,
    "hideOutOfStock": false,
    "EnableRating": true,
    "hideEmptyProductListRating": true,
    "EnableShipping": true,

    /// Enable search by SKU in search screen
    "EnableSkuSearch": true,

    /// Show stock Status on product List & Product Detail
    "showStockStatus": true,

    /// Gird count setting on Category screen
    "GridCount": 3,

    /// set isCaching to true if you have upload the config file to mstore-api
    /// set kIsResizeImage to true if you have finished running Re-generate image plugin
    /// ref: https://support.inspireui.com/help-center/articles/3/8/19/app-performance
    "isCaching": false,
    "kIsResizeImage": false,

    /// Stripe payment only: set currencyCode and smallestUnitRate.
    /// All API requests expect amounts to be provided in a currency’s smallest unit.
    /// For example, to charge 10 USD, provide an amount value of 1000 (i.e., 1000 cents).
    /// Reference: https://stripe.com/docs/currencies#zero-decimal
    "DefaultCurrency": {
      "symbol": "€",
      "decimalDigits": 2,
      "symbolBeforeTheNumber": true,
      "currency": "EUR",
      "currencyCode": "EUR",
      "smallestUnitRate": 100, // 100 cents = 1 usd
    },
    "Currencies": [
      {
        "symbol": "€",
        "decimalDigits": 2,
        "symbolBeforeTheNumber": true,
        "currency": "EUR",
        "currencyCode": "EUR",
      },
    ],

    /// Below config is used for Magento store
    "DefaultStoreViewCode": "",
    "EnableAttributesConfigurableProduct": ["color", "size"],
    "EnableAttributesLabelConfigurableProduct": ["color", "size"],

    /// if the woo commerce website supports multi languages
    /// set false if the website only have one language
    "isMultiLanguages": true,

    ///Review gets approved automatically on woocommerce admin without requiring administrator to approve.
    "EnableApprovedReview": true,

    /// Sync Cart from website and mobile
    "EnableSyncCartFromWebsite": false,
    "EnableSyncCartToWebsite": false,

    /// Disable shopping Cart due to Listing Users request
    "EnableShoppingCart": false,

    /// Enable firebase to support FCM, realtime chat for Fluxstore MV
    "EnableFirebase": true,

    /// ratio Product Image, default value is 1.2 = height / width
    "RatioProductImage": 1.2,

    /// Enable Coupon Code When checkout
    "EnableCouponCode": true,

    /// Enable to Show Coupon list.
    "ShowCouponList": true,

    /// Enable this will show all coupons in Coupon list.
    /// Disable will show only coupons which is restricted to the current user"s email.
    "ShowAllCoupons": true,

    /// Show expired coupons in Coupon list.
    "ShowExpiredCoupons": true,
    "AlwaysShowTabBar": false,

    /// Privacy Policies page ID. Accessible in the app via Settings > Privacy menu.
    "PrivacyPoliciesPageId": 2807,

    /// The radius to get vendors in map view for Fluxstore MV
    "QueryRadiusDistance": 10 //km
  },
  "defaultDrawer": {
    "logo": "assets/images/logo.png",
    "background": null,
    "items": [
      {"type": "home", "show": true},
      {"type": "blog", "show": true},
      {"type": "categories", "show": true},
      {"type": "cart", "show": true},
      {"type": "profile", "show": true},
      {"type": "login", "show": true},
      {"type": "category", "show": true}
    ]
  },
  "defaultSettings": [
    "wishlist",
    "order",
    "authentify",
    "requestshirt",
    "products",
    "chat",
    "about",
    "notifications",
    "language",
    "privacy",
    "darkTheme",
    "point",
    "rating"
  ],
  "loginSetting": {
    "IsRequiredLogin": false,
    "showAppleLogin": true,
    "showFacebook": true,
    "showSMSLogin": true,
    "showGoogleLogin": true,
    "showPhoneNumberWhenRegister": false,
    "requirePhoneNumberWhenRegister": true
  },
  "oneSignalKey": {
    "enable": false,
    "appID": "8b45b6db-7421-45e1-85aa-75e597f62714"
  },

  /// ➡️ lib/common/onboarding.dart
  "onBoardingData": [
    {
      "title": "Welcome to FluxStore",
      "image": "assets/images/fogg-delivery-1.png",
      "desc": "Fluxstore is on the way to serve you. "
    },
    {
      "title": "Connect Surrounding World",
      "image": "assets/images/fogg-uploading-1.png",
      "desc":
          "See all things happening around you just by a click in your phone. "
              "Fast, convenient and clean."
    },
    {
      "title": "Let's Get Started",
      "image": "fogg-order-completed.png",
      "desc": "Waiting no more, let's see what we get!"
    }
  ],

  /// ➡️ lib/common/advertise.dart
  "adConfig": {
    "enable": false,
    "type": "googleBanner",

    /// ----------------- Facebook Ads  -------------- ///
    "hasdedIdTestingDevice": "9dd4404c-5278-46ba-9851-e2dfcccdddb6",
    "bannerAndroidPlacementId": "430258564493822_489007588618919",
    "interstitialAndroidPlacementId": "430258564493822_489092398610438",
    "nativeAndroidPlacementId": "430258564493822_489092738610404",
    "nativeBannerAndroidPlacementId": "430258564493822_489092925277052",
    "banneriOSPlacementId": "430258564493822_489007588618919",
    "interstitialiOSPlacementId": "430258564493822_489092398610438",
    "nativeiOSPlacementId": "430258564493822_489092738610404",

    /// ------------------ Google Admob  -------------- ///
    "androidAppId": "ca-app-pub-2101182411274198~6793075614",
    "androidUnitBanner": "ca-app-pub-2101182411274198/4052745095",
    "androidUnitInterstitial": "ca-app-pub-2101182411274198/7131168728",
    "androidUnitReward": "ca-app-pub-2101182411274198/6939597036",
    "iosAppId": "ca-app-pub-2101182411274198~6923444927",
    "iosUnitBanner": "ca-app-pub-2101182411274198/5418791562",
    "iosUnitInterstitial": "ca-app-pub-2101182411274198/9218413691",
    "iosUnitReward": "ca-app-pub-2101182411274198/9026842008",
    "waitingTimeToDisplayInterstitial": 10,
    "waitingTimeToDisplayReward": 10
  },

  /// ➡️ lib/common/dynamic_link.dart
  "firebaseDynamicLinkConfig": {
    "isEnabled": true,
    // Domain is the domain name for your product.
    // Let’s assume here that your product domain is “example.com”.
    // Then you have to mention the domain name as : https://example.page.link.
    "uriPrefix": "https://fluxstoreinspireui.page.link",
    //The link your app will open
    "link": "https://mstore.io/",
    //----------* Android Setting *----------//
    "androidPackageName": "com.inspireui.fluxstore",
    "androidAppMinimumVersion": 1,
    //----------* iOS Setting *----------//
    "iOSBundleId": "com.inspireui.mstore.flutter",
    "iOSAppMinimumVersion": "1.0.1",
    "iOSAppStoreId": "1469772800"
  },

  /// ➡️ lib/common/languages.dart
  "languagesInfo": [
    {
      "name": "English",
      "icon": "assets/images/country/gb.png",
      "code": "en",
      "text": "English",
      "storeViewCode": ""
    },
    {
      "name": "French",
      "icon": "assets/images/country/fr.png",
      "code": "fr",
      "text": "French",
      "storeViewCode": "fr"
    },
    // Vendor admin does not support unofficial languages (such as Kurdish...)
  ],
  "unsupportedLanguages": ['ku'],

  /// ➡️  lib/common/config/payments.dart
  "paymentConfig": {
    "DefaultCountryISOCode": "VN",

    "DefaultStateISOCode": "SG",

    /// Enable the Shipping option from Checkout, support for the Digital Download
    "EnableShipping": true,

    /// Enable the address shipping.
    /// Set false if use for the app like Download Digial Asset which is not required the shipping feature.
    "EnableAddress": true,

    /// Allow customers to add note when order
    "EnableCustomerNote": true,

    /// Allow customers to add address location link to order note
    "EnableAddressLocationNote": false,

    /// Allow both alphabetical and numerical characters in ZIP code
    "EnableAlphanumericZipCode": false,

    /// Enable the product review option
    "EnableReview": true,

    /// enable the google map picker from Billing Address
    "allowSearchingAddress": true,
    "GuestCheckout": true,

    /// Enable Payment option
    "EnableOnePageCheckout": false,
    "NativeOnePageCheckout": true,

    /// This config is same with checkout page slug in the website
    "CheckoutPageSlug": {"en": "checkout"},

    /// Enable Credit card payment (only available for Fluxstore Shopipfy)
    "EnableCreditCard": false,

    /// Enable update order status to processing after checkout by COD on woo commerce
    "UpdateOrderStatus": true,

    /// Show order notes in order history detail.
    "ShowOrderNotes": true,

    /// Show Refund and Cancel button on Order Detail
    "EnableRefundCancel": false
  },
  "payments": {
    "paypal": "assets/icons/payment/paypal.png",
    "stripe": "assets/icons/payment/stripe.png",
    "razorpay": "assets/icons/payment/razorpay.png",
    "tap": "assets/icons/payment/tap.png"
  },
  "stripeConfig": {
    "serverEndpoint": "https://stripe-server.vercel.app",
    "publishableKey": "pk_test_MOl5vYzj1GiFnRsqpAIHxZJl",
    "enabled": true,
    "paymentMethodId": "stripe",
    "returnUrl": "fluxstore://inspireui.com",

    /// Enable this automatically captures funds when the customer authorizes the payment.
    /// Disable will Place a hold on the funds when the customer authorizes the payment,
    /// but don’t capture the funds until later. (Not all payment methods support this.)
    /// https://stripe.com/docs/payments/capture-later
    /// Default: false
    "enableManualCapture": false
  },
  "paypalConfig": {
    "clientId":
        "ASlpjFreiGp3gggRKo6YzXMyGM6-NwndBAQ707k6z3-WkSSMTPDfEFmNmky6dBX00lik8wKdToWiJj5w",
    "secret":
        "ECbFREri7NFj64FI_9WzS6A0Az2DqNLrVokBo0ZBu4enHZKMKOvX45v9Y1NBPKFr6QJv2KaSp5vk5A1G",
    "production": false,
    "paymentMethodId": "paypal",
    "enabled": true
  },
  "razorpayConfig": {
    "keyId": "rzp_test_SDo2WKBNQXDk5Y",
    "keySecret": "RrgfT3oxbJdaeHSzvuzaJRZf",
    "paymentMethodId": "razorpay",
    "enabled": true
  },
  "tapConfig": {
    "SecretKey": "sk_test_XKokBfNWv6FIYuTMg5sLPjhJ",
    "paymentMethodId": "tap",
    "enabled": true
  },
  "mercadoPagoConfig": {
    "accessToken":
        "TEST-5726912977510261-102413-65873095dc5b0a877969b7f6ffcceee4-613803978",
    "production": false,
    "paymentMethodId": "woo-mercado-pago-basic",
    "enabled": true
  },
  "defaultCountryShipping": [],

  /// config for after shipping
  "afterShip": {
    "api": "e2e9bae8-ee39-46a9-a084-781d0139274f",
    "tracking_url": "https://fluxstore.aftership.com"
  },

  /// ➡️ lib/common/products.dart
  "productDetail": {
    "height": 0.4,
    "marginTop": 0,
    "safeArea": false,
    "showVideo": true,
    "showBrand": true,
    "showThumbnailAtLeast": 1,
    "layout": "simpleType",
    "borderRadius": 3.0,

    /// Enable this to show review in product description.
    "enableReview": false,
    "attributeImagesSize": 50.0,
    "showSku": true,
    "showStockQuantity": true,
    "showProductCategories": true,
    "showProductTags": true,
    "hideInvalidAttributes": false
  },
  "productVariantLayout": {
    "color": "color",
    "size": "box",
    "height": "option",
    "color-image": "image"
  },
  "productAddons": {
    /// Set the allowed file type for file upload.
    /// On iOS will open Photos app.
    "allowImageType": true,
    "allowVideoType": true,

    /// Enable to allow upload files other than image/video.
    /// On iOS will open Files app.
    "allowCustomType": true,

    /// Set allowed file extensions for custom type.
    /// Leave empty ("allowedCustomType": []) to support all extensions.
    "allowedCustomType": ["png", "pdf", "docx"],

    /// NOTE: WordPress might restrict some file types for security purpose.
    /// To allow it, you can add this line to wp-config.php:
    /// define('ALLOW_UNFILTERED_UPLOADS', true);
    /// - which is NOT recommended.
    /// Instead, try to use a plugin like https://wordpress.org/plugins/wp-extra-file-types
    /// to allow custom file types.

    /// Allow selecting multiple files for upload. Default: false.
    "allowMultiple": true,

    /// Set the file size limit (in MB) for upload. Recommended: <15MB.
    "fileUploadSizeLimit": 5.0
  },
  "cartDetail": {"minAllowTotalCartValue": 0, "maxAllowQuantity": 10},
  "productVariantLanguage": {
    "en": {
      "color": "Color",
      "size": "Size",
      "height": "Height",
      "color-image": "Color"
    },
    "ar": {
      "color": "اللون",
      "size": "بحجم",
      "height": "ارتفاع",
      "color-image": "اللون"
    },
    "vi": {
      "color": "Màu",
      "size": "Kích thước",
      "height": "Chiều Cao",
      "color-image": "Màu"
    }
  },

  /// Exclude this categories from the list
  "saleOffProduct": {
    /// Show Count Down for product type SaleOff
    "ShowCountDown": true,
    "Color": "#C7222B"
  },

  /// This is strict mode option to check the `visible` option from product variant
  /// https://tppr.me/4DJJs - default value is false
  "notStrictVisibleVariant": true,

  /// ➡️ lib/common/smartchat.dart
  "configChat": {"EnableSmartChat": false},

  /// config for the chat app
  /// config Whatapp: https://faq.whatsapp.com/en/iphone/23559013
  "smartChat": [
    {"app": "https://wa.me/849908854", "iconData": "whatsapp"},
    {"app": "tel:8499999999", "iconData": "phone"},
    {"app": "sms://8499999999", "iconData": "sms"},
    {"app": "firebase", "iconData": "google"},
    {
      "app": "https://tawk.to/chat/5e5cab81a89cda5a1888d472/default",
      "iconData": "facebookMessenger"
    }
  ],
  "adminEmail": "psginmyblood@gmail.com",
  "adminName": "Seb Admin",

  /// ➡️ lib/common/vendor.dart
  "vendorConfig": {
    /// Show Register by Vendor
    "VendorRegister": true,

    /// Disable show shipping methods by vendor
    "DisableVendorShipping": false,

    /// Enable/Disable showing all vendor markers on Map screen
    "ShowAllVendorMarkers": true,

    /// Enable/Disable native store management
    "DisableNativeStoreManagement": false,

    /// Dokan Vendor Dashboard
    "dokan": "my-account?vendor_admin=true",
    "wcfm": "store-manager?vendor_admin=true"
  },

  //lib/common/loading.dart
  "loadingIcon": {"size": 30.0, "type": "fadingCube"}
};
