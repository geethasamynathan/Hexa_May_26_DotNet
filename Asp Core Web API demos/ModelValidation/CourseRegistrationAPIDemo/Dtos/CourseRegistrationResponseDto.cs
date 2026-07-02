// File: Dtos/CourseRegistrationResponseDto.cs
using System;

namespace CourseRegistrationAPIDemo.Dtos
{
    public class CourseRegistrationResponseDto
    {
        public int CourseRegistrationId { get; set; }
        public string StudentName { get; set; }
        public string Email { get; set; }
        public string MobileNumber { get; set; }
        public int Age { get; set; }
        public string CourseName { get; set; }
        public decimal PaymentAmount { get; set; }
        public string TrainingMode { get; set; }
        public string Location { get; set; }
        public DateTime CourseStartDate { get; set; }
        public DateTime RegisteredOn { get; set; }
    }
}
