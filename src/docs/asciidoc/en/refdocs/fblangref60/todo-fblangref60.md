ToDo List fblangref60
=====================

These are things we'll need to do before fblangref60 is ready for publication.

Please note that these are things we came across or thought of while working on other parts, so it is not a complete list of things that need to be done, but a list of things we _know_ we need to do.

- Revise all "Who Can \<action> On \<object>" sections to account for schema-based privileges
- Document revised grant/revoke syntax
- Add `RDB$SCHEMA_NAME` and similar columns to all relevant system tables
- Add `RDB$SCHEMAS` system table (see if there are nay others)
- Add `RDB$SQL` package
- Add schema-qualification to syntax
- Add examples in DDL `langref-ddl-schema`
- Add and/or revise examples to include schemas
- Remove multi-file database syntax and descriptions
- Document `SET SEARCH_PATH TO`
- Document `CURRENT_SCHEMA`
- Document scope specifier
- Document `CALL` syntax
- Document cast-format syntax
- Document `IF [NOT] EXISTS` DDL clause (is it available for everything?)
- User-defined functions can no longer override built-in functions, see if this needs to be accounted for somewhere