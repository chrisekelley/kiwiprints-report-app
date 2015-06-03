/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('couchdocs', { 
    id: {
      type: DataTypes.TEXT,
      allowNull: false,
    },
    doc: {
      type: 'JSONB',
      allowNull: true,
    }
  });
};
