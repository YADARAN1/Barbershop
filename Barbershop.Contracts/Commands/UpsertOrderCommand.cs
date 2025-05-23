﻿namespace Barbershop.Contracts.Commands;

public class UpsertOrderCommand : IdentifiedCommand
{
    public DateTime CreatedOn { get; set; }

    public int BarberId { get; set; }

    public int ClientId { get; set; }

    public IReadOnlyList<int> ServiceIds { get; set; }

    public IReadOnlyList<int> ServiceSkillLevelIds { get; set; }

    public bool DiscountApplied { get; set; }

    public decimal DiscountRate { get; set; }
}