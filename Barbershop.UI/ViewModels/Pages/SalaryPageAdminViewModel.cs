using Barbershop.Contracts.Models;
using Barbershop.UI.ViewModels.Base;
using DevExpress.Mvvm;
using System.Collections.ObjectModel;
using System.IO;
using System.Windows;
using System.Windows.Input;
using Barbershop.Services.Services;
using ClosedXML.Excel;
using OfficeOpenXml;
using OfficeOpenXml.Drawing.Chart;

namespace Barbershop.UI.ViewModels.Pages;

public sealed class SalaryPageAdminViewModel : BaseViewModel
{
    private readonly OrderService _orderService;

    private IReadOnlyList<OrderDto> _orders;

    public ObservableCollection<OrderDto> Orders
    {
        get => GetValue<ObservableCollection<OrderDto>>();
        set => SetValue(value, () => RaisePropertiesChanged(nameof(TotalCost), nameof(TotalMinutes)));
    }

    public decimal TotalCost => Orders?.Sum(x => x.PureCost) ?? 0;
    public int TotalMinutes => Orders?.Sum(x => x.TotalMinutes) ?? 0;

    public bool WithoutDateSelected
    {
        get => GetValue<bool>();
        set => SetValue(value, ResetDateInterval);
    }

    public bool TodayFilterSelected
    {
        get => GetValue<bool>();
        set => SetValue(value, ResetDateInterval);
    }

    public bool Last30Days
    {
        get => GetValue<bool>();
        set => SetValue(value, ResetDateInterval);
    }

    public bool CurrentMonth
    {
        get => GetValue<bool>();
        set => SetValue(value, ResetDateInterval);
    }

    public DateTime? FromDateSelected
    {
        get => GetValue<DateTime?>();
        set => SetValue(value, ResetHardcodeDateRange);
    }

    public DateTime? ToDateSelected
    {
        get => GetValue<DateTime?>();
        set => SetValue(value, ResetHardcodeDateRange);
    }

    public ICommand ClearFilterCommand { get; }
    public ICommand FilterOrdersCommand { get; }

    public ICommand ExportServicesCostCommand { get; }

    public SalaryPageAdminViewModel(OrderService orderService)
    {
        ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

        _orderService = orderService ?? throw new ArgumentNullException(nameof(orderService));

        LoadViewDataCommand = new AsyncCommand(LoadView);

        ClearFilterCommand = new DelegateCommand(ClearFilter);
        FilterOrdersCommand = new DelegateCommand(FilterOrders);
        ExportServicesCostCommand = new AsyncCommand(ExportServicesCostReport);

        WithoutDateSelected = true;
    }

    private async Task ExportServicesCostReport()
    {
        var list = Orders.ToList();
        var desktop = Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory);
        var fileName = $"Прибыль_Барбершопа_{DateTime.Now:yyyyMMdd_HHmm}.xlsx";
        var filePath = Path.Combine(desktop, fileName);

        using var package = new ExcelPackage();

        var ws = package.Workbook.Worksheets.Add("Прибыль");

        // Заголовки
        ws.Cells[1, 1].Value = "Дата заказа";
        ws.Cells[1, 2].Value = "Прибыль бизнеса, ₽";

        for (int i = 0; i < list.Count; i++)
        {
            var order = list[i];
            ws.Cells[i + 2, 1].Value = order.BeginDateTime;
            ws.Cells[i + 2, 1].Style.Numberformat.Format = "dd.MM.yyyy HH:mm";

            ws.Cells[i + 2, 2].Value = order.Profit;
            ws.Cells[i + 2, 2].Style.Numberformat.Format = "#,##0.00 ₽";
        }

        // Диаграмма
        var chart = ws.Drawings.AddChart("chart", eChartType.ColumnClustered) as ExcelBarChart;
        if (chart != null)
        {
            chart.Title.Text = "Прибыль по заказам";
            chart.SetPosition(1, 0, 3, 0);
            chart.SetSize(800, 400);
            var dataRange = ws.Cells[2, 2, list.Count + 1, 2];
            var xRange = ws.Cells[2, 1, list.Count + 1, 1];
            chart.Series.Add(dataRange, xRange).Header = "Прибыль";
        }

        // Автоширина
        ws.Cells[ws.Dimension.Address].AutoFitColumns();

        // Сохраняем
        await using var fs = new FileStream(filePath, FileMode.Create);
        await package.SaveAsAsync(fs);

        MessageBox.Show(
            $"Отчёт с графиком сохранён на рабочем столе:\n{filePath}",
            "Готово",
            MessageBoxButton.OK,
            MessageBoxImage.Information
        );
    }

    public async Task LoadView()
    {
        await Execute(async () =>
        {
            _orders = await _orderService.GetAll();
            _orders = _orders
                .Where(x => x.Status == OrderStatusDto.Done)
                .OrderByDescending(x => x.BeginDateTime)
                .ToList();

            Orders = new ObservableCollection<OrderDto>(_orders);
            RaisePropertiesChanged(nameof(TotalCost), nameof(TotalMinutes));
        });
    }

    private void ResetHardcodeDateRange()
    {
        WithoutDateSelected = TodayFilterSelected = false;
        Last30Days = CurrentMonth = false;
    }

    private void ResetDateInterval(bool isTrue)
    {
        if (isTrue)
            FromDateSelected = ToDateSelected = null;
    }

    private void FilterOrders()
    {
        var orders = _orders.Select(x => x);
        var currentDate = DateTime.Now.Date;

        if (TodayFilterSelected)
            orders = orders.Where(x => x.BeginDateTime.Date == currentDate);

        if (Last30Days)
            orders = orders.Where(x =>
                x.BeginDateTime.Date >= currentDate.AddDays(-30) && x.BeginDateTime.Date <= currentDate);

        if (CurrentMonth)
        {
            orders = orders.Where(x =>
                x.BeginDateTime.Year == currentDate.Year && x.BeginDateTime.Month == currentDate.Month);
        }

        if (FromDateSelected != null && ToDateSelected != null)
        {
            orders = orders.Where(x =>
                x.BeginDateTime.Date >= FromDateSelected.Value.Date &&
                x.BeginDateTime.Date <= ToDateSelected.Value.Date);
        }

        if (FromDateSelected != null)
        {
            orders = orders.Where(x => x.BeginDateTime.Date >= FromDateSelected.Value.Date);
        }

        if (ToDateSelected != null)
        {
            orders = orders.Where(x => x.BeginDateTime.Date <= ToDateSelected.Value.Date);
        }

        Orders = new ObservableCollection<OrderDto>(orders);
        RaisePropertiesChanged(nameof(TotalCost), nameof(TotalMinutes));
    }

    private void ClearFilter()
    {
        WithoutDateSelected = true;

        TodayFilterSelected = Last30Days = CurrentMonth = false;

        Orders = new ObservableCollection<OrderDto>(_orders);
        RaisePropertiesChanged(nameof(TotalCost), nameof(TotalMinutes));
    }
}