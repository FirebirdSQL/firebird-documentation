ToDo List fblangref60
=====================

These are things we'll need to do before fblangref60 is ready for publication.

Please note that these are things we came across or thought of while working on other parts, so it is not a complete list of things that need to be done, but a list of things we _know_ we need to do.

- Revise all "Who Can \<action> On \<object>" sections to account for schema-based privileges
- Document revised grant/revoke syntax
- Add `RDB$SCHEMA_NAME` and similar columns to all relevant system tables
- Add `RDB$SCHEMAS` system table (see if there are any others)
- Add `RDB$SQL` package
- Add schema-qualification to syntax
  - Check if schema qualification is possible in `RETURNING` clause
- Add and/or revise examples to include schemas
  - Rework examples of plan outputs to account for schema-qualification in output
  - Add examples in DDL `langref-ddl-schema`
- Document scope specifier (done in select, may need its own section?)
- Document `CALL` syntax
- Document `IF [NOT] EXISTS` DDL clause (is it available for everything?)
- User-defined functions can no longer override built-in functions, see if this needs to be accounted for somewhere
- Document `UNLIST`
- Document `GREATEST`/`LEAST`
- Document range-based `FOR`
- Document `ACTIVE`/`INACTIVE` for `CREATE INDEX`
