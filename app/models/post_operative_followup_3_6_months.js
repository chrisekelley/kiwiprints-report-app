/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('post_operative_followup_3_6_months', {
    _id: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    _rev: {
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
    servicelocation: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    dateofvisit: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    timeofvisit: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    countlashestouchingeyeballl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    countlashestouchingeyeballr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    outcomel: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    outcomer: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    patientdevelopedtrichiasisl: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    patientdevelopedtrichiasisr: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    complete: {
      type: DataTypes.BOOLEAN,
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
    gpsCity: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    deviceUuid: {
      type: DataTypes.TEXT,
      allowNull: true,
    }
  });
};
