# Логирование
Логирование достаточно важная часть любой программы. Теперь логирование это одна из основных частей библиотеки. Логи содержат ошибки, предупреждения и просто отладочную информацию, которая поддерживает табуляцию.

## Использование
Для перехвата логов от библиотеки надо переопределить функцию логирования:
```Swift
func yourfunction(level: DILogLevel, msg: String) {
yourlogger.log("\(level): \(msg)")
}
DISettings.Log.fun = yourfunction
```
По умолчанию эта функция определена как вывод в консоль.

На вход функция принимает уровень логирования и сообщение. Уровни логирования бывают трех видов:
* none - логи полностью отключены. Похожего поведения можно добиться, присвоив функции логирования nil.
* error - будут показываться только ошибки. Ошибка предполагает, что дальнейшее исполнение программы может привести к падению.
* warning - ошибки и предупреждения. На предупреждения стоит обращать внимания, но программа сможет работать вместе с ними.
* info - ошибки, предупреждения, информация. На информацию стоит обращать внимание, если хочется более подробно понять, в чем причина предупреждения или ошибки.

Задать максимальный уровень логирования можно так:
```Swift
DISettings.Log.level = .info
```

Ну и если вам не нравится стандартная табуляция в информации, которая отображает уровень вложенности при разрешении зависимости, то ее можно заменить на свою:
```Swift
DISettings.Log.tab = "-"
```

#### [Главная](main.md)
#### [Предыдущая глава "Поиск"](scan.md#Поиск)
#### [Следующая глава "Примеры"](sample.md#Примеры)

