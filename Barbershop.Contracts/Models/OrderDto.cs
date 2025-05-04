namespace Barbershop.Contracts.Models;

public class OrderDto : EntityDto
{
    public OrderStatusDto Status { get; set; }

    public int BarbersGain { get; set; }

    public BarberDto Barber { get; set; }
    public ClientDto Client { get; set; }

    public List<OrderServiceDto> Services { get; set; }
    public List<ProductDto> Products { get; set; }

    public DateTime BeginDateTime { get; set; }

    public DateTime EndDateTime
        => BeginDateTime.AddMinutes(Services.Sum(x => x.MinutesDuration));

    public decimal PureCost => (TotalServicesPrice * BarbersGain / 100) + (Products.Sum(x => x.Cost) * 15 / 100);

    public decimal TotalServicesPrice => Services.Sum(x => x.Cost);

    public decimal TotalPrice =>
        Services.Sum(x => x.Cost) + Products.Sum(x => x.Cost);

    public bool DiscountApplied { get; set; }

    public decimal DiscountRate { get; set; }

    public decimal FinalPrice
        => DiscountApplied
            ? Math.Round(TotalServicesPrice * (1 - DiscountRate) + Products.Sum(x => x.Cost), 2)
            : TotalPrice;

    public int TotalMinutes =>
        Services.Sum(x => x.MinutesDuration);

    public decimal Revenue
        => Services.Sum(x => x.Cost) + Products.Sum(x => x.Cost);

    public decimal BarberPayoutByGrade
    {
        get
        {
            var percentage = Barber?.SkillLevel switch
            {
                BarberSkillLevel.Junior => 15,
                BarberSkillLevel.Middle => 25,
                BarberSkillLevel.Senior => 35,
                _ => 0
            };

            var baseServiceCost = DiscountApplied
                ? TotalServicesPrice * (1 - DiscountRate)
                : TotalServicesPrice;

            return Math.Round(baseServiceCost * percentage / 100, 2);
        }
    }

    public decimal Profit
        => Math.Round(
            // 1) выручка по услугам с учётом скидки
            (DiscountApplied
                ? TotalServicesPrice * (1 - DiscountRate)
                : TotalServicesPrice)
            // 2) плюс выручка по товарам (скидка на товары не применяется)
            + Products.Sum(x => x.Cost)
            // 3) минус выплата мастеру
            - BarberPayoutByGrade,
            2);
}