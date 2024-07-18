using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Models
{
    public class Renovaciones
    {
        public int id_renovacion {get; set;}
        public int id_miembro {get; set;}
        public int id_pago {get; set;}
        public int id_documento {get; set;}
        public DateTime fecha_solicitud {get; set;}
        public DateTime fecha_aprobacion {get; set;}
        public string estado {get; set;}

    }
}