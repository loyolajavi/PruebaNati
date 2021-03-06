using System;

namespace TFI.Entidades
{
	public class LenguajeControlEntidad
	{

		#region Properties
		/// <summary>
		/// Gets or sets the Texto value.
		/// </summary>
		public string Texto { get; set; }

		/// <summary>
		/// Gets or sets the IdLenguaje value.
		/// </summary>
		public int IdLenguaje { get; set; }
        public LenguajeEntidad miLenguaje { get; set; }

		/// <summary>
		/// Gets or sets the Valor value.
		/// </summary>
		public string Valor { get; set; }

        public string CUIT { get; set; }

		/// <summary>
		/// Gets or sets the FecBaja value.
		/// </summary>
		public DateTime? FecBaja { get; set; }

		#endregion
	}
}
