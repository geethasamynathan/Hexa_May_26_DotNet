using System.ComponentModel.DataAnnotations;
using EmployeeLeaveAPI.Validations;

namespace EmployeeLeaveAPI.DTOs
{
    public class LeaveRequestCreateDto
    {
        [Required(ErrorMessage = "Employee name is required")]
        [MinLength(3, ErrorMessage = "Name must be at least 3 characters")]
        [MaxLength(100, ErrorMessage = "Name cannot exceed 100 characters")]
        public string EmployeeName { get; set; } = string.Empty;

        [Required(ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid email format")]
        public string EmployeeEmail { get; set; } = string.Empty;

        [Required(ErrorMessage = "Mobile number is required")]
        [RegularExpression(@"^[6-9]\d{9}$", ErrorMessage = "Enter valid 10 digit mobile number")]
        public string MobileNumber { get; set; } = string.Empty;

        [Required(ErrorMessage = "Leave type is required")]
        [ValidLeaveType]
        public string LeaveType { get; set; } = string.Empty;

        [Required(ErrorMessage = "Start date is required")]
        [FutureDate]
        public DateTime StartDate { get; set; }

        [Required(ErrorMessage = "End date is required")]
        [FutureDate]
        public DateTime EndDate { get; set; }

        [Required(ErrorMessage = "Reason is required")]
        [MinLength(10, ErrorMessage = "Reason must be at least 10 characters")]
        [MaxLength(250, ErrorMessage = "Reason cannot exceed 250 characters")]
        public string Reason { get; set; } = string.Empty;
    }
}