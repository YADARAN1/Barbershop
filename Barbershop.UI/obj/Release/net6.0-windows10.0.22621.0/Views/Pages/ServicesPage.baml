   M S B A M L   `   `   `  ���� H  DBarbershop.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullC&clr-namespace:Barbershop.UI.ConvertersBarbershop.UI.Converters  E'clr-namespace:Barbershop.UI.Views.PagesBarbershop.UI.Views.Pages  O KBarbershop.Contracts, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullgGclr-namespace:Barbershop.Contracts.Models;assembly=Barbershop.ContractsBarbershop.Contracts.Models R Nnetstandard, Version=2.1.0.0, Culture=neutral, PublicKeyToken=cc7b13ffcd2ddd514)clr-namespace:System;assembly=netstandardSystem O,clr-namespace:Barbershop.UI.ViewModels.PagesBarbershop.UI.ViewModels.Pages  ,    &Barbershop.UI.Views.Pages.ServicesPage   Z VDevExpress.Mvvm.UI, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     =
converters&clr-namespace:Barbershop.UI.Converters     @d2http://schemas.microsoft.com/expression/blend/2008     W	 SDevExpress.Mvvm, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30Adxmvvm2http://schemas.devexpress.com/winfx/2008/xaml/mvvm 	  S
 OHandyControl, Version=3.5.2.0, Culture=neutral, PublicKeyToken=45be8712787a1e5b0hc'https://handyorg.github.io/handycontrol 
 3local'clr-namespace:Barbershop.UI.Views.Pages 
 Dmc;http://schemas.openxmlformats.org/markup-compatibility/2006 
 TmodelsGclr-namespace:Barbershop.Contracts.Models;assembly=Barbershop.Contracts 
 6system)clr-namespace:System;assembly=netstandard 
 5vm,clr-namespace:Barbershop.UI.ViewModels.Pages 
   N� Title$  ProductsPage�� � 	Resources 2  ,DevExpress.Mvvm.UI.NumericToBooleanConverter   NumericToBooleanConverter��%   &	          , 
 &HandyControl.Interactivity.Interaction   Triggers - 
 'HandyControl.Interactivity.EventTrigger     	EventName$ Loaded��, 
 &HandyControl.Interactivity.TriggerBase   Actions. 4 
 .HandyControl.Interactivity.InvokeCommandAction     Command �� *LoadViewDataCommand+.��� .+���  K� ZIndex$ 10�����	#33000000 �� CornerRadius$ 10��y��� *IsUploading+  Boolean2VisibilityConverter �� 	Converter# [ ._�) 
 #HandyControl.Controls.LoadingCircle    LoadingCircleLight#��[ � $��10q�	 � RowDefinitions	 �� $
��auto ��� $��* ��� $
��auto �.+�% 
 HandyControl.Controls.SearchBar  $��0��' 
 !HandyControl.Controls.InfoElement
   Placeholder$+
 %Название / Стоимость��(	 
 "HandyControl.Controls.TitleElement 	  TitlePlacement$
 Left=�  SearchBarExtend#��[ ���� *
SearchText+ �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�(
 
 "HandyControl.Controls.ScrollViewer
  $��1��$��0,5,0,0q�.��' 
 !HandyControl.Controls.SimplePanel  .+��� -    ��Name$ itemsControl������ *	ItemsView+����  �� DataType,  &Barbershop.Contracts.Models.ServiceDto"  .R�9� $��48��$	��0,5q�  MainContentBackgroundBrush#���   9� 
IsExpanded$ False������ .R�� ����  �� Path$ HorizontalAlignment� �� RelativeSource �� *FindAncestor+ �� AncestorType" ��$ OneWayToSource=�.+��� $��16(�$��DemiBold"����� $ DataContext.Name� ��  �� Mode$ FindAncestor=�" 9��� $��20��$��0,0,40,0q�$��0q�$��Right=�  RemoveGeometry' 
 !HandyControl.Controls.IconElement   Geometry# [    Height$ 10Q�   Width$ 10Q�$��24(�  ButtonDashedDanger.Small#��[ ���� $# DataContext.RemoveItemCommand� �� ElementName$ itemsControl������ $ DataContext.Id� �� $ FindAncestor=�" 9��� $��20��$��0,0,10,0q�$��0q�$��Right=�  ConfigGeometry# [ $ 13Q�$ 13Q�  ButtonDashedWarning.Small#��[ ���� $! DataContext.EditItemCommand�$ itemsControl������ $ DataContext.Id� �� $ FindAncestor=�" 9�.���� $��1�� 	 BorderBrush#��� 	 $��1,0,1,1q�$ 0,0,3,3��._�� $��0,3,0,5q� � ColumnDefinitions �� �� �� .+��� $��0��y��� *JuniorSkill+ 
 Object2VisibilityConverter# [
 .+��� $��0,3,0,0q�$��Center=�$'��!Начинающий мастер��A�  A� Columns$ 2��.+��� $��0,0,5,0q�$��Right=� �� Orientation$ 
Horizontal=�.+��� $��32��$��32��  
TimerImage#��[ �� $��Center=����� *JuniorSkill.MinutesDuration+ 7   1Barbershop.UI.Converters.IntToTimeStringConverter  �� $��5,0,0,0q�$
��Left=�$ 
Horizontal=�.+��� $��32��$��32��  
MoneyImage#��[ �� $��Center=����� *JuniorSkill.Cost+ 9   3Barbershop.UI.Converters.DecimalToCurrencyConverter  �� $��1��y��� *MiddleSkill+# [
 .+��� $��0,3,0,0q�$��Center=�$��Мастер��A� $ 2��.+��� $��0,0,5,0q�$��Right=�$ 
Horizontal=�.+��� $��32��$��32��#��[ �� $��Center=����� *MiddleSkill.MinutesDuration+   �� $��5,0,0,0q�$
��Left=�$ 
Horizontal=�.+��� $��32��$��32��#��[ �� $��Center=����� *MiddleSkill.Cost+   �� $��2��y��� *SeniorSkill+# [
 .+��� $��0,3,0,0q�$��Center=�$!��Старший мастер��A� $ 2��.+��� $��0,0,5,0q�$��Right=�$ 
Horizontal=�.+��� $��32��$��32��#��[ �� $��Center=����� *SeniorSkill.MinutesDuration+   �� $��5,0,0,0q�$
��Left=�$ 
Horizontal=�.+��� $��32��$��32��#��[ �� $��Center=����� *SeniorSkill.Cost+   � $��2��$��35��$��0,5,0,0q� �� $
��auto ��� �� $
��auto �.+��� $��Center=�$ 
Horizontal=�.+��� .���� $ 
Horizontal=�.+��� $"��Кол-во записей: ���� ���� *Items.Count+$ itemsControl���� $��2��$��Right=�$ 
Horizontal=�.+�d� ) 
 #HandyControl.Controls.BorderElement   CornerRadius$ 8��$��Добавить��  ToggleButtonSuccess#��[ ���� *CreateItemCommand+