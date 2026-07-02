// File: Dtos/CourseRegistrationUpdateDto.cs
using System;

namespace CourseRegistrationAPIDemo.Dtos
{
    public class CourseRegistrationUpdateDto
    {
        public int CourseRegistrationId { get; set; }

        public string StudentName { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        public string MobileNumber { get; set; } = string.Empty;

        public int Age { get; set; }

        public string CourseName { get; set; } = string.Empty;

        public decimal PaymentAmount { get; set; }

        public string TrainingMode { get; set; } = string.Empty;

        public string Location { get; set; } = string.Empty;

        public DateTime CourseStartDate { get; set; }

        public DateTime RegisteredOn { get; set; }
    }
}
