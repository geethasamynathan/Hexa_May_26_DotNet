using FleetMaintenanceApi.DTOs;
using FleetMaintenanceApi.Models;
using FleetMaintenanceApi.Repositories.Interfaces;
using FleetMaintenanceApi.Services.Interfaces;

namespace FleetMaintenanceApi.Services.Implementations
{
    public class DriverService : IDriverService
    {
        private readonly IDriverRepository _driverRepository;

        public DriverService(IDriverRepository driverRepository)
        {
            _driverRepository = driverRepository;
        }

        public async Task<List<DriverResponseDto>> GetAllDriversAsync()
        {
            var drivers = await _driverRepository.GetAllDriversAsync();

            return drivers.Select(d => new DriverResponseDto
            {
                DriverId = d.DriverId,
                DriverName = d.DriverName,
                LicenseNumber = d.LicenseNumber,
                PhoneNumber = d.PhoneNumber,
                City = d.City,
                IsAvailable = d.IsAvailable
            }).ToList();
        }

        public async Task<DriverResponseDto?> GetDriverByIdAsync(int driverId)
        {
            var driver = await _driverRepository.GetDriverByIdAsync(driverId);

            if (driver == null)
                return null;

            return new DriverResponseDto
            {
                DriverId = driver.DriverId,
                DriverName = driver.DriverName,
                LicenseNumber = driver.LicenseNumber,
                PhoneNumber = driver.PhoneNumber,
                City = driver.City,
                IsAvailable = driver.IsAvailable
            };
        }

        public async Task<(bool Success, string Message, DriverResponseDto? Data)>
            AddDriverAsync(DriverCreateDto dto)
        {
            if (string.IsNullOrWhiteSpace(dto.DriverName))
                return (false, "Driver name is required", null);

            if (string.IsNullOrWhiteSpace(dto.LicenseNumber))
                return (false, "License number is required", null);

            if (string.IsNullOrWhiteSpace(dto.PhoneNumber))
                return (false, "Phone number is required", null);

            if (string.IsNullOrWhiteSpace(dto.City))
                return (false, "City is required", null);

            var driver = new Driver
            {
                DriverName = dto.DriverName,
                LicenseNumber = dto.LicenseNumber,
                PhoneNumber = dto.PhoneNumber,
                City = dto.City,
                IsAvailable = dto.IsAvailable
            };

            await _driverRepository.AddDriverAsync(driver);

            return (true, "Driver added successfully",
                new DriverResponseDto
                {
                    DriverId = driver.DriverId,
                    DriverName = driver.DriverName,
                    LicenseNumber = driver.LicenseNumber,
                    PhoneNumber = driver.PhoneNumber,
                    City = driver.City,
                    IsAvailable = driver.IsAvailable
                });
        }
    }
}
