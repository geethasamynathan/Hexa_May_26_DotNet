namespace EmployeeManagementAPI.Dtos
{
    public class DepartmentResponseDto
    {
        public int DepartmentId { get; set; }

        public string DepartmentName { get; set; } = string.Empty;

        public string Location { get; set; } = string.Empty;
    }
}