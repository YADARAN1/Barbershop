using Barbershop.Contracts.Models;
using System.Globalization;
using System.Windows.Data;
using System.Windows.Markup;

namespace Barbershop.UI.Converters
{
    public class ProductsToStringConverter : MarkupExtension, IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is List<ProductDto> productDtos)
            {
                if (productDtos.Count == 0)
                    return "Товары не выбраны";

                var productNames = productDtos.Select(dto => dto.Name);

                return string.Join(", ", productNames);
            }
            return string.Empty;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }

        public override object ProvideValue(IServiceProvider serviceProvider)
        {
            return this;
        }
    }
}