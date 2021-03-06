///////////////////////////////////////////////////////////////////////////////
// 
// Служебный модуль с реализацией сценариев обработки файлов <УдалениеЛишнихПустыхСтрок>
//
///////////////////////////////////////////////////////////////////////////////

// ИмяСценария
//	Возвращает имя сценария обработки файлов
//
// Возвращаемое значение:
//   Строка   - Имя текущего сценария обработки файлов
//
Функция ИмяСценария() Экспорт
	
	Возврат "УдалениеЛишнихПустыхСтрок";

КонецФункции // ИмяСценария()

// ОбработатьФайл
//	Выполняет обработку файла
//
// Параметры:
//  АнализируемыйФайл		- Файл - Файл из журнала git для анализа
//  КаталогИсходныхФайлов  	- Строка - Каталог расположения исходных файлов относительно каталог репозитория
//  ДополнительныеПараметры - Структура - Набор дополнительных параметров, которые можно использовать 
//  	* Лог  					- Объект - Текущий лог
//  	* ИзмененныеКаталоги	- Массив - Каталоги, которые необходимо добавить в индекс
//		* КаталогРепозитория	- Строка - Адрес каталога репозитория
//		* ФайлыДляПостОбработки	- Массив - Файлы, изменившиеся / образоавшиеся в результате работы сценария
//											и которые необходимо дообработать
//
// Возвращаемое значение:
//   Булево   - Признак выполненной обработки файла
//
Функция ОбработатьФайл(АнализируемыйФайл, КаталогИсходныхФайлов, ДополнительныеПараметры) Экспорт
	
	Лог = ДополнительныеПараметры.Лог;
	НастройкиСценария = ДополнительныеПараметры.УправлениеНастройками.Настройка("Precommt4onecСценарии\НастройкиСценариев").Получить(ИмяСценария());
	Если АнализируемыйФайл.Существует() И ТипыФайлов.ЭтоФайлИсходников(АнализируемыйФайл) Тогда
		
		Лог.Информация("Обработка файла '%1' по сценарию '%2'", АнализируемыйФайл.ПолноеИмя, ИмяСценария());
		
		Если УдалитьЛишниеПустыеСтроки(АнализируемыйФайл.ПолноеИмя) Тогда

			ДополнительныеПараметры.ИзмененныеКаталоги.Добавить(АнализируемыйФайл.ПолноеИмя);

		КонецЕсли;

		Возврат Истина;
		
	КонецЕсли;
	
	Возврат ЛОЖЬ;

КонецФункции // ОбработатьФайл()

Функция УдалитьЛишниеПустыеСтроки(Знач ИмяФайла)

	Текст = Новый ЧтениеТекста();
	Текст.Открыть(ИмяФайла, КодировкаТекста.UTF8NoBOM);
	СодержимоеФайла = Текст.Прочитать();
	Текст.Закрыть();
	
	Если Не ЗначениеЗаполнено(СодержимоеФайла) Тогда
		
		Возврат Ложь;
		
	КонецЕсли;
	
	РегекспОчистка = Новый РегулярноеВыражение("(?m:((?:^[ \t]*\n){2,}))");
	РегекспОчистка.Многострочный = Истина;
	РегекспОчистка.ИгнорироватьРегистр = Истина;
	НовоеСодержимоеФайла = РегекспОчистка.Заменить(СодержимоеФайла, Символы.ПС);
	Если СтрСравнить(СодержимоеФайла, НовоеСодержимоеФайла) <> 0 Тогда
		
		ЗаписьТекста = Новый ЗаписьТекста(ИмяФайла, КодировкаТекста.UTF8NoBOM,,, Символы.ПС);
		ЗаписьТекста.Записать(НовоеСодержимоеФайла);
		ЗаписьТекста.Закрыть();
		Возврат Истина;
		
	КонецЕсли;
	
	Возврат Ложь;

КонецФункции
