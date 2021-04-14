# Terraform Module rds/postgresql

Provisions a PostgreSQL instance managed by AWS RDS.

## Default PostgreSQL instance configuration

* Master user name is a random alphanumeric character sequence.
* Master user password is a random character sequence with supported special characters.
* Storage is encrypted using AWS managed keys.

## TODO's

| TODO | Status |
| --- | --- | 
| add support of customer master keys | open |