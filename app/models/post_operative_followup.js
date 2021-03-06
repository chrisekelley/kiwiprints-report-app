/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('post_operative_followup', {
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
    completedtreatment: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    complicationsreferralr: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    complicationsrefertoclinichospital: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    continuemonitoring: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    followupdate: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    nameofprocedurebeingfollowed: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    recurrence: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
    },
    referralhospitalr: {
      type: DataTypes.TEXT,
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
  },{
    timestamps: false,
    tableName: 'post_operative_followup'
  });
};
