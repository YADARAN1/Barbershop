   M S B A M L   `   `   `  ���� H  DBarbershop.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullC&clr-namespace:Barbershop.UI.ConvertersBarbershop.UI.Converters  Y1clr-namespace:Barbershop.UI.ViewModels.Pages.Edit#Barbershop.UI.ViewModels.Pages.Edit  O,clr-namespace:Barbershop.UI.Views.Pages.EditBarbershop.UI.Views.Pages.Edit  O KBarbershop.Contracts, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullgGclr-namespace:Barbershop.Contracts.Models;assembly=Barbershop.ContractsBarbershop.Contracts.Models 2    ,Barbershop.UI.Views.Pages.Edit.EditOrderPage   Z VDevExpress.Mvvm.UI, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     =
converters&clr-namespace:Barbershop.UI.Converters     @d2http://schemas.microsoft.com/expression/blend/2008     Bedit1clr-namespace:Barbershop.UI.ViewModels.Pages.Edit     S OHandyControl, Version=3.5.2.0, Culture=neutral, PublicKeyToken=45be8712787a1e5b0hc'https://handyorg.github.io/handycontrol  8local,clr-namespace:Barbershop.UI.Views.Pages.Edit  Dmc;http://schemas.openxmlformats.org/markup-compatibility/2006  TmodelsGclr-namespace:Barbershop.Contracts.Models;assembly=Barbershop.Contracts  $	��900��$	��600��.��� ,  &HandyControl.Interactivity.Interaction    Triggers  -  'HandyControl.Interactivity.EventTrigger     	EventName$ Loaded��,  &HandyControl.Interactivity.TriggerBase   Actions. 4  .HandyControl.Interactivity.InvokeCommandAction     Command �� *LoadViewDataCommand+ � 	Resources    ServiceDataTemplate �� DataType1  +Barbershop.Contracts.Models.OrderServiceDto � RowDefinitions �� Mode � ColumnDefinitions,  &HandyControl.Controls.SimpleStackPanel	   Orientation  
TimerImage
 �� 	Converter7   1Barbershop.UI.Converters.IntToTimeStringConverter  
MoneyImage9   3Barbershop.UI.Converters.DecimalToCurrencyConverter��%�  &	        7  7  �� "  .R��  �� $��30���� $��30��.+��� $��0��$��2��$��Center=�$��14(����� *Name+$ OneWay=�� $��1�� �� $	��100 ��� .+�  $��0��$
��Left=�$	 
Horizontal=�.+��� $��30��$��10,0,0,0q�8��  �� $��Center=����� *MinutesDuration+
     $��1��$
��Left=�$	 
Horizontal=�.+��� $��30��$��10,0,0,0q�8�� �� $��Center=����� *Cost+
    �� ��  �� �� �� $��40 �.+�A� $��0,5,5,0q� A� Columns$ 1�� A� Rows$ 2��.+��� $��Клиент��.���� .+��� $��16(����� *Item.Client+$ OneWay=��� $��0,10,0,0q����� *Item.Client.Birthday+$ OneWay=� �� StringFormat$ 
dd.MM.yyyy���� ���� *Item.Barber.SkillLevel+
 9	   3Barbershop.UI.Converters.EnumToDescriptionConverter	  .���� $��16(����� *Item.Barber+$ OneWay=��� $��1��$��5,5,0,0q�$%��Выбранные услуги��.���� #��[  ���� *Item.Services+�� $��1��$��2��$
��0,10q�$"��Товары в заказе��.���  �� �� $��60 ��� .+��� $��0�� �� SelectionMode$ Single=����� *ProductsToSelect+ �� SelectedItem �� *ProductToSelect+    $ MouseDoubleClick��. /
  )HandyControl.Interactivity.EventToCommand
   
  Command �� *AddProductCommand+�� $��2��$ Single=����� *SelectedProducts+ �� *SelectedProduct+    $ MouseDoubleClick��. 
   �� *RemoveProductCommand+�� $��1��$��Center=�.+���   LeftGeometry'  !HandyControl.Controls.IconElement   Geometry# [ ���� *RemoveProductCommand+�� $��0,10,0,0q�  RightGeometry# [ ���� *AddProductCommand+A� $��2��$��2��$ 3��$ 1��.+��� $��Center=�$��Center=� �� Orientation$ 
Horizontal=�.+��� $��30��#��[ �� $��Center=�$��16(�  	BaseStyle#��[ ���� *Item.TotalMinutes+
   �� $��Center=�$��Center=�$ 
Horizontal=�.+��� $��30��#��[ �� $��Center=�$��16(�#��[  ^� InitialShowDelay$ 0������ *	TotalCost+
    � ToolTip �� $	��180��.+�#  HandyControl.Controls.TextBox  (  "HandyControl.Controls.TitleElement   Title$ Услуги:��   TitlePlacement$
 Left=�$��0q�$��16(����� *Item.TotalServicesPrice+$ OneWay=�
     $ Товары:��$
 Left=�$��0q�$��16(����� *TotalProductsCost+$ OneWay=�
   �� $��Center=�$��Center=�$ 
Horizontal=�.+��� $��30��  	DateImage#��[ �� $��Center=�$��16(�#��[ .���� ���� *Item.BeginDateTime+$ dd.MM.yyyy HH:mm��