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
    public class MiembrosController : ControllerBase
    {
        public readonly string con;

        public MiembrosController(IConfiguration configuration)
        {
            con = configuration.GetConnectionString("conexion");
        } 
        [HttpGet]
        public IEnumerable<Miembros> Get()
        {
            List<Miembros> miembros = new();
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("ListarMiembros",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader() )
                    {
                        while (reader.Read())
                        {
                            Miembros m = new Miembros{
                                id_miembro = Convert.ToInt32(reader["id_miembro"]),
                                dni = reader["dni"].ToString(),
                                nombres = reader["nombres"].ToString(),
                                apellidos = reader["apellidos"].ToString(),
                                fecha_nacimiento = Convert.ToDateTime(reader["fecha_nacimiento"]),
                                direccion = reader["direccion"].ToString(),
                                email = reader["email"].ToString(),
                                telefono = reader["telefono"].ToString(),
                                universidad = reader["universidad"].ToString(),
                                titulo = reader["titulo"].ToString(),
                                fecha_graduacion = Convert.ToDateTime(reader["fecha_graduacion"]),
                                foto_url = reader["foto_url"].ToString(),
                                estado = reader["estado"].ToString(),
                                fecha_registro = Convert.ToDateTime(reader["fecha_registro"])
                            };
                            miembros.Add(m);
                        }
                    }
                }
            } 
            return miembros;
        }
         [HttpPost]
        public void Post([FromBody] Miembros m)
        {
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("InsertarMiembro",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_miembro",m.id_miembro);
                    cmd.Parameters.AddWithValue("@dni",m.dni);
                    cmd.Parameters.AddWithValue("@nombres",m.nombres);
                    cmd.Parameters.AddWithValue("@apellidos",m.apellidos);
                    cmd.Parameters.AddWithValue("@fecha_nacimiento",m.fecha_nacimiento);
                    cmd.Parameters.AddWithValue("@direccion",m.direccion);
                    cmd.Parameters.AddWithValue("@email",m.email);
                    cmd.Parameters.AddWithValue("@telefono",m.telefono);
                    cmd.Parameters.AddWithValue("@universidad",m.universidad);
                    cmd.Parameters.AddWithValue("@titulo",m.titulo);
                    cmd.Parameters.AddWithValue("@fecha_graduacion",m.fecha_graduacion);
                    cmd.Parameters.AddWithValue("@foto_url",m.foto_url);
                    cmd.Parameters.AddWithValue("@estado",m.estado);
                    cmd.Parameters.AddWithValue("@fecha_registro",m.fecha_registro);
                    cmd.ExecuteNonQuery();
                }
            } 
        }
        [HttpPut("{id}")]
        public void Put([FromBody] Miembros m, int id)
        {
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("ModificarMiembro",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_miembro",m.id_miembro);
                    cmd.Parameters.AddWithValue("@dni",m.dni);
                    cmd.Parameters.AddWithValue("@nombres",m.nombres);
                    cmd.Parameters.AddWithValue("@apellidos",m.apellidos);
                    cmd.Parameters.AddWithValue("@fecha_nacimiento",m.fecha_nacimiento);
                    cmd.Parameters.AddWithValue("@direccion",m.direccion);
                    cmd.Parameters.AddWithValue("@email",m.email);
                    cmd.Parameters.AddWithValue("@telefono",m.telefono);
                    cmd.Parameters.AddWithValue("@universidad",m.universidad);
                    cmd.Parameters.AddWithValue("@titulo",m.titulo);
                    cmd.Parameters.AddWithValue("@fecha_graduacion",m.fecha_graduacion);
                    cmd.Parameters.AddWithValue("@foto_url",m.foto_url);
                    cmd.Parameters.AddWithValue("@estado",m.estado);
                    cmd.Parameters.AddWithValue("@fecha_registro",m.fecha_registro);
                    cmd.ExecuteNonQuery();
                }
            } 
        }
        [HttpDelete("{id_miembro}")]
        public void Delete(int id_miembro)
        {
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("EliminarMiembro",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_miembro",id_miembro);
                    cmd.ExecuteNonQuery();
                }
            } 
        }
    }
}