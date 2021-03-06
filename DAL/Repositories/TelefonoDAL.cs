using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using TFI.FUNCIONES.Persistencia; using TFI.Entidades;

namespace TFI.DAL.DAL
{
	public class TelefonoDAL
	{


		#region Methods

        /// <summary>
        /// Saves a record to the Telefono table.
        /// </summary>
        public void Insert(TelefonoEntidad telefono)
        {
            ValidationUtility.ValidateArgument("telefono", telefono);

            SqlParameter[] parameters = new SqlParameter[]
			{
				new SqlParameter("@cuit", telefono.miUsuario.CUIT),
				new SqlParameter("@NombreUsuario", telefono.miUsuario.NombreUsuario),
				new SqlParameter("@NroTelefono", telefono.NroTelefono),
				new SqlParameter("@CodArea", telefono.CodArea),
				new SqlParameter("@IdTipoTel", telefono.miTipoTel.IdTipoTel)
			};

            SqlClientUtility.ExecuteNonQuery(SqlClientUtility.connectionStringName, CommandType.StoredProcedure, "TelefonoInsert", parameters);
        }

        /// <summary>
        /// Deletes a record from the Telefono table by its primary key.
        /// </summary>
        public void Delete(string cuit, string nombreUsuario, string nroTelefono, string codArea, int idTipoTel)
        {
            SqlParameter[] parameters = new SqlParameter[]
			{
				new SqlParameter("@cuit", cuit),
				new SqlParameter("@NombreUsuario", nombreUsuario),
				new SqlParameter("@NroTelefono", nroTelefono),
				new SqlParameter("@CodArea", codArea),
				new SqlParameter("@IdTipoTel", idTipoTel)
			};

            SqlClientUtility.ExecuteNonQuery(SqlClientUtility.connectionStringName, CommandType.StoredProcedure, "TelefonoDelete", parameters);
        }

        /// <summary>
        /// Deletes a record from the Telefono table by a foreign key.
        /// </summary>
        public void DeleteAllByIdTipoTel(int idTipoTel)
        {
            SqlParameter[] parameters = new SqlParameter[]
			{
				new SqlParameter("@IdTipoTel", idTipoTel)
			};

            SqlClientUtility.ExecuteNonQuery(SqlClientUtility.connectionStringName, CommandType.StoredProcedure, "TelefonoDeleteAllByIdTipoTel", parameters);
        }

        /// <summary>
        /// Deletes a record from the Telefono table by a foreign key.
        /// </summary>
        public void DeleteAllByCUIT_NombreUsuario(string cuit, string nombreUsuario)
        {
            SqlParameter[] parameters = new SqlParameter[]
			{
				new SqlParameter("@cuit", cuit),
				new SqlParameter("@NombreUsuario", nombreUsuario)
			};

            SqlClientUtility.ExecuteNonQuery(SqlClientUtility.connectionStringName, CommandType.StoredProcedure, "TelefonoDeleteAllByCUIT_NombreUsuario", parameters);
        }

        /// <summary>
        /// Selects a single record from the Telefono table.
        /// </summary>
        public TelefonoEntidad Select(string cuit, string nombreUsuario, string nroTelefono, string codArea, int idTipoTel)
        {
            SqlParameter[] parameters = new SqlParameter[]
			{
				new SqlParameter("@cuit", cuit),
				new SqlParameter("@NombreUsuario", nombreUsuario),
				new SqlParameter("@NroTelefono", nroTelefono),
				new SqlParameter("@CodArea", codArea),
				new SqlParameter("@IdTipoTel", idTipoTel)
			};

            using (DataTable dt = SqlClientUtility.ExecuteDataTable(SqlClientUtility.connectionStringName, CommandType.StoredProcedure, "TelefonoSelect", parameters))
            {
                TelefonoEntidad entidad = new TelefonoEntidad();
                //       

                entidad = Mapeador.MapearFirst<TelefonoEntidad>(dt);



                return entidad;
            }
        }



