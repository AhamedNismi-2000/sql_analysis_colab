
-- Create Table for Cuurency Exchange 
CREATE TABLE public.currencyexchange (
    date date NOT NULL,
    fromcurrency character varying(10) NOT NULL,
    tocurrency character varying(10) NOT NULL,
    exchange double precision
);
