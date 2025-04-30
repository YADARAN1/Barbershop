namespace Barbershop.Contracts.Models;

public class OrderServiceDto : EntityDto
{
    public string Name { get; set; }

    public BarberSkillLevel SkillLevel { get; set; }
    public int MinutesDuration { get; set; }

    public decimal Cost { get; set; }

    public bool DiscountApplied { get; set; }

    public decimal DiscountRate { get; set; }

    public decimal DiscountedCost => DiscountApplied
        ? Math.Round(Cost * (1 - DiscountRate), 2)
        : Cost;
}