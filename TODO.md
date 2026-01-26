# TODO.md — My personal TODO list

Claude Code MUST NOT use the file TODO.md! It is not a list of features to implement. It is not a software requirements!
Claude Code MUST ignore this file!

## Road Map

V1.0
* Z порядок: наверх, вниз, на самый верх и в самый низ.
* Сайт для проекта
* Запоминать в File->Open предыдущий используемый диреткорий и если возможно, то октрывать его, если нет, то директорй по умолчанию ~/Documents.
* Если вытащить объекты на PDF, а потом все удалить, то признак dirty должен сниматься.
* Поддержка PDF запароленных (save с оригинальным паролем, save as с оригинальным паролем, share с оригинальным паролем)
* Сделать README.md
* Сделать RELESE_NOTES.md
* Не откарывть все окна в одном месте при открытии несокьких файлов из Finder.

V1.1
* Добавить Undo / Redo + соотв кнопки на заголовке окна.
* "Cmd + R" - Rote all pages left on 90 degrees including all images dragged to the PDF page from the right panel. Old version of the command must be deleted. Кнопка на заголовке окна.
* Копирование объекта с одного PDF на другой с учетом размера и угла поворота.

V1.2
* Пернименование файла в заголовке с изменением его имени в Recent Open.
* Копироование любого изображения из буфера обмена на поверхность PDF (без предварительного добавления в правую панель).

V1.3
* Добавление надписей с выбором цвета и ширифта, вращение надписей.

Future Releases
* Заменить белый цвет на прозрачность (помощь пользователю, чтобы сделать фон прозрачным)
* Сфоткать через камеру лист бумаги и сделать из этого подпись с прозрачностью.

Here is your Essential Studio® suite with a 7-day license key. This key can be used until your community license request is approved. 
We will send your long-term license key then.
Syncfusion Community License: Ngo9BigBOggjHTQxAR8/V1JGaF5cXGpCf0x0RHxbf1x2ZFBMYFRbRHNPMyBoS35RcEViWHtedXRdRmVbUk1xVEF

flutter clean
flutter build ios
open ios/Runner.xcworkspace

**iOS**
# Запуск на симуляторе
flutter run -d ios

# Или указать конкретный симулятор
open -a Simulator
flutter devices                              # посмотреть список устройств
flutter run -d 5486E84C-44F1-4ED1-BBDC-A92890B71AED     # запуск на конкретном симуляторе

**Android**
# Запуск на эмуляторе или подключённом устройстве
flutter run -d android

# Или указать конкретное устройство
flutter devices                    # посмотреть список устройств
flutter run -d emulator-5554       # запуск на конкретном эмуляторе
