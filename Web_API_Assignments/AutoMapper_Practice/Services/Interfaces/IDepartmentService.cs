using EmployeeManagementAPI.Dtos;

namespace EmployeeManagementAPI.Services.Interfaces
{
    public interface IDepartmentService
    {
        Task<List<DepartmentResponseDto>> GetAllDepartmentsAsync();

        Task<DepartmentResponseDto?> GetDepartmentByIdAsync(int departmentId);

        Task<DepartmentResponseDto> AddDepartmentAsync(DepartmentCreateDto departmentCreateDto);
    }
}