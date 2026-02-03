/*--  Use Only if Table Anything Created in Database 
 1. Drop tables if they exist (optional, clean start)

DROP TABLE IF EXISTS public.sales CASCADE;
DROP TABLE IF EXISTS public.currencyexchange CASCADE;
DROP TABLE IF EXISTS public.customer CASCADE;
DROP TABLE IF EXISTS public.product CASCADE;
DROP TABLE IF EXISTS public.store CASCADE;
DROP TABLE IF EXISTS public."date" CASCADE;
*/

--2. Create tables

CREATE TABLE public.currencyexchange (
    date date NOT NULL,
    fromcurrency varchar(10) NOT NULL,
    tocurrency varchar(10) NOT NULL,
    exchange double precision,
    PRIMARY KEY (date, fromcurrency, tocurrency)
);

CREATE TABLE public.customer (
    customerkey integer NOT NULL,
    geoareakey integer,
    startdt date,
    enddt date,
    continent varchar(50),
    gender varchar(10),
    title varchar(20),
    givenname varchar(50),
    middleinitial varchar(5),
    surname varchar(50),
    streetaddress varchar(100),
    city varchar(50),
    state varchar(50),
    statefull varchar(100),
    zipcode varchar(20),
    country varchar(50),
    countryfull varchar(100),
    birthday date,
    age integer,
    occupation varchar(100),
    company varchar(100),
    vehicle varchar(100),
    latitude double precision,
    longitude double precision,
    PRIMARY KEY (customerkey)
);

CREATE TABLE public."date" (
    date date NOT NULL,
    datekey integer,
    year integer,
    yearquarter varchar(20),
    yearquarternumber integer,
    quarter varchar(10),
    yearmonth varchar(20),
    yearmonthshort varchar(20),
    yearmonthnumber integer,
    month varchar(20),
    monthshort varchar(10),
    monthnumber integer,
    dayofweek varchar(20),
    dayofweekshort varchar(10),
    dayofweeknumber integer,
    workingday integer,
    workingdaynumber integer,
    PRIMARY KEY (date)
);

CREATE TABLE public.product (
    productkey integer NOT NULL,
    productcode integer,
    productname varchar(100),
    manufacturer varchar(100),
    brand varchar(50),
    color varchar(30),
    weightunit varchar(10),
    weight double precision,
    cost double precision,
    price double precision,
    categorykey integer,
    categoryname varchar(50),
    subcategorykey integer,
    subcategoryname varchar(50),
    PRIMARY KEY (productkey)
);

CREATE TABLE public.store (
    storekey integer NOT NULL,
    storecode integer,
    geoareakey integer,
    countrycode varchar(10),
    countryname varchar(50),
    state varchar(50),
    opendate date,
    closedate date,
    description varchar(100),
    squaremeters double precision,
    status varchar(20),
    PRIMARY KEY (storekey)
);

CREATE TABLE public.sales(
    orderkey integer NOT NULL,
    linenumber integer NOT NULL,
    orderdate date,
    deliverydate date,
    customerkey integer,
    storekey integer,
    productkey integer,
    quantity integer,
    unitprice double precision,
    netprice double precision,
    unitcost double precision,
    currencycode varchar(10),
    exchangerate double precision,
    PRIMARY KEY (orderkey, linenumber),
    FOREIGN KEY (customerkey) REFERENCES public.customer(customerkey),
    FOREIGN KEY (productkey) REFERENCES public.product(productkey),
    FOREIGN KEY (storekey) REFERENCES public.store(storekey)
);



