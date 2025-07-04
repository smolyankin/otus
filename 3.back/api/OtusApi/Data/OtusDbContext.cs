using Microsoft.EntityFrameworkCore;

namespace OtusApi.Data;

public class OtusDbContext : DbContext
{
    public OtusDbContext(DbContextOptions<OtusDbContext> options) : base(options)
    {
    }

    public DbSet<RequestEntity> Requests { get; set; }
}
