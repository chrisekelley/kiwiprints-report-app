/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('gps_cache', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true // Automatically gets converted to SERIAL for postgres
    },
    latitude: {
      type: 'DOUBLE PRECISION',
      allowNull: true,
    },
    longitude: {
      type: 'DOUBLE PRECISION',
      allowNull: true,
    },
    gpslat: {
      type: 'DOUBLE PRECISION',
      allowNull: true,
    },
    gpslong: {
      type: 'DOUBLE PRECISION',
      allowNull: true,
    },
    gps_name: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    gps_city: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    gps_country: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    gpserror: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    gpsservice: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    createdat: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    lastmodifiedat: {
      type: DataTypes.DATE,
      allowNull: true,
    }
  },{
    timestamps: false,
    tableName: 'gps_cache'
  });
};
