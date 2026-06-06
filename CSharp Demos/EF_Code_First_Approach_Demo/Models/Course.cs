using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EF_Code_First_Approach_Demo.Models
{
    public class Course
    {
        public int CourseId { get; set; }
        public string CourseName { get; set; } = string.Empty;

        public decimal CourseFee { get;set;  }
        public int DurationDays { get; set; }

        public List<Enrollment> Enrollments { get; set; }= new List<Enrollment>();
    }
}
