exports.up = function(knex, Promise) {
  return knex.schema.createTable('asn_contracts_join', (table) => {
    table.integer('asn_id').references('id').inTable('assassins');
    table.integer('contract_id').references('id').inTable('contracts');
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable('asn_contracts_join');
};
