using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Barbershop.Contracts.Models;

public sealed class SaleryOrderInfoDto : EntityDto
{
    public DateTime BeginDateTime { get; set; }
    public ClientDto Client { get; set; }

}
