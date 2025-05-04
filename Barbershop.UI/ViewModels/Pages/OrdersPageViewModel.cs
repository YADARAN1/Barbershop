using Barbershop.Contracts.Models;
using Barbershop.UI.Services;
using Barbershop.UI.ViewModels.Base;
using Barbershop.UI.ViewModels.Pages.Edit;
using Barbershop.UI.Views.Pages.Edit;
using DevExpress.Mvvm;
using HandyControl.Controls;
using Microsoft.Extensions.DependencyInjection;
using System.Collections.ObjectModel;
using System.IO;
using System.Windows;
using System.Windows.Input;
using Barbershop.Services.Services;
using OfficeOpenXml;
using OfficeOpenXml.Drawing.Chart;
using MessageBox = HandyControl.Controls.MessageBox;

namespace Barbershop.UI.ViewModels.Pages;

public sealed class OrdersPageViewModel : BaseViewModel
{
    private readonly OrderService _ordersService;
    private readonly ProductService _productService;
    private readonly IWindowDialogService _dialogService;

    private IReadOnlyList<OrderDto> _orders;

    public ICommand PrintPopularBarbersCommand { get; }
    public ICommand PrintPopularServicesCommand { get; }
    public ICommand PrintPopularProductsCommand { get; }

    public ObservableCollection<IGrouping<string, OrderDto>> Orders { get; private set; }
    public int OrdersCount { get; set; }

    public ObservableCollection<BarberDto> Barbers
    {
        get => GetValue<ObservableCollection<BarberDto>>(nameof(Barbers));
        set => SetValue(value, nameof(Barbers));
    }

    public ObservableCollection<ClientDto> Clients
    {
        get => GetValue<ObservableCollection<ClientDto>>(nameof(Clients));
        set => SetValue(value, nameof(Clients));
    }

    public bool WithoutDateSelected
    {
        get => GetValue<bool>(nameof(WithoutDateSelected));
        set => SetValue(value, () =>
        {
            if (value)
            {
                FromDateSelected = ToDateSelected = null;
            }
        }, nameof(WithoutDateSelected));
    }

    public bool TodayFilterSelected
    {
        get => GetValue<bool>(nameof(TodayFilterSelected));
        set => SetValue(value, () =>
        {
            if (value) FromDateSelected = ToDateSelected = null;
        }, nameof(TodayFilterSelected));
    }

    public DateTime? FromDateSelected
    {
        get => GetValue<DateTime?>(nameof(FromDateSelected));
        set => SetValue(value, ResetDateFilter, nameof(FromDateSelected));
    }

    public DateTime? ToDateSelected
    {
        get => GetValue<DateTime?>(nameof(ToDateSelected));
        set => SetValue(value, ResetDateFilter, nameof(ToDateSelected));
    }

    public bool SelectAll { get; set; } = true;
    public bool SelectCreated { get; set; }
    public bool SelectCompleted { get; set; }
    public bool SelectCanceled { get; set; }

    public ICommand SelectBarberCommand { get; }

    public ICommand CompleteOrderCommand { get; }
    public ICommand EditOrderCommand { get; }
    public ICommand CancelOrderCommand { get; }
    public ICommand CreateOrderCommand { get; }

    public ICommand ClearFilterCommand { get; }
    public ICommand FilterOrdersCommand { get; }

