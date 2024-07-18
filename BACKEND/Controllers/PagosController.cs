using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend.Models;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;

namespace backend.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PagosController : ControllerBase
    {
        public readonly string con;

        public PagosController(IConfiguration configuration)
        {
            con = configuration.GetConnectionString("conexion");
        } 
         [HttpGet]
        public IEnumerable<Pagos> Get()
        {
            List<Pagos> pagos = new();
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("ListarPago",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader() )
                    {
                        while (reader.Read())
                        {
                            Pagos p = new Pagos{
                                id_pago = Convert.ToInt32(reader["id_pago"]),
                                id_miembro = Convert.ToInt32(reader["id_miembro"]),
                                monto = Convert.ToDecimal(reader["monto"]),
                                fecha_pago = Convert.ToDateTime(reader["fecha_pago"]),
                                tipo_pago = reader["tipo_pago"].ToString(),
                                comprobante_url = reader["comprobante_url"].ToString(),
                                estado = reader["estado"].ToString()

                            };
                            pagos.Add(p);
                        }
                    }
                }
            } 
            return pagos;
        }
        [HttpPost]
        public void Post([FromBody] Pagos p)
        {
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("InsertarPago",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_pago",p.id_pago);
                    cmd.Parameters.AddWithValue("@id_miembro",p.id_miembro);
                    cmd.Parameters.AddWithValue("@monto",p.monto);
                    cmd.Parameters.AddWithValue("@fecha_pago",p.fecha_pago);
                    cmd.Parameters.AddWithValue("@tipo_pago",p.tipo_pago);
                    cmd.Parameters.AddWithValue("@comprobante_url",p.comprobante_url);
                    cmd.Parameters.AddWithValue("@estado",p.estado);
                    cmd.ExecuteNonQuery();
                }
            } 
        }
        [HttpPut("{id_pago}")]
        public void Put([FromBody] Pagos p, int id_pago)
        {
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("ModificarPago",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_pago",id_pago);
                    cmd.Parameters.AddWithValue("@id_miembro",p.id_miembro);
                    cmd.Parameters.AddWithValue("@monto",p.monto);
                    cmd.Parameters.AddWithValue("@fecha_pago",p.fecha_pago);
                    cmd.Parameters.AddWithValue("@tipo_pago",p.tipo_pago);
                    cmd.Parameters.AddWithValue("@comprobante_url",p.comprobante_url);
                    cmd.Parameters.AddWithValue("@estado",p.estado);
                    cmd.ExecuteNonQuery();
                }
            } 
        }
        [HttpDelete("{id_pago}")]
        public void Delete(int id_pago)
        {
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("EliminarPago",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_pago",id_pago);
                    cmd.ExecuteNonQuery();
                }
            } 
        }
    }
}