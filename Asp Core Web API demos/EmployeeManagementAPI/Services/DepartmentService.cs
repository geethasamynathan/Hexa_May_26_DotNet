using EmployeeManagementAPI.DTOs;
using EmployeeManagementAPI.Models;
using EmployeeManagementAPI.Repositories.Interfaces;

namespace EmployeeManagementAPI.Services
{
    public class DepartmentService:IDepartmentService
    {
        private readonly IDepartmentRepository _departmentRepository;

        public DepartmentService(IDepartmentRepository departmentRepository)
        {
            _departmentRepository = departmentRepository;
        }

        public async Task<List<DepartmentResponseDto>> GetAllDepartmentsAsync()
        {
            var departments = await _departmentRepository.GetAllDepartmentsAsync();

            return departments.Select(d => new DepartmentResponseDto
            {
                DepartmentId = d.DepartmentId,
                DepartmentName = d.DepartmentName,
                Location = d.Location
            }).ToList();
        }

        public async Task<DepartmentResponseDto?> GetDepartmentByIdAsync(int departmentId)
        {
            var department = await _departmentRepository.GetDepartmentByIdAsync(departmentId);

            if (department == null)
            {
                return null;
            }

            return new DepartmentResponseDto
            {
                DepartmentId = department.DepartmentId,
                DepartmentName = department.DepartmentName,
                Location = department.Location
            };
        }
        public async Task<DepartmentResponseDto> AddDepartmentAsync(DepartmentCreateDto departmentCreateDto)
        {
            var department = new Department
            {
                DepartmentName = departmentCreateDto.DepartmentName,
                Location = departmentCreateDto.Location
            };

            await _departmentRepository.AddDepartmentAsync(department);

            return new DepartmentResponseDto
            {
                DepartmentId = department.DepartmentId,
                DepartmentName = department.DepartmentName,
                Location = department.Location
            };
        }
    }
}
