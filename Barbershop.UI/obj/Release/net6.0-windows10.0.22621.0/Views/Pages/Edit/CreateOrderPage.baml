   M S B A M L   `   `   `  ���� H  DBarbershop.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullC&clr-namespace:Barbershop.UI.ConvertersBarbershop.UI.Converters  O,clr-namespace:Barbershop.UI.Views.Pages.EditBarbershop.UI.Views.Pages.Edit  O KBarbershop.Contracts, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullgGclr-namespace:Barbershop.Contracts.Models;assembly=Barbershop.ContractsBarbershop.Contracts.Models R Nnetstandard, Version=2.1.0.0, Culture=neutral, PublicKeyToken=cc7b13ffcd2ddd514)clr-namespace:System;assembly=netstandardSystem Y1clr-namespace:Barbershop.UI.ViewModels.Pages.Edit#Barbershop.UI.ViewModels.Pages.Edit  4    .Barbershop.UI.Views.Pages.Edit.CreateOrderPage   Z VDevExpress.Mvvm.UI, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     =
converters&clr-namespace:Barbershop.UI.Converters     @d2http://schemas.microsoft.com/expression/blend/2008     S	 OHandyControl, Version=3.5.2.0, Culture=neutral, PublicKeyToken=45be8712787a1e5b0hc'https://handyorg.github.io/handycontrol 	 8local,clr-namespace:Barbershop.UI.Views.Pages.Edit 	 Dmc;http://schemas.openxmlformats.org/markup-compatibility/2006 	 TmodelsGclr-namespace:Barbershop.Contracts.Models;assembly=Barbershop.Contracts 	 3sys)clr-namespace:System;assembly=netstandard 	 :vm1clr-namespace:Barbershop.UI.ViewModels.Pages.Edit 	 -     >�Name$  control��$	��800��$	��550��$	��800��$	��450�� � 	Resources    ServiceDataTemplate �� DataType � RowDefinitions � DataContext `� 	Converter;   5Barbershop.UI.Converters.ServiceDtoToServiceConverter �� Path �� RelativeSource �� Mode	 �� AncestorType
 � ColumnDefinitions, 	 &HandyControl.Controls.SimpleStackPanel   Orientation  
