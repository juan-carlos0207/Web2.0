using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace backend.Models
{
    public class Pagos
    {
        public int id_pago {get; set;}
        public int id_miembro {get; set;}
        public decimal monto {get; set;}
        public DateTime fecha_pago {get; set;}
        public string tipo_pago {get; set;}
        public string comprobante_url {get; set;}
        public string estado {get; set;}

    }
}