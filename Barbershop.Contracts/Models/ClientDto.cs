namespace Barbershop.Contracts.Models;

public class ClientDto : UserDto
{
    public string Notes { get; set; }

    public virtual ICollection<OrderDto> Orders { get; set; }
    
    public int VisitsCount
        => Orders.Count(o => o.Status != OrderStatusDto.Canceled);

    public override string ToString()
        => string.Join(' ', LastName, FirstName, Surname);
}