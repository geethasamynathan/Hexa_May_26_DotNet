using AutoMapper;
using EmployeeManagementAPI.Dtos;
using EmployeeManagementAPI.Models;
using EmployeeManagementAPI.Repository.Interfaces;
using EmployeeManagementAPI.Services.Interfaces;

namespace EmployeeManagementAPI.Services.Implementations
{
    public class DepartmentService : IDepartmentService
    {
        private readonly IDepartmentRepository _departmentRepository;
        private readonly IMapper _mapper;

        public DepartmentService(IDepartmentRepository departmentRepository, IMapper mapper)
        {
            _departmentRepository = departmentRepository;
            _mapper = mapper;
        }

        public async Task<List<DepartmentResponseDto>> GetAllDepartmentsAsync()
        {
            var departments = await _departmentRepository.GetAllDepartmentsAsync();

            ////manual maaping
            //var departmentResponseDtos = departments.Select(department => new DepartmentResponseDto
            //{
            //    DepartmentId = department.DepartmentId,
            //    DepartmentName = department.DepartmentName,
            //    Location = department.Location
            //}).ToList();
            // return departmentResponseDtos;

            return _mapper.Map<List<DepartmentResponseDto>>(departments);


        }

        public async Task<DepartmentResponseDto?> GetDepartmentByIdAsync(int departmentId)
        {
            var department = await _departmentRepository.GetDepartmentByIdAsync(departmentId);

            if (department == null)
            {
                return null;
            }

            //var departmentResponseDto = new DepartmentResponseDto
            //{
            //    DepartmentId = department.DepartmentId,
            //    DepartmentName = department.DepartmentName,
            //    Location = department.Location
            //};

            //return departmentResponseDto;
            return _mapper.Map<DepartmentResponseDto>(department);
        }

        public async Task<DepartmentResponseDto> AddDepartmentAsync(DepartmentCreateDto departmentCreateDto)
        {
            var department = new Department
            {
                DepartmentName = departmentCreateDto.DepartmentName,
                Location = departmentCreateDto.Location
            };

            await _departmentRepository.AddDepartmentAsync(department);

            //var departmentResponseDto = new DepartmentResponseDto
            //{
            //    DepartmentId = department.DepartmentId,
            //    DepartmentName = department.DepartmentName,
            //    Location = department.Location
            //};

            //return departmentResponseDto;

            return _mapper.Map<DepartmentResponseDto>(department);
        }

    }
}