        /// <summary>
        /// Selects all records from the Telefono table by a foreign key.
        /// </summary>
        public List<TelefonoEntidad> SelectAllByIdTipoTel(int idTipoTel)
        {
            SqlParameter[] parameters = new SqlParameter[]
			{
				new SqlParameter("@IdTipoTel", idTipoTel)
			};

            using (DataTable dt = SqlClientUtility.ExecuteDataTable(SqlClientUtility.connectionStringName, CommandType.StoredProcedure, "TelefonoSelectAllByIdTipoTel", parameters))
            {
                List<TelefonoEntidad> lista = new List<TelefonoEntidad>();
                lista = Mapeador.Mapear<TelefonoEntidad>(dt);

                return lista;
            }
        }

        /// <summary>
        /// Selects all records from the Telefono table by a foreign key.
        /// </summary>
        public List<TelefonoEntidad> SelectAllByCUIT_NombreUsuario(string cuit, string nombreUsuario)
        {
            SqlParameter[] parameters = new SqlParameter[]
			{
				new SqlParameter("@cuit", cuit),
				new SqlParameter("@NombreUsuario", nombreUsuario)
			};

            using (DataTable dt = SqlClientUtility.ExecuteDataTable(SqlClientUtility.connectionStringName, CommandType.StoredProcedure, "TelefonoSelectAllByCUIT_NombreUsuario", parameters))
            {
                List<TelefonoEntidad> lista = new List<TelefonoEntidad>();
                lista = Mapeador.Mapear<TelefonoEntidad>(dt);

                return lista;
            }
        }
        public List<TelefonoEntidad> SelectTelefonosDeUsuario(string cuit, string nombreUsuario)
        {
            SqlParameter[] parameters = new SqlParameter[]
			{
				new SqlParameter("@cuit", cuit),
				new SqlParameter("@NombreUsuario", nombreUsuario),
			};

            using (DataSet ds = SqlClientUtility.ExecuteDataSet(SqlClientUtility.connectionStringName, CommandType.StoredProcedure, "TelefonoSelectAllByUsuario", parameters))
            {
                List<TelefonoEntidad> listadetelefonos = new List<TelefonoEntidad>();

                listadetelefonos = MapearMuchos(ds);

                return listadetelefonos;
            }
        }



        private List<TelefonoEntidad> MapearMuchos(DataSet ds)
        {
            List<TelefonoEntidad> ResUnosTel = new List<TelefonoEntidad>();

            try
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    TelefonoEntidad unTel = new TelefonoEntidad();


                    unTel.miUsuario = new UsuarioEntidad();
                    unTel.miUsuario.CUIT = row["CUIT"].ToString();
                    unTel.miUsuario.NombreUsuario = row["NombreUsuario"].ToString();
                    unTel.NroTelefono = row["NroTelefono"].ToString();
                    unTel.CodArea = row["CodArea"].ToString();
                    unTel.miTipoTel = new TipoTelEntidad();
                    unTel.miTipoTel.IdTipoTel = (int)row["IdTipoTel"];
                    if (row["FecBaja"].ToString() != "")
                        unTel.FecBaja = DateTime.Parse(row["FecBaja"].ToString());

                    ResUnosTel.Add(unTel);
                }
                return ResUnosTel;
            }
            catch (Exception es)
            {
                throw;
            }

        }


        /// <summary>
        /// Updates a record in the Tarjeta table.
        /// </summary>
        public void UpdateDatosPersonales(TelefonoEntidad telefono)
        {
            ValidationUtility.ValidateArgument("tarjeta", telefono);

            SqlParameter[] parameters = new SqlParameter[]
			{
				
				new SqlParameter("@cuit", telefono.miUsuario.CUIT),
				new SqlParameter("@NombreUsuario", telefono.miUsuario.NombreUsuario),
				new SqlParameter("@NroTelefono", telefono.NroTelefono),
				new SqlParameter("@IdTipoTel", telefono.miTipoTel.IdTipoTel)
			};

            SqlClientUtility.ExecuteNonQuery(SqlClientUtility.connectionStringName, CommandType.StoredProcedure, "TelefonoUpdateDatosPersonales", parameters);
        }




		#endregion
	}
}
