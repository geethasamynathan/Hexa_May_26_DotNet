
using Api_Pagination_Sorting_Demo.Data;
using Api_Pagination_Sorting_Demo.Middlewares;
using Api_Pagination_Sorting_Demo.Repository.Implementations;
using Api_Pagination_Sorting_Demo.Repository.Interfaces;
using Api_Pagination_Sorting_Demo.Services.Implementations;
using Api_Pagination_Sorting_Demo.Services.Interfaces;
using log4net;
using log4net.Config;
using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace Api_Pagination_Sorting_Demo
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            var logRepository= LogManager.GetRepository(Assembly.GetEntryAssembly());
            XmlConfigurator.Configure(logRepository, new FileInfo("log4net.config"));

            // Add services to the container.
            builder.Logging.ClearProviders();
            builder.Logging.AddConsole();
            builder.Logging.AddLog4Net("log4net.config");

            builder.Services.AddControllers();
          
            builder.Services.AddDbContext<HospitalAppointmentDbContext>(options =>
            {
                options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
            });
            builder.Services.AddScoped<IAppointmentRepository,AppointmentRepository>();
            builder.Services.AddScoped<IAppointmentService, AppointmentService>();

            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();
            app.UseMiddleware<GlobalExceptionMiddleware>();
            app.UseMiddleware<RequestResponseLoggingMiddleware>();
            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