    public OrdersPageViewModel(
        OrderService ordersService,
        ProductService productService,
        IWindowDialogService dialogService)
    {
        ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
        
        _ordersService = ordersService ?? throw new ArgumentNullException(nameof(ordersService));
        _productService = productService ?? throw new ArgumentNullException(nameof(productService));
        _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));

        LoadViewDataCommand = new AsyncCommand(LoadView);

        CompleteOrderCommand = new AsyncCommand<object>(CompleteOrder);
        EditOrderCommand = new AsyncCommand<object>(EditOrder);
        CancelOrderCommand = new AsyncCommand<object>(CancelOrder);
        CreateOrderCommand = new AsyncCommand(CreateOrder);

        ClearFilterCommand = new AsyncCommand<object>(ClearFilter);
        FilterOrdersCommand = new AsyncCommand<object>(FilterOrders);

        PrintPopularBarbersCommand = new AsyncCommand(PrintPopularBarbersReport);
        PrintPopularServicesCommand = new AsyncCommand(PrintPopularServicesReport);
        PrintPopularProductsCommand = new AsyncCommand(PrintPopularProductsReport);

        WithoutDateSelected = true;
    }

    public async Task LoadView()
    {
        await Execute(async () =>
        {
            _orders = await _ordersService.GetAll();
            var groupedOrders = _orders
                .GroupBy(x => x.BeginDateTime.ToString("D"))
                .ToList();
            OrdersCount = _orders.Count;
            Orders = new ObservableCollection<IGrouping<string, OrderDto>>(groupedOrders);

            var barbers = new List<BarberDto>(_orders.Select(x => x.Barber))
                .DistinctBy(x => x.Id);
            Barbers = new ObservableCollection<BarberDto>(barbers);

            var clients = new List<ClientDto>(_orders.Select(x => x.Client))
                .DistinctBy(x => x.Id);
            Clients = new ObservableCollection<ClientDto>(clients);

            RaisePropertiesChanged();
        });
    }

    private async Task ClearFilter(object obj)
    {
        ((obj as object[])[0] as CheckComboBox).SelectedItems.Clear();
        ((obj as object[])[1] as CheckComboBox).SelectedItems.Clear();

        OrdersCount = _orders.Count;
        Orders = new ObservableCollection<IGrouping<string, OrderDto>>(_orders.GroupBy(x =>
            x.BeginDateTime.ToString("D")));
        SelectAll = true;

        var barbers = new List<BarberDto>(_orders.Select(x => x.Barber))
            .DistinctBy(x => x.Id);
        Barbers = new ObservableCollection<BarberDto>(barbers);

        var clients = new List<ClientDto>(_orders.Select(x => x.Client))
            .DistinctBy(x => x.Id);
        Clients = new ObservableCollection<ClientDto>(clients);

        FromDateSelected = ToDateSelected = null;
        WithoutDateSelected = true;

        RaisePropertiesChanged();
        RaisePropertiesChanged(nameof(Barbers), nameof(Clients));
    }

    private async Task FilterOrders(object arg = default!)
    {
        var orders = _orders.Select(x => x);

        if (arg != null)
        {
            var selectedBarbers = ((System.Collections.IList)(arg as object[])[0])
                .Cast<BarberDto>().Select(x => x.Id);
            var selectedClients = ((System.Collections.IList)(arg as object[])[1])
                .Cast<ClientDto>().Select(x => x.Id);

            if (selectedBarbers.Any())
                orders = orders.Where(x => selectedBarbers.Contains(x.Barber?.Id ?? -1));

            if (selectedClients.Any())
                orders = orders.Where(x => selectedClients.Contains(x.Client?.Id ?? -1));
        }

        if (SelectCanceled)
            orders = orders.Where(x => x.Status == OrderStatusDto.Canceled);
        if (SelectCreated)
            orders = orders.Where(x => x.Status == OrderStatusDto.Created);
        if (SelectCompleted)
            orders = orders.Where(x => x.Status == OrderStatusDto.Done);

        if (TodayFilterSelected)
        {
            orders = orders.Where(x => x.BeginDateTime.Date == DateTime.Now.Date);
        }
        else
        {
            if (!WithoutDateSelected)
            {
                if (FromDateSelected != null)
                    orders = orders.Where(x => x.BeginDateTime.Date >= FromDateSelected.Value.Date);
                else if (ToDateSelected != null)
                    orders = orders.Where(x => x.BeginDateTime.Date <= ToDateSelected.Value.Date);
            }
        }

        OrdersCount = orders.Count();
        Orders = new ObservableCollection<IGrouping<string, OrderDto>>(
            orders.GroupBy(x => x.BeginDateTime.ToString("D")));
        RaisePropertiesChanged();
    }

    private async Task CompleteOrder(object obj)
    {
        var orderId = (int)obj;

        await Execute(async () =>
        {
            await _ordersService.CompleteOrder(orderId);
            await LoadView();
            await FilterOrders();
        });
    }

    private async Task EditOrder(object obj)
    {
        var orderId = (int)obj;

        await Execute(async () =>
        {
            var order = await _ordersService.GetById(orderId);

            var vm = new EditOrderViewModel(order, _productService);

            if (_dialogService.ShowDialog(typeof(EditOrderPage), vm))
            {
                await _ordersService.UpdateProducts(order.Id, vm.SelectedProducts.Select(x => x.Id).ToList());

                await LoadView();
                await FilterOrders();
            }
        });
    }

    private async Task CancelOrder(object obj)
    {
        var orderId = (int)obj;

        await Execute(async () =>
        {
            await _ordersService.CancelOrder(orderId);
            await LoadView();
            await FilterOrders();
        });
    }

    private async Task CreateOrder()
    {
        await Execute(async () =>
        {
            var vm = Container.ServiceProvider.GetRequiredService<CreateOrderViewModel>();
            if (_dialogService.ShowDialog(vm))
            {
                await LoadView();
                await FilterOrders();
            }
        });
    }

    private void ResetDateFilter()
    {
        if (FromDateSelected is null && ToDateSelected is null)
            WithoutDateSelected = true;
        else
            TodayFilterSelected = WithoutDateSelected = false;

        RaisePropertyChanged(nameof(TodayFilterSelected));
    }

    private async Task PrintPopularBarbersReport()
    {
        var orders = await _ordersService.GetAll();
        var data = orders
            .GroupBy(o => o.Barber.ToString())
            .Select(g => new { Name = g.Key, Count = g.Count() })
            .OrderByDescending(x => x.Count)
            .ToList();

        var file = CreateChartReport(
            title: "Популярность парикмахеров",
            sheetName: "Парикмахеры",
            fileBase: "Популярные парикмахеры",
            categories: data.Select(x => x.Name).ToArray(),
            values: data.Select(x => (double)x.Count).ToArray(),
            header1: "Парикмахер",
            header2: "Визитов");

        MessageBox.Show(
            $"Отчёт «Популярность парикмахеров» успешно сохранён на рабочем столе:\n{file}",
            "Отчёт готов: Популярность парикмахеров",
            MessageBoxButton.OK,
            MessageBoxImage.Information);
    }

    private async Task PrintPopularServicesReport()
    {
        var orders = await _ordersService.GetAll();
        var data = orders
            .SelectMany(o => o.Services.Select(s => s.Name))
            .GroupBy(name => name)
            .Select(g => new { Item = g.Key, Count = g.Count() })
            .OrderByDescending(x => x.Count)
            .ToList();

        var file = CreateChartReport(
            title: "Популярность услуг",
            sheetName: "Услуги",
            fileBase: "Популярные услуги",
            categories: data.Select(x => x.Item).ToArray(),
            values: data.Select(x => (double)x.Count).ToArray(),
            header1: "Услуга",
            header2: "Заказов");

        MessageBox.Show(
            $"Отчёт «Популярность услуг» успешно сохранён на рабочем столе:\n{file}",
            "Отчёт готов: Популярность услуг",
            MessageBoxButton.OK,
            MessageBoxImage.Information);
    }

    private async Task PrintPopularProductsReport()
    {
        var orders = await _ordersService.GetAll();
        var data = orders
            .SelectMany(o => o.Products.Select(p => p.Name))
            .GroupBy(name => name)
            .Select(g => new { Item = g.Key, Count = g.Count() })
            .OrderByDescending(x => x.Count)
            .ToList();

        var file = CreateChartReport(
            title: "Популярность товаров",
            sheetName: "Товары",
            fileBase: "Популярные товары",
            categories: data.Select(x => x.Item).ToArray(),
            values: data.Select(x => (double)x.Count).ToArray(),
            header1: "Товар",
            header2: "Продано");

        MessageBox.Show(
            $"Отчёт «Популярность товаров» успешно сохранён на рабочем столе:\n{file}",
            "Отчёт готов: Популярность товаров",
            MessageBoxButton.OK,
            MessageBoxImage.Information);
    }

    /// <summary>
    /// Универсальный метод создания Excel-отчёта с одной столбчатой диаграммой.
    /// </summary>
    private string CreateChartReport(
        string title,
        string sheetName,
        string fileBase,
        string[] categories,
        double[] values,
        string header1,
        string header2)
    {
        // 1) Путь
        var desktop = Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory);
        var fileName = Path.Combine(
            desktop,
            $"{fileBase}_{DateTime.Now:yyyyMMdd_HHmm}.xlsx");

        // 2) Создаём книгу
        using var p = new ExcelPackage(new FileInfo(fileName));
        var ws = p.Workbook.Worksheets.Add(sheetName);

        // Заголовки
        ws.Cells[1, 1].Value = header1;
        ws.Cells[1, 2].Value = header2;

        // Данные
        for (int i = 0; i < categories.Length; i++)
        {
            ws.Cells[i + 2, 1].Value = categories[i];
            ws.Cells[i + 2, 2].Value = values[i];
        }

        // Немного автоформата
        ws.Cells[1, 1, categories.Length + 1, 2].AutoFitColumns();

        // 3) Диаграмма
        var chart = ws.Drawings.AddChart(title, eChartType.ColumnClustered) as ExcelBarChart;
        chart.Title.Text = title;
        chart.SetPosition(1, 0, 3, 0);
        chart.SetSize(600, 400);

        var serie = chart.Series.Add(
            ws.Cells[2, 2, categories.Length + 1, 2],
            ws.Cells[2, 1, categories.Length + 1, 1]);
        serie.Header = header2;

        p.Save();

        return fileName;
    }
}