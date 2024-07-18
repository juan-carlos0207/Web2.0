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
    public class UsuariosController : ControllerBase
    {
        public readonly string con;

        public UsuariosController(IConfiguration configuration)
        {
            con = configuration.GetConnectionString("conexion");
        } 

        [HttpGet]
        public IEnumerable<Usuario> Get()
        {
            List<Usuario> usuarios = new();
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("ListarUsuarios",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    using (SqlDataReader reader = cmd.ExecuteReader() )
                    {
                        while (reader.Read())
                        {
                            Usuario u = new Usuario{
                                id_usuario = Convert.ToInt32(reader["id_usuario"]),
                                id_miembro = Convert.ToInt32(reader["id_miembro"]),
                                username = reader["username"].ToString(),
                                password_hash = reader["password_hash"].ToString(),
                                rol = reader["rol"].ToString(),
                                fecha_creacion = Convert.ToDateTime(reader["fecha_creacion"]),
                                ultimo_acceso = Convert.ToDateTime(reader["ultimo_acceso"])
                            };
                            usuarios.Add(u);
                        }
                    }
                }
            } 
            return usuarios;
        }
        [HttpPost]
        public void Post([FromBody] Usuario u)
        {
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("InsertarUsuario",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_usuario",u.id_usuario);
                    cmd.Parameters.AddWithValue("@id_miembro",u.id_miembro);
                    cmd.Parameters.AddWithValue("@username",u.username);
                    cmd.Parameters.AddWithValue("@password_hash",u.password_hash);
                    cmd.Parameters.AddWithValue("@rol",u.rol);
                    cmd.Parameters.AddWithValue("@fecha_creacion",u.fecha_creacion);
                    cmd.Parameters.AddWithValue("@ultimo_acceso",u.ultimo_acceso);
                    cmd.ExecuteNonQuery();

                }
            } 
        }
        [HttpPut("{id_usuario}")]
        public void Put([FromBody] Usuario u, int id_usuario)
        {
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("ModificarUsuario",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_usuario",id_usuario);
                    cmd.Parameters.AddWithValue("@id_miembro",u.id_miembro);
                    cmd.Parameters.AddWithValue("@username",u.username);
                    cmd.Parameters.AddWithValue("@password_hash",u.password_hash);
                    cmd.Parameters.AddWithValue("@rol",u.rol);
                    cmd.Parameters.AddWithValue("@fecha_creacion",u.fecha_creacion);
                    cmd.Parameters.AddWithValue("@ultimo_acceso",u.ultimo_acceso);
                    cmd.ExecuteNonQuery();
                }
            } 
        }
        [HttpDelete("{id_usuario}")]
        public void Delete(int id_usuario)
        {
            using (SqlConnection connection = new (con))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("EliminarUsuario",connection))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id_usuario",id_usuario);
                    cmd.ExecuteNonQuery();
                }
            } 
        }
   
    }
}