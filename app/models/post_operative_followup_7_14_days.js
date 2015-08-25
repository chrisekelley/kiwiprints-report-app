/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('post_operative_followup_7_14_days', {
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
    defectseyelidl: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    defectseyelidr: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    granulomaexcisionl: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    granulomaexcisionr: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    granulomal: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    granulomar: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    infectionl: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    infectionr: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    numberreturnindaysmonthsl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    numberreturnindaysmonthsr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    referredtohospitall: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    referredtohospitalr: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    referredtohospitaltextl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    referredtohospitaltextr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    removalofsuturesl: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    removalofsuturesr: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    returnforfollowupl: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    returnforfollowupr: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    returnindaysmonthsl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    returnindaysmonthsr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    subcorrectionl: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    subcorrectionr: {
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
  });
};
