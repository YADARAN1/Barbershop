   M S B A M L   `   `   `  ���� H  DBarbershop.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullC&clr-namespace:Barbershop.UI.ConvertersBarbershop.UI.Converters  E'clr-namespace:Barbershop.UI.Views.PagesBarbershop.UI.Views.Pages  O,clr-namespace:Barbershop.UI.ViewModels.PagesBarbershop.UI.ViewModels.Pages  *    $Barbershop.UI.Views.Pages.OrdersPage   Z VDevExpress.Mvvm.UI, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     =
converters&clr-namespace:Barbershop.UI.Converters     @d2http://schemas.microsoft.com/expression/blend/2008     W SDevExpress.Mvvm, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30Adxmvvm2http://schemas.devexpress.com/winfx/2008/xaml/mvvm   S OHandyControl, Version=3.5.2.0, Culture=neutral, PublicKeyToken=45be8712787a1e5b0hc'https://handyorg.github.io/handycontrol  3local'clr-namespace:Barbershop.UI.Views.Pages  Dmc;http://schemas.openxmlformats.org/markup-compatibility/2006  5vm,clr-namespace:Barbershop.UI.ViewModels.Pages  -     N�Name$
  page�� � 	Resources 2  ,DevExpress.Mvvm.UI.NumericToBooleanConverter   NumericToBooleanConverter��%   &	          ,  &HandyControl.Interactivity.Interaction   Triggers -  'HandyControl.Interactivity.EventTrigger     	EventName$ Loaded��,  &HandyControl.Interactivity.TriggerBase   Actions. 4  .HandyControl.Interactivity.InvokeCommandAction     Command �� *LoadViewDataCommand+  $ Selected��. /  )HandyControl.Interactivity.EventToCommand     PassEventArgsToCommand$
 True��   Command �� *SelectBarberCommand+.��� .+���  K� ZIndex$ 10�����	#33000000	 �� CornerRadius$	 10��y��� *IsUploading+  Boolean2VisibilityConverter
 �� 	Converter#
 [ ._�)  #HandyControl.Controls.LoadingCircle    LoadingCircleLight#��[ � $��10q� � RowDefinitions �� $
��auto ��� $��* ��� $
��auto �.+��� $��0������ $��16(�$��DemiBold"�$��Фильтр��.���  � ColumnDefinitions �� $	��180 ��� �� �� $��30 � �� $��60 ��� .+�A� $��0��$��0,0,3,0q�   RadioButtonBaseStyle �� BasedOn �� 
TargetType �� Property �� Value��%O   '	�       7  �� 8   " 	�.���  � ��$
 Left=���  � ��$	 0,5q�.+�	� $��
Любой�� d� 	IsChecked �� *	SelectAll+	� $��Выполнен�� �� *SelectCompleted+	� $��Создан�� �� *SelectCreated+	� $��Отменен�� �� *SelectCanceled+)  #HandyControl.Controls.CheckComboBox  -     Name$ 
barbersCmb��$��1��$��5q�'	  !HandyControl.Controls.InfoElement 	  Placeholder$ Барбер��   ShowSelectAllButton$
 True��  CheckComboBoxExtend#��[ ���� *	Barbers+  -   $ 
clientsCmb��$��2��$��5q�$ Клиент��$
 True��#��[ ���� *	Clients+� $��2��$��3��.+��� $��23��$��30��$��0,6,0,0q�$��0q�$	��Top=�  RemoveGeometry'
  !HandyControl.Controls.IconElement 
  Geometry# [   ButtonDashedDanger#��[ ���� *ClearFilterCommand+��`�  `� 	Converter 9   3Barbershop.UI.Converters.SearchOrderParamsConverter  .1���  �� ElementName$ 
barbersCmb���� $ 
clientsCmb���� $��23��$��50��$��0,0,0,3q�$��0q�$��Bottom=�  SearchGeometry# [  
  Width$ 15Q�$��Bottom=�  ButtonSuccess#��[ ���� *FilterOrdersCommand+��`�    .1��� $ 
