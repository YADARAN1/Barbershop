   M S B A M L   `   `   `  ����H  DBarbershop.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null9!clr-namespace:Barbershop.UI.ViewsBarbershop.UI.Views  5      "    Barbershop.UI.Views.AuthView   5      Z VDevExpress.Mvvm.UI, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      5      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      S OHandyControl, Version=3.5.2.0, Culture=neutral, PublicKeyToken=45be8712787a1e5b0hc'https://handyorg.github.io/handycontrol  5      -local!clr-namespace:Barbershop.UI.Views  5      Dmc;http://schemas.openxmlformats.org/markup-compatibility/2006  5      $	��420��5
      $	��400��5         	IconImage  � Icon#  [  5       � 
ResizeMode$ NoResize=�5       � WindowStartupLocation$ CenterScreen=�5       � Title 5	      �� *Title+.��5      �  � RowDefinitions 5   
   �� 5      $
��auto �6   �� 5      .+�5   
   �� $��0��5      $��0,20,0,0q�5      $��Center=�5      $��Center=�5      $��Segoe UI Light)�5      $��48(�5      $��
Barbershop��5       J� Effect 5      3  -System.Windows.Media.Effects.DropShadowEffect  5         
BlurRadius$ 3Q�5          Opacity$	 0.4Q�5!         ShadowDepth$ 4Q�5"      5$      � 5&   
   $��1��6   $	��300��6    5'      �� 5(      $
��auto �6    �� 5)      $
��auto �6    .+�5,      '  !HandyControl.Controls.ButtonGroup  $��0��6   $��0,30,0,0q�6*   .@�5-      	� )  #HandyControl.Controls.BorderElement	   CornerRadius$	 	13,0,0,13��5.      $��3,0,0,1q�5/      $ ��Администратор��50      
 d� 	IsChecked
 51      �� *	IsAdmin+	� 52      $	 	0,13,13,0��53      $��0,0,3,1q�54      $��Барбер��55      56      �� 58      $��1��6   $��0,30,0,0q�6&   .+�59      #  HandyControl.Controls.TextBox  '  !HandyControl.Controls.InfoElement   Placeholder$ 
Логин��5:         ShowClearButton$
 True��5;      $��3,0,0,0q�5<      ��5=      �� *Login+ �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�'  !HandyControl.Controls.PasswordBox  5>      -   5          Name$ PswrdBox��5?      $��0,4,0,0q�5@      $ Пароль��5A      $
 True��5B      $��3,0,0,0q�5C         ShowEyeButton$
 True��5D      �� 5E      $��0,30,0,0q�5F      $��0q�5G      $��Stretch=�5H        DarkPrimaryBrush#��[ 5I      $��0q�5J      $��
Войти��5M      $��Corbel)�5N      $��17(�5O        
ButtonInfo#��[ 5P      ��5K      �� *LoginCommand+��5L      ��  �� ElementName$ PswrdBox��5P      5Q      5R      5T      5U      