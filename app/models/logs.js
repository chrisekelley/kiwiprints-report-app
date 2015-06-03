/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('logs', { 
    _id: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    _rev: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    uuid: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    error: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    model: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    cordova: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    message: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    version: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    platform: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    timestamp: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    collection: {
      type: DataTypes.TEXT,
      allowNull: true,
    }
  });
};
