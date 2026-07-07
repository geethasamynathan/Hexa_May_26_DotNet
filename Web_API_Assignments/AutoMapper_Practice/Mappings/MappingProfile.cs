using AutoMapper;
using EmployeeManagementAPI.Dtos;
using EmployeeManagementAPI.Models;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace EmployeeManagementAPI.Mappings
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<DepartmentCreateDto, Department>().ReverseMap();
            CreateMap<Department, DepartmentResponseDto>().ReverseMap();
            CreateMap<EmployeeCreateDto, Employee>().ReverseMap();
            CreateMap<Employee, EmployeeResponseDto>()
                    .ForMember(dest => dest.DepartmentName, opt => opt.MapFrom(src => src.Department != null ? src.Department.DepartmentName : string.Empty))
                    .ReverseMap();
            CreateMap<EmployeeUpdateDto, Employee>().ReverseMap();
        }
    }
}