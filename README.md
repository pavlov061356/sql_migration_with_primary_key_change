# sql_migration_with_primary_key_change
SQL migration test with changing primary key of a table which is referenced by another table.

## Goals

- Add new column with another type and make it primary key
- UPdate another table to reference new primary key of first table

### Schema before changes

```
postgres=# \d testing
             Table "public.testing"
 Column | Type | Collation | Nullable | Default 
--------+------+-----------+----------+---------
 id     | text |           | not null | 
Indexes:
    "testing_pkey" PRIMARY KEY, btree (id)

postgres=# \d testing2
                            Table "public.testing2"
 Column |  Type   | Collation | Nullable |               Default                
--------+---------+-----------+----------+--------------------------------------
 id     | integer |           | not null | nextval('testing2_id_seq'::regclass)
 ext_id | text    |           |          | 
Indexes:
    "testing2_pkey" PRIMARY KEY, btree (id)
```

### Schema after changes

```
postgres=# \d testing
                                Table "public.testing"
     Column     |  Type   | Collation | Nullable |               Default               
----------------+---------+-----------+----------+-------------------------------------
 new_string_key | text    |           | not null | 
 id             | integer |           | not null | nextval('testing_id_seq'::regclass)
Indexes:
    "testing_pkey" PRIMARY KEY, btree (id)
    "unique_new_string_key" UNIQUE CONSTRAINT, btree (new_string_key)
Referenced by:
    TABLE "testing2" CONSTRAINT "fk_ext_id" FOREIGN KEY (ext_id) REFERENCES testing(id)

postgres=# \d testing2
                                Table "public.testing2"
 Column |  Type   | Collation | Nullable |                   Default                    
--------+---------+-----------+----------+----------------------------------------------
 id     | integer |           | not null | nextval('testing2_id_seq'::regclass)
 ext_id | integer |           | not null | nextval('testing2_new_ext_id_seq'::regclass)
Indexes:
    "testing2_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "fk_ext_id" FOREIGN KEY (ext_id) REFERENCES testing(id)

```
