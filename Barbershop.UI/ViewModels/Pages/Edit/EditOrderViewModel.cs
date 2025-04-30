using Barbershop.Contracts.Models;
using Barbershop.UI.ViewModels.Base;
using DevExpress.Mvvm;
using System.Collections.ObjectModel;
using System.Windows.Input;
using Barbershop.Services.Services;

namespace Barbershop.UI.ViewModels.Pages.Edit;

public class EditOrderViewModel : EditViewModel<OrderDto>
{
    private readonly ProductService _productService;

    public ObservableCollection<ProductDto> ProductsToSelect { get; set; } = new();

    public ProductDto ProductToSelect
    {
        get => GetValue<ProductDto>(nameof(ProductToSelect));
        set => SetValue(value, nameof(ProductToSelect));
    }

    public ObservableCollection<ProductDto> SelectedProducts { get; set; } = new();

    public ProductDto SelectedProduct
    {
        get => GetValue<ProductDto>(nameof(SelectedProduct));
        set => SetValue(value, nameof(SelectedProduct));
    }

    public decimal DiscountedServicesCost
        => Item.DiscountApplied
            ? Math.Round(Item.TotalServicesPrice * (1 - Item.DiscountRate), 2)
            : Item.TotalServicesPrice;

    public ICommand AddProductCommand { get; }
    public ICommand RemoveProductCommand { get; }

    public decimal TotalProductsCost => SelectedProducts.Sum(x => x.Cost);

    public decimal TotalCost
        => DiscountedServicesCost + TotalProductsCost;

    public EditOrderViewModel(OrderDto order, ProductService productService)
        : base(order)
    {
        _productService = productService ?? throw new ArgumentNullException(nameof(productService));

        AddProductCommand = new DelegateCommand(SelectProduct, () => ProductToSelect != null);
        RemoveProductCommand = new DelegateCommand(RemoveProduct, () => SelectedProduct != null);

        PropertyChanged += (s, e) =>
        {
            if (e.PropertyName == nameof(Item))
            {
                RaisePropertyChanged(nameof(DiscountedServicesCost));
                RaisePropertyChanged(nameof(TotalCost));
            }
        };

        LoadViewDataCommand = new AsyncCommand(async () =>
        {
            await SplitProducts();
            RaisePropertyChanged(nameof(TotalCost));
            RaisePropertyChanged(nameof(DiscountedServicesCost));
        });
    }

    private async Task SplitProducts()
    {
        var products = await _productService.GetAll();

        ProductsToSelect = new(products.ExceptBy(Item.Products.Select(x => x.Id), x => x.Id));
        SelectedProducts = new(Item.Products);
        RaisePropertiesChanged(nameof(ProductsToSelect), nameof(SelectedProducts), nameof(TotalCost));
    }

    private void SelectProduct()
    {
        SelectedProducts.Add(ProductToSelect);
        ProductsToSelect.Remove(ProductToSelect);
        RaisePropertyChanged(nameof(TotalCost));
    }

    private void RemoveProduct()
    {
        ProductsToSelect.Add(SelectedProduct);
        SelectedProducts.Remove(SelectedProduct);
        RaisePropertyChanged(nameof(TotalCost));
    }
}