barbersCmb�� �� Path$ SelectedItems��� $ 
clientsCmb��$ SelectedItems�� $��1��$��3�� �� $	��180 ��� �� .+�A� $��Center=� A� Rows$ 1��.+�	� $
��Left=�$��Без даты�� �� *WithoutDateSelected+	� $
��Left=�$��Сегодня��#��[  �� *TodayFilterSelected+&   HandyControl.Controls.DatePicker  $��1��$��5,3,5,3q�$
 От�� 	  ShowClearButton$
 True��(  "System.Windows.Controls.DatePicker   SelectedDate �� *FromDateSelected+  $��2��$��5,3,5,3q�$
 До��$
 True�� �� *ToDateSelected+�� $��1��$��0,15,0,0q����� $��16(�$��DemiBold"�$��Заказы��.��(  "HandyControl.Controls.ScrollViewer  .���� ���� *Orders+ �� Mode$ OneWay=����� .R�9� $��0,0,0,10q� 	 MainContentBackgroundBrush#��� 	  9� 
IsExpanded$
 True������ $
��0,15q��� ��� *Key+$ OneWay=�.����  
 BorderBrush#��� 
 $��1,0,1,1q�$	 0,0,3,3��._��� $��0,3,0,0q����� ���� .R�� $	��0,5q�   TextBlockBaseStyle��%T   '��       7  �� 8   " ��.���  � ��$ Center=���  � ��$ Center=� �� $��50 ��� $	��220 ��� �� �� $	��300 ��� �� .+��� ���� *Id+$ OneWay=��� $��1��.+���  �� Orientation$ 
Horizontal=�.+��� $��28��  
KnifeImage#��[ �� ���� *Barber+$ OneWay=��� $ 
Horizontal=�.+��� $��28��  ArmchairImage#��[ �� ���� *Client+$ OneWay=��� $��2��$ 
Horizontal=�.+��� $��28��  
TimerImage#��[ �� ��   � Language$  ru���� *BeginDateTime+$ OneWay=�! �� StringFormat$! t���� �� $  ru���� *EndDateTime+$ OneWay=�$! t���� $��3��$ 
Horizontal=�.+��� $��28��  
MoneyImage#��[ �� ���� *
TotalPrice+$ OneWay=�
 9   3Barbershop.UI.Converters.DecimalToCurrencyConverter  �� $��4��$ 
Horizontal=�.+��� $��28��  ProductImage#��[ �� $	��100��$
��Wrap=����� *
Products+
 8   2Barbershop.UI.Converters.ProductsToStringConverter  $ OneWay=��� $��5������ *Status+$ OneWay=�
 9   3Barbershop.UI.Converters.EnumToDescriptionConverter  �� $��6��$��Center=�$ 
Horizontal=�{��� 
 7   1Barbershop.UI.Converters.EnableEditOrderConverter  .+��� $��30��# [   ButtonDashedDanger.Small#���  " � ToolTip$" Отменить������ $$ DataContext.CancelOrderCommand�# �� RelativeSource# �� $ �� AncestorType$ Page% �� Mode$% FindAncestor=����� *Id+{��� *Status+$ OneWay=�
 ;   5Barbershop.UI.Converters.OrderStatusToEnableConverter  �� $��30��$	��5,0q�  ConfigGeometry# [   ButtonDashedWarning.Small#���  $ " Редактировать������ $" DataContext.EditOrderCommand�# �� $ Page$% FindAncestor=����� *Id+{��� *Status+$ OneWay=�
   �� $��30��$��0,0,10,0q�  SuccessGeometry# [   ButtonDashedSuccess.Small#���  $" Выполнить������ $&  DataContext.CompleteOrderCommand�# �� $ Page$% FindAncestor=����� *Id+{��� *Status+$ OneWay=�
   � $��2��$��35��$��0,5,0,0q� �� $
��auto ��� �� $
��auto �.+��� $��Center=�$ 
Horizontal=�.+��� .���� $ 
Horizontal=�.+��� $"��Кол-во записей: ���� ���� *OrdersCount+$ OneWay=��� $��2��$	��150��$��Создать заказ��#��[ ���� *CreateOrderCommand+