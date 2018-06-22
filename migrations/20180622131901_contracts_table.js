exports.up = function(knex, Promise) {
  return knex.schema.createTable('contracts', (table) => {
    table.increments();
    table.integer('target').references('id').inTable('assassins');
    table.integer('client').references('id').inTable('clients');
    table.integer('budget');
    table.boolean('complete');
    table.integer('completed_by').references('id').inTable('assassins').nullable();
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable('contracts');
};
