using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace FleetMaintenanceApi.Models;

public partial class MaintenanceRecord
{
    [Key]
    public int MaintenanceId { get; set; }

    public int VehicleId { get; set; }

    public int DriverId { get; set; }

    public DateOnly ServiceDate { get; set; }

    [StringLength(100)]
    [Unicode(false)]
    public string ServiceType { get; set; } = null!;

    [Column(TypeName = "decimal(18, 2)")]
    public decimal ServiceCost { get; set; }

    [StringLength(30)]
    [Unicode(false)]
    public string ServiceStatus { get; set; } = null!;

    [StringLength(250)]
    [Unicode(false)]
    public string? Remarks { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime CreatedDate { get; set; }

    [ForeignKey("DriverId")]
    [InverseProperty("MaintenanceRecords")]
    public virtual Driver Driver { get; set; } = null!;

    [ForeignKey("VehicleId")]
    [InverseProperty("MaintenanceRecords")]
    public virtual Vehicle Vehicle { get; set; } = null!;
}
