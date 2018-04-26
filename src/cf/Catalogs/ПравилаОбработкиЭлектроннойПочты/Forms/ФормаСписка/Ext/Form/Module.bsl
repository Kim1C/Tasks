﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	Если Параметры.Отбор.Свойство("Владелец") Тогда
		
		Если НЕ Взаимодействия.ПользовательЯвляетсяОтветственнымЗаВедениеПапок(Параметры.Отбор.Владелец) Тогда
			
			ТолькоПросмотр = Истина;
			
			Элементы.ФормаКоманднаяПанель.ПодчиненныеЭлементы.ФормаПрименитьПравила.Видимость               = Ложь;
			Элементы.ФормаКоманднаяПанель.ПодчиненныеЭлементы.СписокПереместитьВариантОтветаВверх.Видимость = Ложь;
			Элементы.ФормаКоманднаяПанель.ПодчиненныеЭлементы.СписокПереместитьВариантОтветаВниз.Видимость  = Ложь;
			
		КонецЕсли;
		
	Иначе
		
		Отказ = Истина;
		
	КонецЕсли;
	
	//+ #286 Иванов А.Б. 2017-12-17
	узОбщийМодульСервер.ДобавитьРеквизитыНаФормуСписка(ЭтотОбъект, узОбщийМодульСервер.ИмяМетаданных_ПравилаОбработкиЭлектроннойПочты());                              
	//- #286 Иванов А.Б. 2017-12-17
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПрименитьПравила(Команда)
	
	ОчиститьСообщения();
	
	ПараметрыФормы = Новый Структура;
	
	МассивЭлементовОтбора = ОбщегоНазначенияКлиентСервер.НайтиЭлементыИГруппыОтбора(ВзаимодействияКлиентСервер.ОтборДинамическогоСписка(Список), "Владелец");
	Если МассивЭлементовОтбора.Количество() > 0 И МассивЭлементовОтбора[0].Использование
		И ЗначениеЗаполнено(МассивЭлементовОтбора[0].ПравоеЗначение) Тогда
		ПараметрыФормы.Вставить("УчетнаяЗапись",МассивЭлементовОтбора[0].ПравоеЗначение);
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Не установлен отбор по владельцу(учетной записи) правил.'"));
		Возврат;
	КонецЕсли;
	
	ОткрытьФорму("Справочник.ПравилаОбработкиЭлектроннойПочты.Форма.ПрименениеПравил", ПараметрыФормы, ЭтотОбъект);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Команды подсистемы настройка порядка элементов для подчиненного справочника.
//

&НаКлиенте
Процедура ПереместитьЭлементВверх(Команда)
	
	НастройкаПорядкаЭлементовКлиент.ПереместитьЭлементВверхВыполнить(Список, Элементы.Список);
	
КонецПроцедуры

&НаКлиенте
Процедура ПереместитьЭлементВниз(Команда)
	
	НастройкаПорядкаЭлементовКлиент.ПереместитьЭлементВнизВыполнить(Список, Элементы.Список);
	
КонецПроцедуры

#КонецОбласти
