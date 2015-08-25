/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('indiv_reg', {
    _id: {
      type: DataTypes.TEXT,
      allowNull: false,
      primaryKey: true
    },
    _rev: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    district: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    gender: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    dob: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    registrationlocation: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    previouslyregisterrednowoffline: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    question: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    collection: {
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
    },
    complete: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    currentdistrict: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    savedby: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    clientid: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    version_code: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    serviceuuid: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    createdByOfflineUser: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    latitude: {
      type: 'DOUBLE PRECISION',
      allowNull: true,
      },
    longitude: {
      type: 'DOUBLE PRECISION',
      allowNull: true,
      },
    gps_timestamp: {
      type: DataTypes.DATE,
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
    deviceUuid: {
      type: DataTypes.TEXT,
      allowNull: true,
      }
  },{
    timestamps: false,
    freezeTableName:true,
    tableName:'indiv_reg'
    });
};
