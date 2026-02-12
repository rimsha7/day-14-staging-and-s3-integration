!set variable_substitution=true;

use database my_db;
use schema my_schema;

create or replace file format csv_format
type = csv
skip_header = 1
field_delimiter = ','
field_optionally_enclosed_by = '"'
null_if = ('null','NULL');

create or replace stage my_s3_stage
url = 's3://day14-snowflake-bucket/sales.csv'
credentials(
    AWS_KEY_ID = '&AWS_KEY_ID'
    AWS_SECRET_KEY = '&AWS_SECRET_KEY'
)
file_format= csv_format;

list @my_s3_stage;

create or replace table sales(
    sale_date date,
    product_category varchar,
    sales_amount number(10,2)
);

copy into sales
from @my_s3_stage;

select * from sales
limit 5;