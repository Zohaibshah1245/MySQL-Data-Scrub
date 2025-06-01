select * from layoffs;


-- first we will remove duplicates
-- standarized the data
-- get rid of null values and blank vales 
-- remove any coloumns

show tables;
-- we should create a temporary table for data cleaning
create table layoff_staging
like layoffs;

select * from layoff_staging;

insert layoff_staging
select * from layoffs;


-- removing duplicates

select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions)as row_num
from layoff_staging;

with duplicate_cte as(
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions)as row_num
from layoff_staging
)
select * from duplicate_cte 
where row_num>1;

select * from layoff_staging
where company='Casper';


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   row_num int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




select * from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions)as row_num
from layoff_staging;


delete from layoffs_staging2
where row_num>1;

select * from layoffs_staging2
where row_num>1;
select * from layoffs_staging2;


-- standarizing my data
select company from layoffs_staging2;

select company,trim(company)
from layoffs_staging2;

update layoffs_staging2
set company=trim(company);

select distinct industry
from layoffs_staging2;

select distinct industry
from layoffs_staging2
order by 1 ;

select * from layoffs_staging2
where industry like  'Crypto currency%';

update layoffs_staging2
set industry='Crypto'
where industry like 'Crypto currency%';

select distinct industry 
from layoffs_staging2;

update layoffs_staging2
set industry='Crypto'
where industry like 'CryptoCurrency%';

select distinct country 
from layoffs_staging2
order by 1;

update layoffs_staging2
set country='united States'
where   country like 'United States%';

select distinct stage from layoffs_staging2;

select distinct country,trim(country)
from layoffs_staging2
order by 1;


-- updating capital of United States
update layoffs_staging2
set country='United States'
where   country like 'united States%';
 
select distinct country
from layoffs_staging2
order by 1;
select * from layoffs_staging2;


-- changing date format and data type
select date,
str_to_date( date , '%m/%d/%Y')
from layoffs_staging2;

update  layoffs_staging2
set date = str_to_date( date , '%m/%d/%Y');

alter table layoffs_staging2
modify column date DATE;

-- removing null and blank values



 






















