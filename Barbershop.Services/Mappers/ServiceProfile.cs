﻿using AutoMapper;
using Barbershop.Contracts.Commands;
using Barbershop.Contracts.Models;
using Barbershop.Domain.Models;

namespace Barbershop.Services.Mappers;

public sealed class ServiceProfile : Profile
{
    public ServiceProfile()
    {
        CreateMap<Service, ServiceDto>()
            .ForMember(dest => dest.JuniorSkill,
                opt => opt.MapFrom((src, _, dest) => MapServiceSkillLevel(src.ServiceSkillLevels, SkillLevel.Junior) ?? new ServiceSkillLevelDto()))  // Поставим пустой объект, если null
            .ForMember(dest => dest.MiddleSkill,
                opt => opt.MapFrom((src, _, dest) => MapServiceSkillLevel(src.ServiceSkillLevels, SkillLevel.Middle) ?? new ServiceSkillLevelDto()))
            .ForMember(dest => dest.SeniorSkill,
                opt => opt.MapFrom((src, _, dest) => MapServiceSkillLevel(src.ServiceSkillLevels, SkillLevel.Senior) ?? new ServiceSkillLevelDto()));

        CreateMap<ServiceDto, UpsertServiceCommand>();

        CreateMap<UpsertServiceCommand, Service>()
            .ForMember(dest => dest.ServiceSkillLevels, opt => opt.MapFrom((src, _, dest) =>
            {
                var items = new List<ServiceSkillLevel>();
                ConvertSkillLevel(items, src.JuniorSkill, SkillLevel.Junior);
                ConvertSkillLevel(items, src.MiddleSkill, SkillLevel.Middle);
                ConvertSkillLevel(items, src.SeniorSkill, SkillLevel.Senior);

                return items;
            }));
    }

    public static ServiceSkillLevelDto? MapServiceSkillLevel(
        ICollection<ServiceSkillLevel> serviceSkillLevels,
        SkillLevel skillLevel)
    {
        var service = serviceSkillLevels
            .SingleOrDefault(x => x.SkillLevel == skillLevel);

        if (service != null)
        {
            return new ServiceSkillLevelDto
            {
                Id = service.Id,
                Cost = service.Cost,
                MinutesDuration = service.MinutesDuration
            };
        }

        return null;
    }

    public static void ConvertSkillLevel(
        in List<ServiceSkillLevel> skillLevels,
        ServiceSkillLevelDto? serviceSkillLevelDto,
        SkillLevel skillLevel)
    {
        if (serviceSkillLevelDto != null)
        {
            skillLevels.Add(new()
            {
                Id = serviceSkillLevelDto.Id,
                Cost = serviceSkillLevelDto.Cost,
                MinutesDuration = serviceSkillLevelDto.MinutesDuration,
                SkillLevel = skillLevel
            });
        }
    }
}