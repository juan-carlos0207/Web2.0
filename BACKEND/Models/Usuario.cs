using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Models
{
    public class Usuario
    {
        public int id_usuario {get; set;}
        public int id_miembro {get; set;}
        public string username {get; set;}
        public string password_hash {get; set;}
        public string rol {get; set;}
        public DateTime fecha_creacion { get; set; }
        public DateTime ultimo_acceso { get; set; }
    }
}