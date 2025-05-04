using System.Globalization;
using System.Windows.Data;
using System.Windows.Markup;
using Barbershop.Contracts.Models;

namespace Barbershop.UI.Converters;

public class ServicesToStringConverter : MarkupExtension, IValueConverter
{
    public override object ProvideValue(IServiceProvider serviceProvider) => this;

    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        if (value is IEnumerable<OrderServiceDto> services)
        {
            var names = services.Select(s => s.Name);
            return string.Join(", ", names);
        }

        return string.Empty;
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        => throw new NotSupportedException();
}