-- Snippets
local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

ls.add_snippets('sqlx', {

  -- declaration({
  --   database: "DATABASE",
  --   schema: "SCHEMA",
  --   name: "NAME",
  -- })
  s('dec', {
    t { 'config {', '\t' },

    t { 'type: "declaration",', '\t' },

    t 'database: "',
    i(1, 'DATABASE'),
    t { '",', '\t' },

    t 'schema: "',
    i(2, 'SCHEMA'),
    t { '",', '\t' },

    t 'name: "',
    i(3, 'NAME'),
    t { '",', '' },

    t '}',
  }),
  s('config', {
    t { 'config {', '\t' },

    t { 'type: "' },
    c(1, {
      t 'table',
      t 'incremental',
      t 'view',
      t 'materialized',
    }),
    t { '",', '\t' },

    t 'description: "',
    i(2, 'what data is going to be stored in this model'),
    t { '",', '\t' },

    t { 'tags: [],', '\t' },

    t 'schema: "',
    i(3, 'what schema (dataset) to store this model in'),
    t { '"', '' },

    t '}',
  }),
})
