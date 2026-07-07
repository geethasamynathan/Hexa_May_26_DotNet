using System.ComponentModel.DataAnnotations;

namespace EmployeeLeaveAPI.Validations
{
    public class ValidLeaveTypeAttribute : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext context)
        {
            if (value == null)
            {
                return new ValidationResult("Leave type is required");
            }

            string type = value.ToString();
            string[] allowed = { "Sick", "Casual", "Earned" };

            if (!allowed.Contains(type))
            {
                return new ValidationResult("Leave type must be Sick, Casual, or Earned");
            }

            return ValidationResult.Success;
        }
    }
}