TimerImage �� 	Converter7   1Barbershop.UI.Converters.IntToTimeStringConverter  
MoneyImage9   3Barbershop.UI.Converters.DecimalToCurrencyConverter��%4  &	        7  7  �� $ models:ServiceDto��.R��  �� $��30���� $��30��.+��� $��0��$��2��$��Center=�$��14(����� *Name+� $��1�� `�    .1��� $ .��� $  DataContext.SelectedBarber� �� $ FindAncestor=�	 UserControl
 �� $	��100 ��� .+�  $��0��$
��Left=�$ 
Horizontal=�.+��� $��30��$��10,0,0,0q�8��  �� $��Center=����� *MinutesDuration+     $��1��$
��Left=�$ 
Horizontal=�.+��� $��30��$��10,0,0,0q�8�� �� $��Center=����� *Cost+   , 	 &HandyControl.Interactivity.Interaction   Triggers - 	 'HandyControl.Interactivity.EventTrigger     	EventName$ Loaded��, 	 &HandyControl.Interactivity.TriggerBase   Actions. 4 	 .HandyControl.Interactivity.InvokeCommandAction     Command �� *LoadViewDataCommand+.���  �� $
��auto ��� .+�#	 	 HandyControl.Controls.StepBar	  $��0�� 	  	StepIndex �� *SelectedTabIndex+ �� Mode$ OneWay=�.@�'
 	 !HandyControl.Controls.StepBarItem
  
  
  
  
  & 	  HandyControl.Controls.TabControl  $��1��$
��0,10q�   IsTabFillEnabled$
 True��  TabControlInLine#��[  �� SelectedIndex �� *SelectedTabIndex+$ TwoWay=�.@�# 	 HandyControl.Controls.TabItem  $��Выбор клиента�� �� 
IsSelected$
 True��.��A� $��10q� A� Columns$ 2�� A� Rows$ 1��.+�]� $��5q�.+�% 	 HandyControl.Controls.SearchBar  ' 	 !HandyControl.Controls.InfoElement   Placeholder$9 3ФИО клиента / Номер телефона��( 	 "HandyControl.Controls.TitleElement   TitlePlacement$
 Left=�$	��Top=�  SearchBarExtend#��[ ���� *SearchClientText+$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=��� $��0,5,0,0q����� *ClientsView+ �� SelectedItem �� *SelectedClient+$ TwoWay=��� $��Center=�$��Center=�   TextBoxExtend �� BasedOn# 	 HandyControl.Controls.TextBox �� 
TargetType �� Property �� Value��%^   '        7  �� 8   "  .���  � ��$ 0,0,0,5q���  �@��
IsReadOnly$
 True��.+��� $	��150��$	��200��$��Uniform=����� *SelectedClient.Photo+ 4   .Barbershop.UI.Converters.BytesToImageConverter  �� $��0,10,0,0q�$��Center=�$��20(��� ��� *SelectedClient.LastName+ �� ��� *SelectedClient.FirstName+ �� ��� *SelectedClient.Surname+�� $
��0,10q�$��Center=�$��14(����� *SelectedClient.PhoneNumber+  $��Выбор мастера��{��� *SelectedClient+  Object2BooleanConverter# [ .��A� $��10q�$ 2��$ 1��.+�]� $��5q�.+�  $ ФИО мастера��$
 Left=�$	��Top=�#��[ ���� *SearchBarberText+$ TwoWay=�$ PropertyChanged=��� $��0,5,0,0q����� *BarbersView+ �� *SelectedBarber+$ TwoWay=��� $��Center=�$��Center=� ��%^   '        7  �� 8   "  .���  � ��$ 0,0,0,5q���  �@��
IsReadOnly$
 True��.+���   BorderBrush#��[ $��2q�._��� $	��150��$	��200������ *SelectedBarber.Photo+   �� $��0,10,0,0q�$��Center=�$��20(��� ��� *SelectedBarber.LastName+ �� ��� *SelectedBarber.FirstName+ �� ��� *SelectedBarber.Surname+�� $
��0,10q�$��Center=�$��14(����� *SelectedBarber.SkillLevel+ 9   3Barbershop.UI.Converters.EnumToDescriptionConverter    $��Выбор услуг��$
 True��{��� *SelectedBarber+# [ .��� $��10q�
 �� �� $��60 ��� .+��� $��0��#��[    �� SelectionMode$  Single=����� *
Services+ �� *ServiceToSelect+   $ MouseDoubleClick��. / 	 )HandyControl.Interactivity.EventToCommand  !   Command! �� *SelectServiceCommand+�� -   " ��Name$" lstSelectedServices��$��2��#��[  $  Single=����� *SelectedServices+ �� *SelectedService+   $ MouseDoubleClick��.   ! �� *RemoveSelectedServiceCommand+�� $��1��$��Center=�.+���   LeftGeometry' 	 !HandyControl.Controls.IconElement#   Geometry## [ ���� *RemoveSelectedServiceCommand+�� $��0,10,0,0q� 	 RightGeometry## [	 ���� *SelectServiceCommand+  $��Выбор даты��{��� *SelectedServices.Count+$ OneWay=� 4   .Barbershop.UI.Converters.IntToBooleanConverter     $ IsVisibleChanged��.    �� *BarberChangedCommand+.���� $��10q�$��Center=�$��Center=�.+��� $��0��$��30��$��Center=�$ �� Orientation$$ 
Horizontal=�.+��� $��0,0,10,0q�$��Center=�$��16(�$��День записи��(  "System.Windows.Controls.DatePicker  $	��300��
% �� Now&   DisplayDateStart#& Z% '   SelectedDate' �� *SelectedDate+$ TwoWay=�$ PropertyChanged=��� $��24��$��24��$��5,0,0,0q�$��0q� 
 InfoGeometry## [
 ${�False��( ^� BetweenShowDelay$( 0��) ^� HorizontalOffset$) 30��* ^� InitialShowDelay$* 0��+ ^� ShowOnDisabled$
+ True��, � ToolTip, �� $��Center=�.+��� $$ 
Horizontal=�.+�	� $��70��$
��0,10q�$��0q�) 	 #HandyControl.Controls.BorderElement-   CornerRadius$- 3��$
��9:30��$��16(�  RadioButtonIconBaseStyle#��[ �� $��10,0,0,0q�$��Center=�$7��1Свободное время для записи���� $��70��$$ 
Horizontal=�.+�	� $��70��$
��0,10q�$��0q�$- 3��$
��9:30��$��16(�${�False�� " RadioButtonSameAsButtonPrimary#��[ �� $	��300��$��10,0,0,0q�$��Center=�$r��lПотенциально свободное время при меньшем количестве услгу��$��WrapWithOverflow=��� $$ 
Horizontal=�.+�	� $��70��$
��0,10q�$��0q�$- 3��$
��9:30��$��16(�${�False��#��[ �� $��10,0,0,0q�$��Center=�$��Время занято���� $��1��$��0,30,0,0q�$��Center=�$��Center=����� *	TimeSlots+���� .R�* 	 $HandyControl.Controls.WaterfallPanel  $	��500��$��Center=�.   Groups$. 4��/   Orientation$/ 
Horizontal=����� .R�	� $��70��$
��0,10q�$��0q�$- 3��$��16(�0 	� 	GroupName$0 Slots������ {��� *State+$ OneWay=� :  4Barbershop.UI.Converters.SlotStateToBooleanConverter  ���� *State+ 8  2Barbershop.UI.Converters.SlotStateToStyleConverter     $ Checked��.   1   PassEventArgsToCommand$
1 True��! �� *#!DataContext.SelectTimeSlotCommand+2 �� ElementName$2 control��  $-��'Подтверждение заказа��{��� *CanCreateOrder+$ OneWay=�.��A� $��10q�$ 2��$ 1��.+��� $��0,0,10,0q�.+�  3   Title$3 Клиент��$	 Top=�$��16(�4 �� 
IsReadOnly$
4 True������ *SelectedClient+$ OneWay=��� $��8,20,0,3q�$��16(����� *SelectedBarber.SkillLevel+     $��0,0,0,10q�$	 Top=�$��16(�$
4 True������ *SelectedBarber+$ OneWay=��� $
��0,10q�$��Center=�$$ 
Horizontal=�.+��� $��30��#��[ �� $��Center=�$��16(�  	BaseStyle#��[ ���� *TotalMinutes+   �� $
��0,10q�$��Center=�$$ 
Horizontal=�.+��� $��30��#��[ �� $��Center=�$��16(�#��[ ���� *	TotalCost+   �� $
��0,10q�$��Center=�$$ 
Horizontal=�.+��� $��30��  	DateImage#��[ �� $��Center=�$��16(�#��[ .���� $$ 
Horizontal=�.+��� ���� *SelectedDate.Date+5 �� StringFormat$5 
dd.MM.yyyy���� $��  ���� ���� *SelectedTimeSlot+� $��10,0,0,0q� �� $
��auto ��� �� $
��auto �.+��� $��16(�$%��Выбранные услуги���� $��1��$��	0,10,0,10q�#��[  $  Single=����� *SelectedServices+�� $��2��$	��180��$��0q�$��Right=�$��Center=�$��Создать заказ��$��16(�$��DemiBold"�  ButtonSuccess#��[ ���� *CreateOrderCommand+