using AutoMapper;
using AutoMapper.Extensions.EnumMapping;
using Barbershop.Contracts.Models;
using Barbershop.Domain.Models;

namespace Barbershop.Services.Mappers;

public class OrderProfile : Profile
{
    public OrderProfile()
    {
        CreateMap<Order, OrderDto>()
            .ForMember(dest => dest.BeginDateTime, opt =>
                opt.MapFrom(src => src.CreatedOn))
            .ForMember(dest => dest.Status, opt =>
                opt.MapFrom(src => src.OrderStatus))
            .ForMember(dest => dest.Services, opt =>
                opt.MapFrom(src => src.ServiceSkillLevels))
            .ForMember(dest => dest.DiscountApplied, opt =>
                opt.MapFrom(src => src.DiscountApplied))
            .ForMember(dest => dest.DiscountRate, opt =>
                opt.MapFrom(src => src.DiscountRate))
            .AfterMap((order, dto) =>
            {
                foreach (var service in dto.Services)
                {
                    service.DiscountApplied = order.DiscountApplied;
                    service.DiscountRate = order.DiscountRate;
                }
            });

        CreateMap<ServiceSkillLevel, OrderServiceDto>();
        CreateMap<Service, ServiceDto>();
        CreateMap<OrderStatus, OrderStatusDto>()
            .ConvertUsingEnumMapping()
            .ReverseMap();
    }
}