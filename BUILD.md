Claude Code MUST NOT use the file TODO.md! It is not a list of features to implement. It is not a software requirements!
Claude Code MUST ignore this file!


Here is your Essential Studio® suite with a 7-day license key. This key can be used until your community license request is approved. 
We will send your long-term license key then.
Syncfusion Community License: Ngo9BigBOggjHTQxAR8/V1JGaF5cXGpCf0x0RHxbf1x2ZFBMYFRbRHNPMyBoS35RcEViWHtedXRdRmVbUk1xVEF

open -a Simulator
flutter clean
flutter build ios
flutter run -d 5486E84C-44F1-4ED1-BBDC-A92890B71AED
cd ios
pod install
cd ../
open ios/Runner.xcworkspace

**iOS**
# Запуск на симуляторе
flutter run -d ios

# Или указать конкретный симулятор
open -a Simulator
flutter devices                              # посмотреть список устройств
flutter run -d 5486E84C-44F1-4ED1-BBDC-A92890B71AED     # запуск на конкретном симуляторе

**Android**
# Сборка APK
flutter build apk --release          # релизная сборка APK
flutter build apk --debug            # дебаг сборка APK
flutter build appbundle --release    # AAB для Google Play

# Запуск на эмуляторе или подключённом устройстве
flutter run -d android

# Или указать конкретное устройство
flutter devices                    # посмотреть список устройств
flutter emulators
flutter run -d Pixel_2_API_32       # запуск на конкретном эмуляторе
