   M S B A M L   `   `   `  ����H  DBarbershop.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullC&clr-namespace:Barbershop.UI.ConvertersBarbershop.UI.Converters  5      E'clr-namespace:Barbershop.UI.Views.PagesBarbershop.UI.Views.Pages  5	      O,clr-namespace:Barbershop.UI.ViewModels.PagesBarbershop.UI.ViewModels.Pages  5      *    $Barbershop.UI.Views.Pages.AdminsPage   5      Z VDevExpress.Mvvm.UI, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      ;converts&clr-namespace:Barbershop.UI.Converters     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      W SDevExpress.Mvvm, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30Adxmvvm2http://schemas.devexpress.com/winfx/2008/xaml/mvvm   5      S OHandyControl, Version=3.5.2.0, Culture=neutral, PublicKeyToken=45be8712787a1e5b0hc'https://handyorg.github.io/handycontrol  5      3local'clr-namespace:Barbershop.UI.Views.Pages  5	      Dmc;http://schemas.openxmlformats.org/markup-compatibility/2006  5
      5vm,clr-namespace:Barbershop.UI.ViewModels.Pages  5        N� Title$  
AdminsPage��5      ,  &HandyControl.Interactivity.Interaction   Triggers 5      -  'HandyControl.Interactivity.EventTrigger  5   
      	EventName$ Loaded��6   ,  &HandyControl.Interactivity.TriggerBase   Actions. 5      4  .HandyControl.Interactivity.InvokeCommandAction     Command 6%   �� *LoadViewDataCommand+5       � 	Resources 5      2  ,DevExpress.Mvvm.UI.NumericToBooleanConverter   NumericToBooleanConverter��%   &	          5   
   6+   5      .��5      � .+�5   
   ��  K� ZIndex$ 10��5      ���	#33000000 �� CornerRadius$ 10��5"      y�5#      �� *IsUploading+  Boolean2VisibilityConverter �� 	Converter# [ ._�5$      )  #HandyControl.Controls.LoadingCircle    LoadingCircleLight#��[ 6   5%      � 5'   
   $��10q�6   	 � RowDefinitions	 5(      �� 5)      $
��auto �6    �� 5*      $��* �6    �� 5+      $
��auto �6    .+�5.      %  HandyControl.Controls.SearchBar  $��0��5/      '  !HandyControl.Controls.InfoElement
   Placeholder$N
 HЛогин / ФИО / Дата рождения / Email / Телефон��50      (	  "HandyControl.Controls.TitleElement 	  TitlePlacement$
 Left=�51        SearchBarExtend#��[ 52      ��53      �� *
SearchText+ �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�'
  !HandyControl.Controls.SimplePanel
  55      $��1��6   .+�56      &   System.Windows.Controls.DataGrid  -   5          Name$ 	ItemsGrid��57      $��1��58      *  $HandyControl.Controls.DataGridAttach   ShowRowNumber$
 True��59         AutoGenerateColumns$ False��5:         RowHeaderWidth$ 60Q�5<      ��5;      �� *	ItemsView+$ OneWay=� �� SelectedItem 5=      �� *SelectedItem+$ OneWayToSource=� 5>       �� 
TargetType �� Property �� Value��%U   '��       �� 5?      " ��6    .�5@      ��  � ��$ Right=�6D   5A      5B         Columns 5D      0  *System.Windows.Controls.DataGridTextColumn  5E      ,  &System.Windows.Controls.DataGridColumn   MinWidth$	 150Q�5F         Header$ 
Логин��5H         
IsReadOnly$
 True��5I      1  +System.Windows.Controls.DataGridBoundColumn   Binding 5G      �� *
Username+5I      4  .System.Windows.Controls.DataGridTemplateColumn  5J         Width5  /System.Windows.Controls.DataGridLengthConverter$ * 5K      $ ФИО��5L      $
 True��5M         CellTemplate 5N      �� 5O   "   .R�5P   &   �� �� 5Q   *   �6.   �� *
LastName+ �� 5R   *   $� ��6.   �� 6:   �6>   �� *	FirstName+ �� 5S   *   $� ��6.   �� 6:   �6>   �� *	Surname+5T   '   5U   #   5W        5X      $	 120 5Y      $ Дата рождения��5[      $
 True��5\       5Z      �� *
Birthday+ �� StringFormat$ 
dd.MM.yyyy��5\        5]      $	 180 5^      $ Email��5`      $
 True��5a       5_      �� *Email+5a        5b      $	 120 5c      $ Телефон��5e      $
 True��5f       5d      �� *PhoneNumber+5f      5h      5j      � 5l      $��2��5m      $��35��5n      $��0,5,0,0q�5o       � ColumnDefinitions 5p      �� 5q      $
��auto �6'   �� 5r      �� 5s      $
��auto �6'   .+�5u      �� $��Center=�6    �� Orientation$ 
Horizontal=�68   .+�5v      �� .��5w      �� $ 
Horizontal=�6%   .+�5x      �� $"��Кол-во записей: ��6(   �� 5y      ��6(   �� *Items.Count+  �� ElementName$  	ItemsGrid��5z      5{      5|      �� 5~      $��2��5      $��Right=�5�      $ 
Horizontal=�5�      .+�5�      �� )  #HandyControl.Controls.BorderElement!   CornerRadius$! 8,0,0,8��5�      $��Удалить��5�        ButtonDanger#��[ 5�      ��5�      �� *RemoveItemCommand+��5�      �� *SelectedItems+$  	ItemsGrid��{�5�      �� *SelectedItems.Count+# [  $  	ItemsGrid��5�      d� 5�      $! 0��5�      $ ��Редактировать��5�        ToggleButtonWarning#��[ 5�      ��5�      �� *EditItemCommand+��5�      �� *SelectedItems+$  	ItemsGrid��5�      d� 5�      $! 0,8,8,0��5�      $��Добавить��5�        ToggleButtonSuccess#��[ 5�      ��5�      �� *CreateItemCommand+5�      5�      5�      5�      5�      5�      