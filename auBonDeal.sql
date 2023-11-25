--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Ubuntu 16.1-1.pgdg22.04+1)
-- Dumped by pg_dump version 16.1 (Ubuntu 16.1-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: get_current_user_id(); Type: FUNCTION; Schema: public; Owner: tmnpierre
--

CREATE FUNCTION public.get_current_user_id() RETURNS integer
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    user_id INTEGER;
BEGIN
    SELECT userId INTO user_id FROM users WHERE userName = current_user;
    RETURN user_id;
END;
$$;


ALTER FUNCTION public.get_current_user_id() OWNER TO tmnpierre;

--
-- Name: hash_user_password(); Type: FUNCTION; Schema: public; Owner: tmnpierre
--

CREATE FUNCTION public.hash_user_password() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF TG_OP = 'INSERT' OR NEW.userPassword <> OLD.userPassword THEN
    NEW.userPassword := crypt(NEW.userPassword, gen_salt('bf'));
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.hash_user_password() OWNER TO tmnpierre;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: tmnpierre
--

CREATE TABLE public.orders (
    orderid integer NOT NULL,
    userid integer,
    ordertotalcostht numeric(10,2),
    ordertotalquantity integer,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deliverat timestamp without time zone,
    CONSTRAINT orders_ordertotalcostht_check CHECK ((ordertotalcostht > (0)::numeric)),
    CONSTRAINT orders_ordertotalquantity_check CHECK ((ordertotalquantity > 0))
);


ALTER TABLE public.orders OWNER TO tmnpierre;

--
-- Name: orders_orderid_seq; Type: SEQUENCE; Schema: public; Owner: tmnpierre
--

CREATE SEQUENCE public.orders_orderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_orderid_seq OWNER TO tmnpierre;

--
-- Name: orders_orderid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tmnpierre
--

ALTER SEQUENCE public.orders_orderid_seq OWNED BY public.orders.orderid;


--
-- Name: products; Type: TABLE; Schema: public; Owner: tmnpierre
--

CREATE TABLE public.products (
    productid integer NOT NULL,
    productname character varying(255) NOT NULL,
    productdescription text,
    productprice numeric(10,2),
    productquantity integer,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT products_productprice_check CHECK ((productprice > (0)::numeric)),
    CONSTRAINT products_productquantity_check CHECK ((productquantity >= 0))
);


ALTER TABLE public.products OWNER TO tmnpierre;

--
-- Name: products_productid_seq; Type: SEQUENCE; Schema: public; Owner: tmnpierre
--

CREATE SEQUENCE public.products_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_productid_seq OWNER TO tmnpierre;

--
-- Name: products_productid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tmnpierre
--

ALTER SEQUENCE public.products_productid_seq OWNED BY public.products.productid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: tmnpierre
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(255) NOT NULL,
    userpassword text NOT NULL,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO tmnpierre;

--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: tmnpierre
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_userid_seq OWNER TO tmnpierre;

--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tmnpierre
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- Name: orders orderid; Type: DEFAULT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.orders ALTER COLUMN orderid SET DEFAULT nextval('public.orders_orderid_seq'::regclass);


--
-- Name: products productid; Type: DEFAULT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.products ALTER COLUMN productid SET DEFAULT nextval('public.products_productid_seq'::regclass);


--
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: tmnpierre
--

COPY public.orders (orderid, userid, ordertotalcostht, ordertotalquantity, createdat, deliverat) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: tmnpierre
--

COPY public.products (productid, productname, productdescription, productprice, productquantity, createdat, updatedat) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: tmnpierre
--

COPY public.users (userid, username, userpassword, isactive, createdat, updatedat) FROM stdin;
\.


--
-- Name: orders_orderid_seq; Type: SEQUENCE SET; Schema: public; Owner: tmnpierre
--

SELECT pg_catalog.setval('public.orders_orderid_seq', 1, false);


--
-- Name: products_productid_seq; Type: SEQUENCE SET; Schema: public; Owner: tmnpierre
--

SELECT pg_catalog.setval('public.products_productid_seq', 1, false);


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: tmnpierre
--

SELECT pg_catalog.setval('public.users_userid_seq', 1, false);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (orderid);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (productid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: users trigger_hash_user_password; Type: TRIGGER; Schema: public; Owner: tmnpierre
--

CREATE TRIGGER trigger_hash_user_password BEFORE INSERT OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.hash_user_password();


--
-- Name: orders orders_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: orders; Type: ROW SECURITY; Schema: public; Owner: tmnpierre
--

ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;

--
-- Name: orders user_access; Type: POLICY; Schema: public; Owner: tmnpierre
--

CREATE POLICY user_access ON public.orders USING ((userid = public.get_current_user_id())) WITH CHECK ((userid = public.get_current_user_id()));


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: tmnpierre
--

GRANT SELECT ON TABLE public.orders TO readonly;
GRANT INSERT,UPDATE ON TABLE public.orders TO writeonly;


--
-- Name: TABLE products; Type: ACL; Schema: public; Owner: tmnpierre
--

GRANT SELECT ON TABLE public.products TO readonly;
GRANT INSERT,UPDATE ON TABLE public.products TO writeonly;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: tmnpierre
--

GRANT SELECT ON TABLE public.users TO readonly;
GRANT INSERT,UPDATE ON TABLE public.users TO writeonly;


--
-- PostgreSQL database dump complete
--

