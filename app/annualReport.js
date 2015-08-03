/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('annualReport', {
    countProperty: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    currentDistrict: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    gender: {
      type: DataTypes.TEXT,
      allowNull: true,
    }
  },{
    timestamps: false,
    freezeTableName:true,
    tableName:'annualReport'
    });
};
