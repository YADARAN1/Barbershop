   M S B A M L   `   `   `  ���� H  DBarbershop.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null9!clr-namespace:Barbershop.UI.ViewsBarbershop.UI.Views  "    Barbershop.UI.Views.AuthView   Z VDevExpress.Mvvm.UI, Version=23.2.0.0, Culture=neutral, PublicKeyToken=382ad28f6ae31f30W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35H 9http://schemas.microsoft.com/winfx/2006/xaml/presentation      R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     S OHandyControl, Version=3.5.2.0, Culture=neutral, PublicKeyToken=45be8712787a1e5b0hc'https://handyorg.github.io/handycontrol  -local!clr-namespace:Barbershop.UI.Views  Dmc;http://schemas.openxmlformats.org/markup-compatibility/2006  $	��420��$	��400��   	IconImage  � Icon#  [   � 
ResizeMode$ NoResize=� � WindowStartupLocation$ CenterScreen=� � Title �� *Title+.���  � RowDefinitions �� $
��auto ��� .+��� $��0��$��0,20,0,0q�$��Center=�$��Center=�$��Segoe UI Light)�$��48(�$��
Barbershop�� J� Effect 3  -System.Windows.Media.Effects.DropShadowEffect     
BlurRadius$ 3Q�   Opacity$	 0.4Q�   ShadowDepth$ 4Q�� $��1��$	��300�� �� $
��auto ��� $
��auto �.+�'  !HandyControl.Controls.ButtonGroup  $��0��$��0,30,0,0q�.@�	� )  #HandyControl.Controls.BorderElement	   CornerRadius$	 	13,0,0,13��$��3,0,0,1q�$ ��Администратор��
 d� 	IsChecked
 �� *	IsAdmin+	� $	 	0,13,13,0��$��0,0,3,1q�$��Барбер���� $��1��$��0,30,0,0q�.+�#  HandyControl.Controls.TextBox  '  !HandyControl.Controls.InfoElement   Placeholder$ 
Логин��   ShowClearButton$
 True��$��3,0,0,0q����� *Login+ �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�'  !HandyControl.Controls.PasswordBox  -     Name$ PswrdBox��$��0,4,0,0q�$ Пароль��$
 True��$��3,0,0,0q�   ShowEyeButton$
 True���� $��0,30,0,0q�$��0q�$��Stretch=�
���2͚�$��0q�$��
Войти��$��Corbel)�$��17(�  
ButtonInfo#��[ ���� *LoginCommand+����  �� ElementName$ PswrdBox��