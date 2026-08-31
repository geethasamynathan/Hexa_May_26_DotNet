using System.ComponentModel.DataAnnotations;

namespace EmployeeLeaveRequestAPI.Validations
{
    public class ValidLeaveTypeAttribute :ValidationAttribute
    {
        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            if (value == null)
            {
                return new ValidationResult("Leave Type is Required.");
            }
            if(value is string leaveType)
            {
                if (leaveType.Equals("Sick", StringComparison.OrdinalIgnoreCase) ||
                   leaveType.Equals("Casual", StringComparison.OrdinalIgnoreCase) ||
                   leaveType.Equals("Earned", StringComparison.OrdinalIgnoreCase))
                {
                    return ValidationResult.Success;
                }
                return new ValidationResult(ErrorMessage ?? "Leave type must be Sick or Casual or Earned.");
            }
            return new ValidationResult("Invalid leave type.");
        }
    }
}
