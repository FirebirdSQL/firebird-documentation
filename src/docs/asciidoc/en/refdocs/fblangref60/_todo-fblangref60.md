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
- User-defined functions can no longer override built-in functions, see if this needs to be accounted for somewhere
- Document `UNLIST`
- Default keyword in argument list
  - https://github.com/FirebirdSQL/firebird/issues/7566
  - https://github.com/FirebirdSQL/firebird/pull/7557
  - https://github.com/FirebirdSQL/firebird/issues/7586
  - ... possibly some other issues and pull requests
- Call statement
  - https://github.com/FirebirdSQL/firebird/issues/7587 (also has some relation with the previous item syntax-wise)
