/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('prints', {
    template: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    finger: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    _id: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    serviceUuid: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    clientId: {
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
    district: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    currentDistrict: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    gps_name: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    SimprintsThreshold: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    SimprintsStatusCode: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    SimprintsUID: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    SimprintsError: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    kiwicreatedat: {
      type: DataTypes.DATE,
      allowNull: true,
    },
    kiwilastmodifiedat: {
      type: DataTypes.DATE,
      allowNull: true,
    }
  },{
  });
};
