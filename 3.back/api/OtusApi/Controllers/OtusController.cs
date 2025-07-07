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
            //var ip = HttpContext.Connection.LocalIpAddress?.ToString();
            //var allNetworkAddressList = Dns.GetHostEntry(Dns.GetHostName()).AddressList;
            //foreach (var item in allNetworkAddressList)
            //{
            //    _logger.LogInformation("All Networks:");
            //    _logger.LogInformation(item.ToString());
            //}
            var interNetworkAddressList = Dns.GetHostEntry(Dns.GetHostName(), AddressFamily.InterNetwork).AddressList;
            foreach (var item in interNetworkAddressList)
            {
                _logger.LogInformation("InterNetwork Networks:");
                _logger.LogInformation(item.ToString());
            }
            var ip = Dns.GetHostEntry(Dns.GetHostName(), AddressFamily.InterNetwork).AddressList
                //.Where(x => x.ToString().StartsWith("10.0.0."))
                .LastOrDefault()?.ToString()
                ?? throw new Exception("ip v4 not found");

            var request = new RequestEntity { Ip = ip };
            _context.Add(request);
            await _context.SaveChangesAsync();

            return _context.Requests.OrderByDescending(x => x.Id);
        }
    }
}
