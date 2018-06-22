
exports.seed = function(knex, Promise) {
  // Deletes ALL existing entries
  return knex('assassins').del()
    .then(function () {
      // Inserts seed entries
      return knex('assassins').insert([
        {id: 1, name: 'Alexander Duggan', weapon: 'Sniper rifle', age: 31, min_price: 45, rating: 7.5, kills: 28, open_contracts: 0},
        {id: 2, name: 'Anton Chigurh', weapon: 'Pneumatic bolt gun', age: 52, min_price: 40, rating: 9, kills: 72, open_contracts: 0},
        {id: 3, name: 'NULL', weapon: 'Pistol', age: 38, min_price: 20, rating: 6.5, kills: 35, open_contracts: 0},
        {id: 4, name: 'Jason Bourne', weapon: 'Parkour', age: 28, min_price: 25, rating: 7, kills: 48, open_contracts: 0},
        {id: 5, name: 'John Wick', weapon: 'Lots of guns', age: 35, min_price: 50, rating: 9.5, kills: 433, open_contracts: 0},
        {id: 6, name: 'Jules Winnfield', weapon: 'Pistol', age: 26, min_price: 15, rating: 6.5, kills: 13, open_contracts: 0},
        {id: 7, name: 'Leon', weapon: 'Everything', age: 41, min_price: 30, rating: 8.5, kills: 87, open_contracts: 0},
        {id: 8, name: 'Nikita Mears', weapon: 'Silenced pistols', age: 28, min_price: 30, rating: 7, kills: 32, open_contracts: 0},
        {id: 9, name: 'Pickle Rick', weapon: 'Lasers and office supplies', age: 60, min_price: 0, rating: 8, kills: 24, open_contracts: 0},
      ]);
    });
};
