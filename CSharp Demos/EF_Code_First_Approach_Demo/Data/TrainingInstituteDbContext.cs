using EF_Code_First_Approach_Demo.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EF_Code_First_Approach_Demo.Data
{
    internal class TrainingInstituteDbContext:DbContext
    {
        //public TrainingInstituteDbContext(DbContextOptions<TrainingInstituteDbContext> options):base(options)
        //{

        //}
        
        public DbSet<Student> Students { get; set; }
        public DbSet<Course> Courses { get; set; }
        
        public DbSet<Enrollment> Enrollments { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(
                "SERVER=localhost;Database=TrainnigInstituteDb;Trusted_Connection=True;TrustServerCertificate=true;");
        }
    }
}
