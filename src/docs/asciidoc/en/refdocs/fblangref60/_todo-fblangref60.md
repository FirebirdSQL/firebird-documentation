ToDo List fblangref60
=====================

These are things we'll need to do before fblangref60 is ready for publication.

Please note that these are things we came across or thought of while working on other parts, so it is not a complete list of things that need to be done, but a list of things we _know_ we need to do.

- Revise all "Who Can \<action> On \<object>" sections to account for schema-based privileges
- Document revised grant/revoke syntax
- Add `RDB$SCHEMA_NAME` and similar columns to all relevant system tables
- Add `RDB$SCHEMAS` system table (see if there are any others)
- Add schema-qualification to syntax
  - Check if schema qualification is possible in `RETURNING` clause
- Add and/or revise examples to include schemas
  - Rework examples of plan outputs to account for schema-qualification in output
  - Add examples in DDL `langref-ddl-schema`
- Document scope specifier (done in select, may need its own section?)
- User-defined functions can no longer override built-in functions, see if this needs to be accounted for somewhere
- Document `IN UNLIST(...)`
  - See https://github.com/FirebirdSQL/firebird/pull/8878 (when merged)
- Default keyword in argument list
  - https://github.com/FirebirdSQL/firebird/issues/7566
  - https://github.com/FirebirdSQL/firebird/pull/7557
  - https://github.com/FirebirdSQL/firebird/issues/7586
  - ... possibly some other issues and pull requests
- Call statement
  - https://github.com/FirebirdSQL/firebird/issues/7587 (also has some relation with the previous item syntax-wise)
- Check if `COLLATE` clause can (maybe even should?) be moved to `<scalar_datatype>` definition (in `langref-datatypes-syntax-scalar-syntax`), instead of being scattered around in various places
  - See https://github.com/FirebirdSQL/firebird/pull/7748 
- Check if maximum record size is mentioned anywhere in the language reference to update from 64 KiB to 1 MiB (or maybe mention it somewhere if not)
  - See https://github.com/FirebirdSQL/firebird/pull/7332 
- Document `WITHIN GROUP` (when merged)
  - See https://github.com/FirebirdSQL/firebird/issues/7632
- Document `LISTAGG` (probably best to wait for previous point)
  - See https://github.com/FirebirdSQL/firebird/pull/8689
- Document `PERCENTILE_CONT` and `PERCENTILE_DISC` (when merged)
  - https://github.com/FirebirdSQL/firebird/pull/8807
- Document local temporary tables
  - https://github.com/FirebirdSQL/firebird/issues/1095
- Document `ALTER PACKAGE BODY`/`CREATE OR ALTER PACKAGE BODY`
  - https://github.com/FirebirdSQL/firebird/pull/8309