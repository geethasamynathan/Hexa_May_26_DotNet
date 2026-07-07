using System.ComponentModel.DataAnnotations;

namespace EmployeeLeaveAPI.Validations
{
    public class FutureDateAttribute : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext context)
        {
            if (value == null)
            {
                return new ValidationResult("Date is required");
            }

            if (value is DateTime date)
            {
                if (date.Date <= DateTime.Now.Date)
                {
                    return new ValidationResult(ErrorMessage ?? "Date must be a future date");
                }
            }

            return ValidationResult.Success;
        }
    }
}