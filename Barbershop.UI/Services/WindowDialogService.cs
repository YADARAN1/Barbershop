using Barbershop.UI.ViewModels.Base;
using Barbershop.UI.ViewModels.Pages.Edit;
using Barbershop.UI.Views.Base;
using Microsoft.Win32;
using System.IO;
using System.Windows.Controls;

namespace Barbershop.UI.Services;

/// <summary>
/// Класс для открытия вспомогательного окна с выбором "Да/Нет"
/// </summary>
internal sealed class WindowDialogService : IWindowDialogService
{
    public bool ShowDialog(Type controlType, BaseViewModel dataContext)
    {
        // Создать представление (View)
        var control = (ContentControl)Activator.CreateInstance(controlType, dataContext)!;

        // Заполнить заголовок и внутреннее содержимое окна с изменениями
        var editView = new EditView(dataContext.Title, control);
        var dialogResult = editView.ShowDialog();

        if (dialogResult.HasValue)
        {
            return editView.DialogResult!.Value;
        }

        return false;
    }

    public bool ShowDialog(CreateOrderViewModel dataContext)
    {
        // Создать представление (View)
        var control = new Views.Pages.Edit.CreateOrderPage(dataContext);

        // Заполнить заголовок и внутреннее содержимое окна с изменениями
        var editView = new EditView(control);
        var dialogResult = editView.ShowDialog();

        if (dialogResult.HasValue)
        {
            return editView.DialogResult!.Value;
        }

        return false;
    }

    public bool SelectImage(out byte[]? imageBytes)
    {
        var dlg = new OpenFileDialog
        {
            Title  = "Выбор изображения",
            Filter = "Изображения|*.jpg;*.jpeg;*.png"
        };

        if (dlg.ShowDialog() == true)
        {
            imageBytes = File.ReadAllBytes(dlg.FileName);
            return true;
        }

        imageBytes = null;
        return false;
    }
}
