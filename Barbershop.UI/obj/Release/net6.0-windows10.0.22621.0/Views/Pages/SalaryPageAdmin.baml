   M S B A M L   `   `   `  ���� H  DBarbershop.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullC&clr-namespace:Barbershop.UI.ConvertersBarbershop.UI.Converters  E'clr-namespace:Barbershop.UI.Views.PagesBarbershop.UI.Views.Pages  O,clr-namespace:Barbershop.UI.ViewModels.PagesBarbershop.UI.ViewModels.Pages  /    )Barbershop.UI.Views.Pages.SalaryPageAdmin   Z VDevExpress.Mvvm.UI, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     =
converters&clr-namespace:Barbershop.UI.Converters     @d2http://schemas.microsoft.com/expression/blend/2008     S OHandyControl, Version=3.5.2.0, Culture=neutral, PublicKeyToken=45be8712787a1e5b0hc'https://handyorg.github.io/handycontrol  3local'clr-namespace:Barbershop.UI.Views.Pages  Dmc;http://schemas.openxmlformats.org/markup-compatibility/2006  5vm,clr-namespace:Barbershop.UI.ViewModels.Pages    N� Title$  SalaryPageAdmin��,  &HandyControl.Interactivity.Interaction   Triggers -  'HandyControl.Interactivity.EventTrigger     	EventName$ Loaded��,  &HandyControl.Interactivity.TriggerBase   Actions. 4  .HandyControl.Interactivity.InvokeCommandAction     Command �� *LoadViewDataCommand+.���  � RowDefinitions �� $	��150 ��� .+���  K� ZIndex$ 10�����	#33000000 �� CornerRadius$ 10��y��� *IsUploading+   Boolean2VisibilityConverter �� 	Converter# [  ._�)  #HandyControl.Controls.LoadingCircle    LoadingCircleLight#��[ �� $��0��$��0,0,0,5q����� $��16(�$��DemiBold"�$��Фильтр��.��� 	 � ColumnDefinitions	 �� �� $��40 �.+�]� $��0��.+�	� $��0,0,20,0q�$��За всё время��
 d� 	IsChecked
 �� *WithoutDateSelected+	� $��0,0,20,0q�$��Сегодня��
 �� *TodayFilterSelected+	� $��0,0,20,0q�$$��Последние 30 дней��
 �� *
Last30Days+	� $��0,0,20,0q�$��Текущий месяц��
 �� *CurrentMonth+�� $��Center=�.+�&   HandyControl.Controls.DatePicker  $��0,0,0,2q�'  !HandyControl.Controls.InfoElement   Placeholder$
 От��   ShowClearButton$
 True��(  "System.Windows.Controls.DatePicker   SelectedDate �� *FromDateSelected+  $��0,2,0,0q�$
 До��$
 True�� �� *ToDateSelected+� $��1��.+��� $��23��$��30��$��0,6,0,0q�$��0q�$	��Top=�  RemoveGeometry'	  !HandyControl.Controls.IconElement 	  Geometry# [   ButtonDashedDanger#��[ ���� *ClearFilterCommand+�� $��23��$��50��$��0,0,0,3q�$��0q�$��Bottom=�  SearchGeometry# [  	  Width$ 15Q�$��Bottom=�  ButtonSuccess#��[ ���� *FilterOrdersCommand+�� $��1������ $��16(�$��DemiBold"�$)��#Выполненные заказы��.���  �� �� $��50 �.+�&
   System.Windows.Controls.DataGrid
  *  $HandyControl.Controls.DataGridAttach   ShowRowNumber$ False�� 
  AutoGenerateColumns$ False������ *Orders+ �� Mode$ OneWay=� � 	Resources  �� 
TargetType �� Property �� Value��%0   '��       �� " ��.���  � ��$ Right=� 
  Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Width5  /System.Windows.Controls.DataGridLengthConverter$ 50    Header$ #��   
IsReadOnly$
 True��1  +System.Windows.Controls.DataGridBoundColumn   Binding �� *Id+  $ Дата��$
 True�� �� *BeginDateTime+ �� StringFormat$ yyyy.MM.dd HH:mm��  $ * $ Барбер��$
 True�� �� *Barber+  $( "Продолжительность��$
 True�� �� *TotalMinutes+ 7   1Barbershop.UI.Converters.IntToTimeStringConverter    $	 150 $# Общая стоимость��$
 True�� �� *TotalServicesPrice+$ OneWay=� 9   3Barbershop.UI.Converters.DecimalToCurrencyConverter    $	 100 $ Ставка��$
 True�� �� *BarbersGain+  $	 150 $ 
Доход��$
 True�� �� *
PureCost+$ OneWay=�   A� $��1�� A� Columns$ 2��.+��� $��Center=�$��Center=� �� Orientation$ 
Horizontal=� � ToolTip$I CСуммарное время выполненных заказов��.+��� $��30��  
TimerImage#��[ �� $��Center=�$��16(�  	BaseStyle#��[ ���� *TotalMinutes+   �� $��Center=�$��Center=�$ 
Horizontal=�$H BОбщий заработок за выбранный период��.+��� $��30��  
MoneyImage#��[ �� $��16(�#��[ ���� *	TotalCost+   