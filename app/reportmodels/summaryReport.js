/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('summaryReport', {
    refusedsurgeryr: {
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
    tableName:'summaryReport'
    });
};
