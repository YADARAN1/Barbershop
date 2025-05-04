using System.Globalization;
using System.IO;
using System.Windows;
using System.Windows.Input;
using AutoMapper;
using Barbershop.Contracts.Commands;
using Barbershop.Contracts.Models;
using Barbershop.Services.Services;
using Barbershop.UI.Services;
using Barbershop.UI.ViewModels.Base;
using Barbershop.UI.ViewModels.Pages.Edit;
using Barbershop.UI.Views.Pages.Edit;
using DevExpress.Mvvm;
using Xceed.Document.NET;
using Xceed.Words.NET;

namespace Barbershop.UI.ViewModels.Pages;

public sealed class ServicesPageViewModel : BaseItemsViewModel<ServiceDto>
{
    private readonly OfferService _offerService;
    private readonly IMapper _mapper;
    private readonly IWindowDialogService _dialogService;
    public ICommand PrintPriceListCommand { get; }

    public ServicesPageViewModel(OfferService offerService, IMapper mapper, IWindowDialogService dialogService)
    {
        _offerService = offerService ?? throw new ArgumentNullException(nameof(offerService));
        _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));

        EditItemCommand = new AsyncCommand<object>(EditItem);
        RemoveItemCommand = new AsyncCommand<object>(RemoveItem);
        PrintPriceListCommand = new AsyncCommand(PrintPriceList);
    }

    private async Task PrintPriceList()
    {
        // Получаем все услуги
        var services = await _offerService.GetAll();

        // Путь: Рабочий стол\Прайс-лист.docx
        var desktop = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
        var filePath = Path.Combine(desktop, "Прайс-лист.docx");

        // Создаём (или перезаписываем) документ
        using (var doc = DocX.Create(filePath))
        {
            // Заголовок
            doc.InsertParagraph("Прайс-лист")
                .FontSize(20)
                .Bold()
                .Alignment = Alignment.center;

            // Таблица: строки = services.Count + 1 (заголовок), столбцы = 5
            var table = doc.AddTable(services.Count + 1, 5);
            table.Design = TableDesign.LightGridAccent1;

            // Заголовки столбцов
            table.Rows[0].Cells[0].Paragraphs[0].Append("Услуга");
            table.Rows[0].Cells[1].Paragraphs[0].Append("Длительность");
            table.Rows[0].Cells[2].Paragraphs[0].Append("Нач. мастер");
            table.Rows[0].Cells[3].Paragraphs[0].Append("Мастер");
            table.Rows[0].Cells[4].Paragraphs[0].Append("Ст. мастер");

            // Заполняем строки
            for (int i = 0; i < services.Count; i++)
            {
                var s = services[i];
                var r = table.Rows[i + 1];

                r.Cells[0].Paragraphs[0].Append(s.Name);
                r.Cells[1].Paragraphs[0].Append($"{s.JuniorSkill.MinutesDuration} мин");
                r.Cells[2].Paragraphs[0].Append($"{s.JuniorSkill.Cost:C2}");
                r.Cells[3].Paragraphs[0].Append($"{s.MiddleSkill.Cost:C2}");
                r.Cells[4].Paragraphs[0].Append($"{s.SeniorSkill.Cost:C2}");
            }

            doc.InsertTable(table);
            doc.Save();
        }

        // Показываем диалог
        MessageBox.Show(
            $"Прайс-лист сохранён на рабочем столе:\n{filePath}",
            "Прайс-лист готов",
            MessageBoxButton.OK,
            MessageBoxImage.Information);
    }

    public override async Task CreateItem()
    {
        var vm = new EditServiceViewModel();

        if (_dialogService.ShowDialog(typeof(EditServicePage), vm))
        {
            var command = _mapper.Map<UpsertServiceCommand>(vm.Item);
            await _offerService.Create(command);
            await LoadItems();
        }
    }

    public override Task<IReadOnlyList<ServiceDto>> GetItems()
        => _offerService.GetAll();

    public override IReadOnlyList<string> GetItemSearchProperties(ServiceDto service)
    {
        return new List<string>
        {
            service.Name,
            service.JuniorSkill?.Cost.ToString(CultureInfo.InvariantCulture)!,
            service.MiddleSkill?.Cost.ToString(CultureInfo.InvariantCulture)!,
            service.SeniorSkill?.Cost.ToString(CultureInfo.InvariantCulture)!,
        };
    }

    public async Task EditItem(object obj)
    {
        await Execute(async () =>
        {
            if (obj is int serviceId)
            {
                var tempService = await _offerService.GetById(serviceId);

                var currentService = await _offerService.GetById(serviceId);
                var vm = new EditServiceViewModel(currentService);

                if (_dialogService.ShowDialog(typeof(EditServicePage), vm))
                {
                    var command = _mapper.Map<UpsertServiceCommand>(vm.Item);

                    if (command.JuniorSkill != null)
                        command.JuniorSkill.Id = tempService.JuniorSkill.Id;

                    if (command.MiddleSkill != null)
                        command.MiddleSkill.Id = tempService.MiddleSkill.Id;

                    if (command.SeniorSkill != null)
                        command.SeniorSkill.Id = tempService.SeniorSkill.Id;

                    await _offerService.Update(command);
                    await LoadItems();
                }
            }
        });
    }

    private async Task RemoveItem(object obj)
    {
        await Execute(async () =>
        {
            if (obj is int serviceId)
            {
                await _offerService.RemoveById(serviceId);
                await LoadItems();
            }
        });
    }

    // Скрытие базового метода, для использования своего
    public override Task RemoveItem()
        => throw new NotImplementedException();

    // Скрытие базового метода, для использования своего
    public override Task EditItem()
        => throw new NotImplementedException();
}