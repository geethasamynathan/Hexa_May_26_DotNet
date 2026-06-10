using EmployeeLeaveRequestAPI.Validations;
using System.ComponentModel.DataAnnotations;

namespace EmployeeLeaveRequestAPI.DTOs
{
    public class LeaveRequestCreateDto
    {
        [Required(ErrorMessage ="Employee Name is Required.")]
        [StringLength(100,MinimumLength =3,ErrorMessage ="Name should with 3 to 100 Characters.")]
        public string EmployeeName { get; set; } = string.Empty;


        [Required(ErrorMessage = "Employee Email is Required.")]
        [EmailAddress(ErrorMessage ="Invalid Email.")]
        public string EmployeeEmail { get; set; } = string.Empty;


        [Required(ErrorMessage = "Employee Mobile Number is Required.")]
        [RegularExpression(@"^[6-9]\d{9}$",ErrorMessage = "Mobile Number must be a valid 10 digit Indian mobile number.")]
        public string MobileNumber { get; set; } = string.Empty;



        [ValidLeaveType]
        public string LeaveType { get; set; } = string.Empty;

        [FutureDate]
        public DateTime StartDate { get; set; }

        [FutureDate]
        public DateTime EndDate { get; set; }

        [Required(ErrorMessage = "Reason is Required.")]
        [StringLength(250,MinimumLength =10,ErrorMessage ="Reason must be within 10 to 250 Characters.")]
        public string Reason { get; set; } = string.Empty;

    }
}
