/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('trichiasis', {
    _id: {
      type: DataTypes.TEXT,
      allowNull: false,
      primaryKey: true
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
    refusedsurgeryl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    providedepilationconsultationl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    visualacuityl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    countlashestouchingeyeballl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    evidenceofepilationl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    photographpreopl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    cataractl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    cornealopacityl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    acceptedsurgeryl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    typeofoperationl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    clampusedl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    suturetypel: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    excessbleedingl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    marginfragmantseveredl: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    globepuncturel: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    complicationsreferrall: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    referralhospitall: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    refusedsurgeryr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    providedepilationconsultationr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    visualacuityr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    countlashestouchingeyeballr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    evidenceofepilationr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    photographpreopr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    cataractr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    cornealopacityr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    acceptedsurgeryr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    typeofoperationr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    clampusedr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    suturetyper: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    excessbleedingr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    marginfragmantseveredr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    globepuncturer: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    complicationsreferralr: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    referralhospitalr: {
      type: DataTypes.TEXT,
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
    tableName:'trichiasis'
  });
};
