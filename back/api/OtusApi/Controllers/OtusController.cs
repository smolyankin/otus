using System.Net;
using System.Net.Sockets;
using Microsoft.AspNetCore.Mvc;
using OtusApi.Data;

namespace OtusApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class OtusController : ControllerBase
    {
        private readonly OtusDbContext _context;
        private readonly ILogger _logger;

        public OtusController(OtusDbContext context, ILogger<OtusController> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<IEnumerable<RequestEntity>> Get()
        {
            var ip = Dns.GetHostEntry(Dns.GetHostName(), AddressFamily.InterNetwork).AddressList
                .FirstOrDefault()?.ToString()
                ?? throw new Exception("ip v4 not found");

            var request = new RequestEntity { Ip = ip };
            _context.Add(request);
            await _context.SaveChangesAsync();

            return _context.Requests.OrderByDescending(x => x.Id);
        }

        [HttpPost("bad")]
        public IActionResult Bad() 
        {
            return BadRequest();
        }

        [HttpDelete("error")]
        public IActionResult Error()
        {
            throw new NotImplementedException();
        }
    }
}
