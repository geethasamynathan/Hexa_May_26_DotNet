
using FleetMaintenanceApi.Data;
using FleetMaintenanceApi.Repositories.Implementations;
using FleetMaintenanceApi.Repositories.Interfaces;
using FleetMaintenanceApi.Services.Implementations;
using FleetMaintenanceApi.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace FleetMaintenanceApi
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            builder.Services.AddDbContext<FleetMaintenanceDbContext>(options =>
            {
                options.UseSqlServer(
                    builder.Configuration.GetConnectionString("DefaultConnection"));
            });

            // Add services to the container.

            builder.Services.AddControllers();

            builder.Services.AddScoped<IVehicleRepository, VehicleRepository>();
            builder.Services.AddScoped<IDriverRepository, DriverRepository>();
            builder.Services.AddScoped<IMaintenanceRepository, MaintenanceRepository>();

            builder.Services.AddScoped<IVehicleService, VehicleService>();
            builder.Services.AddScoped<IDriverService, DriverService>();
            builder.Services.AddScoped<IMaintenanceService, MaintenanceService>();

            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();

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
