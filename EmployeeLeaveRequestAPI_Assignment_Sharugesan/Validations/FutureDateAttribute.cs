using System.ComponentModel.DataAnnotations;

namespace EmployeeLeaveRequestAPI.Validations
{
    public class FutureDateAttribute : ValidationAttribute
    {
        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            if (value == null)
            {
                return new ValidationResult("Date is Required.");
            }
            if(value is DateTime dateValue)
            {
                if (dateValue.Date <= DateTime.Today)
                {
                    return new ValidationResult(ErrorMessage ?? "Date must be in Future.");
                }
                return ValidationResult.Success;
            }
            return new ValidationResult("Invalid Date.");
        }
    }
}
