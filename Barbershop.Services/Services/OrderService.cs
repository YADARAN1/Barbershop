﻿using AutoMapper;
using Barbershop.Contracts.Commands;
using Barbershop.Contracts.Models;
using Barbershop.DAL.Repositories;
using Barbershop.Domain.Models;
using Barbershop.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace Barbershop.Services.Services;

public sealed class OrderService : EntityService<OrderDto, Order, UpsertOrderCommand>
{
    private readonly IOrderRepository _orderRepository;
    private readonly IBaseRepository<ServiceSkillLevel> _serviceRepository;

    public OrderService(
        IOrderRepository orderRepository,
        IBaseRepository<Order> baseOrderRepository,
        IBaseRepository<ServiceSkillLevel> serviceRepository,
        IMapper mapper)
        : base(baseOrderRepository, mapper)
    {
        _orderRepository = orderRepository ?? throw new ArgumentNullException(nameof(orderRepository));
        _serviceRepository = serviceRepository ?? throw new ArgumentNullException(nameof(serviceRepository));
    }

    public override async Task Create(UpsertOrderCommand command)
    {
        var skillLevels = await _serviceRepository
            .FindAll(x => command.ServiceSkillLevelIds.Contains(x.Id));

        var order = new Order
        {
            OrderStatus = OrderStatus.Created,
            CreatedOn = command.CreatedOn,
            BarberId = command.BarberId,
            ClientId = command.ClientId,
            ServiceSkillLevels = skillLevels.ToList(),
            DiscountApplied = command.DiscountApplied,
            DiscountRate = command.DiscountRate
        };

        await _orderRepository.CreateOrder(order);
    }

    public async Task<IReadOnlyList<OrderDto>> GetBarberOrders(int barberId, DateTime date)
    {
        var orders = await _entityRepository.FindAll(
            x => x.BarberId == barberId && x.CreatedOn.Date == date.Date,
            x => x.ServiceSkillLevels);

        var list = orders
            .Select(o => _mapper.Map<OrderDto>(o))
            .ToList();

        return list;
    }

    public async Task CancelOrder(int orderId)
    {
        var order = await _entityRepository.GetById(orderId);
        order.OrderStatus = OrderStatus.Canceled;

        await _entityRepository.Update(order);
    }

    public async Task CompleteOrder(int orderId)
    {
        var order = await _entityRepository.GetById(orderId);
        order.OrderStatus = OrderStatus.Done;
        order.CompletedOn = DateTime.UtcNow;

        await _entityRepository.Update(order);
    }

    public override async Task<OrderDto> GetById(int orderId)
    {
        var order = await _entityRepository.GetById(orderId,
            x => x.Include(x => x.Barber)
                .ThenInclude(x => x.User)
                .Include(x => x.Client)
                .ThenInclude(x => x.User)
                .Include(x => x.ServiceSkillLevels)
                .ThenInclude(x => x.Service)
                .Include(x => x.Products));

        return _mapper.Map<OrderDto>(order);
    }

    public override async Task<IReadOnlyList<OrderDto>> GetAll()
    {
        var orders = await _entityRepository.GetAll(o => o
            .Include(x => x.Barber).ThenInclude(b => b.User)
            .Include(x => x.Client).ThenInclude(c => c.User)
            .Include(x => x.ServiceSkillLevels).ThenInclude(sl => sl.Service)
            .Include(x => x.Products));

        var list = orders
            .Select(o => _mapper.Map<OrderDto>(o))
            .ToList();

        return list;
    }

    public async Task UpdateProducts(int id, IReadOnlyList<int> productsIds)
    {
        await _orderRepository.UpdateProducts(id, productsIds);
    }
}