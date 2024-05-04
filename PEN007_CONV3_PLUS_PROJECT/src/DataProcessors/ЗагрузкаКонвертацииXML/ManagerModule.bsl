#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

&ИзменениеИКонтроль("ЗагрузитьПараметры")
Процедура PEN007_ЗагрузитьПараметры(ПравилаОбмена, ОбщиеПеременные)
	ТабПараметры = Новый ТаблицаЗначений;
	Колонки = ТабПараметры.Колонки;

	Колонки.Добавить("Параметр");
	#Вставка
	Колонки.Добавить("ОписаниеПараметра");
	#КонецВставки
	Колонки.Добавить("УстанавливатьВДиалоге");
	Колонки.Добавить("ТипОбъекта");
	Колонки.Добавить("ИспользуетсяПриЗагрузке");
	Колонки.Добавить("ПередаватьПараметрПриВыгрузке");
	Колонки.Добавить("АлгоритмПослеЗагрузкиПараметра");
	Колонки.Добавить("ПравилоКонвертации");

	Пока ПравилаОбмена.Прочитать() Цикл
		ИмяУзла = ПравилаОбмена.ЛокальноеИмя;
		ТипУзла = ПравилаОбмена.ТипУзла;

		Если ИмяУзла = "Параметр" И ТипУзла = ТипУзлаXML.НачалоЭлемента Тогда

			// Загрузка по версии правил 2.01
			НоваяСтрока                       = ТабПараметры.Добавить();
			НоваяСтрока.Параметр              = одАтрибут(ПравилаОбмена, "Имя");
			#Вставка
			НоваяСтрока.ОписаниеПараметра = одАтрибут(ПравилаОбмена, "Наименование");
			#КонецВставки
			НоваяСтрока.УстанавливатьВДиалоге = одАтрибут(ПравилаОбмена, "УстанавливатьВДиалоге");
			НоваяСтрока.ТипОбъекта            = Строка(ПравилаОбмена.ПолучитьАтрибут("ТипЗначения"));
			НоваяСтрока.ИспользуетсяПриЗагрузке = одАтрибут(ПравилаОбмена, "ИспользуетсяПриЗагрузке", Тип("Булево"));
			НоваяСтрока.ПередаватьПараметрПриВыгрузке = одАтрибут(ПравилаОбмена, "ПередаватьПараметрПриВыгрузке", Тип("Булево"));
			НоваяСтрока.АлгоритмПослеЗагрузкиПараметра  = одАтрибут(ПравилаОбмена, "ПослеЗагрузкиПараметра");
			НоваяСтрока.ПравилоКонвертации = одАтрибут(ПравилаОбмена, "ПравилоКонвертации");

		ИначеЕсли (ТипУзла = ТипУзлаXML.Текст) Тогда

			// Для совместимости с версией правил 2.0 используем загрузку из строки
			СтрокаПараметров = ПравилаОбмена.Значение;
			Для каждого Пар Из СтрРазделить(СтрокаПараметров,, Ложь) Цикл
				НоваяСтрока                       = ТабПараметры.Добавить();
				НоваяСтрока.Параметр              = Пар;
				НоваяСтрока.УстанавливатьВДиалоге = ЛОЖЬ;
				НоваяСтрока.ТипОбъекта            = "";
				НоваяСтрока.ИспользуетсяПриЗагрузке = Истина;
				НоваяСтрока.ПередаватьПараметрПриВыгрузке = ЛОЖЬ;
				НоваяСтрока.ПравилоКонвертации = "";
				НоваяСтрока.АлгоритмПослеЗагрузкиПараметра = "";
			КонецЦикла;

		ИначеЕсли (ИмяУзла = "Параметры") И (ТипУзла = ТипУзлаXML.КонецЭлемента) Тогда
			Прервать;
		КонецЕсли;
	КонецЦикла;
	ОбщиеПеременные.Вставить("Параметры", ТабПараметры);
КонецПроцедуры

#КонецОбласти

#КонецЕсли