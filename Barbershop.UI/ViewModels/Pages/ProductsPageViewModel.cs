using System.IO;
using System.Windows.Input;
using AutoMapper;
using Barbershop.Contracts.Commands;
using Barbershop.Contracts.Models;
using Barbershop.Services.Services;
using Barbershop.UI.Services;
using Barbershop.UI.ViewModels.Base;
using Barbershop.UI.ViewModels.Pages.Edit;
using Barbershop.UI.Views.Pages.Edit;
using ClosedXML.Excel;
using DevExpress.Mvvm;
using Microsoft.Win32;

namespace Barbershop.UI.ViewModels.Pages;

public class ProductsPageViewModel : BaseItemsViewModel<ProductDto>
{
    private readonly ProductService _productService;
    private readonly IMapper _mapper;
    private readonly IWindowDialogService _dialogService;

    // Новая команда для импорта из Excel
    public ICommand ImportFromExcelCommand { get; }

    public ProductsPageViewModel(
        ProductService productService,
        IMapper mapper,
        IWindowDialogService dialogService)
    {
        _productService = productService ?? throw new ArgumentNullException(nameof(productService));
        _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));

        // Существующие команды
        CreateItemCommand = new AsyncCommand(CreateItem);
        EditItemCommand = new AsyncCommand(EditItem, () => SelectedItem != null);
        RemoveItemCommand = new AsyncCommand(RemoveItem, () => SelectedItem != null);

        // Инициализируем команду импорта
        ImportFromExcelCommand = new AsyncCommand(ImportFromExcel);
    }

    private async Task ImportFromExcel()
    {
        var dlg = new OpenFileDialog
        {
            Filter = "Excel Files|*.xlsx;*.xls",
            Title = "Выберите файл Excel с данными о товарах"
        };

        if (dlg.ShowDialog() != true)
            return;

        string extension = Path.GetExtension(dlg.FileName);
        string tempPath = Path.Combine(Path.GetTempPath(), Guid.NewGuid().ToString() + extension);
        File.Copy(dlg.FileName, tempPath, true); // копируем файл во временную папку с оригинальным расширением

        using (var workbook = new XLWorkbook(tempPath))
        {
            var worksheet = workbook.Worksheets.First();
            var rows = worksheet.RangeUsed().RowsUsed().Skip(1); // Пропускаем заголовок

            foreach (var row in rows)
            {
                // Ожидается: столбец 1 = Название, 2 = Стоимость
                var name = row.Cell(1).GetValue<string>();
                var cost = row.Cell(2).GetValue<decimal>();

                var command = new UpsertProductCommand
                {
                    Name = name,
                    Cost = cost
                };

                await _productService.Create(command);
            }
        }

        // Удаляем временный файл после использования
        File.Delete(tempPath);

        // Обновляем список
        await LoadItems();
    }

    public override async Task CreateItem()
    {
        var vm = new EditProductViewModel();

        if (_dialogService.ShowDialog(typeof(EditProductPage), vm))
        {
            var command = _mapper.Map<UpsertProductCommand>(vm.Item);
            await _productService.Create(command);
            await LoadItems();
        }
    }

    public override async Task EditItem()
    {
        var currentProduct = await _productService.GetById(SelectedItem.Id);
        var vm = new EditProductViewModel(currentProduct);

        if (_dialogService.ShowDialog(typeof(EditProductPage), vm))
        {
            var command = _mapper.Map<UpsertProductCommand>(vm.Item);
            await _productService.Update(command);
            await LoadItems();
        }
    }

    public override async Task RemoveItem()
    {
        await _productService.RemoveById(SelectedItem.Id);
        await LoadItems();
    }

    public override Task<IReadOnlyList<ProductDto>> GetItems()
        => _productService.GetAll();

    public override IReadOnlyList<string> GetItemSearchProperties(ProductDto item)
        => new List<string>
        {
            item.Name,
            item.Cost.ToString()
        };
}