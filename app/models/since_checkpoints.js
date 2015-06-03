/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('since_checkpoints', { 
    pgtable: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    since: {
      type: 'NUMERIC',
      allowNull: true,
      defaultValue: '0'
    },
    enabled: {
      type: DataTypes.BOOLEAN,
      allowNull: true,
      defaultValue: false
    }
  });
};
