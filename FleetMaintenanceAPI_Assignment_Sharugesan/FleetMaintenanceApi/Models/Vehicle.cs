using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace FleetMaintenanceApi.Models;

public partial class Vehicle
{
    [Key]
    public int VehicleId { get; set; }

    [StringLength(20)]
    [Unicode(false)]
    public string VehicleNumber { get; set; } = null!;

    [StringLength(50)]
    [Unicode(false)]
    public string VehicleType { get; set; } = null!;

    [StringLength(50)]
    [Unicode(false)]
    public string Brand { get; set; } = null!;

    [StringLength(50)]
    [Unicode(false)]
    public string Model { get; set; } = null!;

    public int PurchaseYear { get; set; }

    public bool IsActive { get; set; }

    [InverseProperty("Vehicle")]
    public virtual ICollection<MaintenanceRecord> MaintenanceRecords { get; set; } = new List<MaintenanceRecord>();
}
