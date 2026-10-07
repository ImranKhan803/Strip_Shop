# Stripe Shop (Flutter + GetX)

## Setup (5 steps)
1. Is folder mein terminal kholein aur chalayein:
   `flutter create . --platforms=android,ios`
   (ye android/ios folders bana dega, `lib/` aur `pubspec.yaml` wese hi rahenge)
2. `flutter pub get`
3. `lib/constants.dart` mein apni Stripe **test** keys daalein.
4. **Android** (zaroori, warna payment sheet crash hogi):
   - `android/app/src/main/kotlin/.../MainActivity.kt`:
     `class MainActivity : FlutterFragmentActivity()` (import `io.flutter.embedding.android.FlutterFragmentActivity`)
   - `android/app/src/main/res/values/styles.xml` aur `values-night/styles.xml` mein
     parent badal kar `Theme.MaterialComponents.Light.NoActionBar` karein.
   - `android/app/build.gradle` mein `minSdkVersion 21` (ya `flutter.minSdkVersion`).
5. **iOS**: `ios/Podfile` mein `platform :ios, '13.0'`, phir `cd ios && pod install`.

`flutter run` chalayein.

## Test card
Number `4242 4242 4242 4242`, koi bhi future date, CVC `123`.

## Structure
- `models/product.dart` – products list
- `controllers/cart_controller.dart` – GetX: cart + checkout
- `services/stripe_service.dart` – Stripe API + payment sheet
- `views/` – Shop, Cart, Success pages
- `widgets/` – ProductCard, QtyStepper

## ⚠️ Security
Secret key sirf learning/testing ke liye app mein hai. Real app mein PaymentIntent
apne backend (Node/Firebase Functions) se banayein.
