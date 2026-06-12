using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace FleetMaintenanceApi.Models;

public partial class Driver
{
    [Key]
    public int DriverId { get; set; }

    [StringLength(100)]
    [Unicode(false)]
    public string DriverName { get; set; } = null!;

    [StringLength(50)]
    [Unicode(false)]
    public string LicenseNumber { get; set; } = null!;

    [StringLength(15)]
    [Unicode(false)]
    public string PhoneNumber { get; set; } = null!;

    [StringLength(50)]
    [Unicode(false)]
    public string City { get; set; } = null!;

    public bool IsAvailable { get; set; }

    [InverseProperty("Driver")]
    public virtual ICollection<MaintenanceRecord> MaintenanceRecords { get; set; } = new List<MaintenanceRecord>();
}
