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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: current_user_uuid(); Type: FUNCTION; Schema: public; Owner: tmnpierre
--

CREATE FUNCTION public.current_user_uuid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
SELECT user_uuid FROM public.users WHERE username = current_user;
$$;


ALTER FUNCTION public.current_user_uuid() OWNER TO tmnpierre;

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

--
-- Name: log_order_inserts(); Type: FUNCTION; Schema: public; Owner: tmnpierre
--

CREATE FUNCTION public.log_order_inserts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO audit_logs (action_type, performed_by, details)
    VALUES ('INSERT', current_user, 'Insert into orders');
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_order_inserts() OWNER TO tmnpierre;

--
-- Name: user_has_role(integer, character varying); Type: FUNCTION; Schema: public; Owner: tmnpierre
--

CREATE FUNCTION public.user_has_role(user_id integer, role_name character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    has_role BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1 FROM user_roles UR
        JOIN roles R ON UR.role_id = R.role_id
        WHERE UR.user_id = user_id AND R.role_name = role_name
    ) INTO has_role;

    RETURN has_role;
END;
$$;


ALTER FUNCTION public.user_has_role(user_id integer, role_name character varying) OWNER TO tmnpierre;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: tmnpierre
--

CREATE TABLE public.audit_logs (
    log_id integer NOT NULL,
    action_type character varying(255),
    performed_by character varying(255),
    performed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    details text
);


ALTER TABLE public.audit_logs OWNER TO tmnpierre;

--
-- Name: audit_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: tmnpierre
--

CREATE SEQUENCE public.audit_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_logs_log_id_seq OWNER TO tmnpierre;

--
-- Name: audit_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tmnpierre
--

ALTER SEQUENCE public.audit_logs_log_id_seq OWNED BY public.audit_logs.log_id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: tmnpierre
--

CREATE TABLE public.order_items (
    order_item_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    order_number uuid,
    product_uuid uuid,
    quantity integer NOT NULL,
    CONSTRAINT order_items_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.order_items OWNER TO tmnpierre;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: tmnpierre
--

CREATE TABLE public.orders (
    order_number uuid DEFAULT gen_random_uuid() NOT NULL,
    order_total_cost_ht numeric(10,2),
    order_total_quantity integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deliver_at timestamp without time zone,
    user_uuid uuid,
    CONSTRAINT orders_order_total_cost_ht_check CHECK ((order_total_cost_ht > (0)::numeric)),
    CONSTRAINT orders_order_total_quantity_check CHECK ((order_total_quantity > 0))
);


ALTER TABLE public.orders OWNER TO tmnpierre;

--
-- Name: products; Type: TABLE; Schema: public; Owner: tmnpierre
--

CREATE TABLE public.products (
    product_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    product_name character varying(255) NOT NULL,
    product_description text,
    product_price numeric(10,2),
    product_quantity integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_product_price_nonnegative CHECK ((product_price >= (0)::numeric)),
    CONSTRAINT check_product_quantity_nonnegative CHECK ((product_quantity >= 0)),
    CONSTRAINT products_product_price_check CHECK ((product_price > (0)::numeric)),
    CONSTRAINT products_product_quantity_check CHECK ((product_quantity >= 0))
);


ALTER TABLE public.products OWNER TO tmnpierre;

--
-- Name: users; Type: TABLE; Schema: public; Owner: tmnpierre
--

CREATE TABLE public.users (
    user_uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    user_pseudo character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    user_password text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO tmnpierre;

--
-- Name: audit_logs log_id; Type: DEFAULT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN log_id SET DEFAULT nextval('public.audit_logs_log_id_seq'::regclass);


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: tmnpierre
--

COPY public.audit_logs (log_id, action_type, performed_by, performed_at, details) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: tmnpierre
--

COPY public.order_items (order_item_uuid, order_number, product_uuid, quantity) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: tmnpierre
--

COPY public.orders (order_number, order_total_cost_ht, order_total_quantity, created_at, deliver_at, user_uuid) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: tmnpierre
--

COPY public.products (product_uuid, product_name, product_description, product_price, product_quantity, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: tmnpierre
--

COPY public.users (user_uuid, user_pseudo, username, user_password, created_at) FROM stdin;
\.


--
-- Name: audit_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tmnpierre
--

SELECT pg_catalog.setval('public.audit_logs_log_id_seq', 1, false);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (log_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_uuid);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_number);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_uuid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_uuid);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_orders_created_at; Type: INDEX; Schema: public; Owner: tmnpierre
--

CREATE INDEX idx_orders_created_at ON public.orders USING btree (created_at);


--
-- Name: idx_users_username; Type: INDEX; Schema: public; Owner: tmnpierre
--

CREATE INDEX idx_users_username ON public.users USING btree (username);


--
-- Name: users trigger_hash_user_password; Type: TRIGGER; Schema: public; Owner: tmnpierre
--

CREATE TRIGGER trigger_hash_user_password BEFORE INSERT OR UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.hash_user_password();


--
-- Name: orders trigger_order_inserts; Type: TRIGGER; Schema: public; Owner: tmnpierre
--

CREATE TRIGGER trigger_order_inserts AFTER INSERT ON public.orders FOR EACH ROW EXECUTE FUNCTION public.log_order_inserts();


--
-- Name: order_items order_items_order_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_number_fkey FOREIGN KEY (order_number) REFERENCES public.orders(order_number);


--
-- Name: order_items order_items_product_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_uuid_fkey FOREIGN KEY (product_uuid) REFERENCES public.products(product_uuid);


--
-- Name: orders orders_user_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tmnpierre
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_uuid_fkey FOREIGN KEY (user_uuid) REFERENCES public.users(user_uuid) ON DELETE SET NULL;


--
-- Name: products all_view_products; Type: POLICY; Schema: public; Owner: tmnpierre
--

CREATE POLICY all_view_products ON public.products FOR SELECT USING (true);


--
-- Name: orders; Type: ROW SECURITY; Schema: public; Owner: tmnpierre
--

ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;

--
-- Name: products; Type: ROW SECURITY; Schema: public; Owner: tmnpierre
--

ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

--
-- Name: orders user_modify_own_orders; Type: POLICY; Schema: public; Owner: tmnpierre
--

CREATE POLICY user_modify_own_orders ON public.orders USING ((user_uuid = public.current_user_uuid())) WITH CHECK ((user_uuid = public.current_user_uuid()));


--
-- Name: orders user_view_own_orders; Type: POLICY; Schema: public; Owner: tmnpierre
--

CREATE POLICY user_view_own_orders ON public.orders FOR SELECT USING ((user_uuid = public.current_user_uuid()));


--
-- Name: products view_products; Type: POLICY; Schema: public; Owner: tmnpierre
--

CREATE POLICY view_products ON public.products FOR SELECT USING ((CURRENT_USER = 'product_manager'::name));


--
-- Name: FUNCTION current_user_uuid(); Type: ACL; Schema: public; Owner: tmnpierre
--

GRANT ALL ON FUNCTION public.current_user_uuid() TO admin_role;


--
-- Name: FUNCTION get_current_user_id(); Type: ACL; Schema: public; Owner: tmnpierre
--

GRANT ALL ON FUNCTION public.get_current_user_id() TO admin_role;


--
-- Name: FUNCTION hash_user_password(); Type: ACL; Schema: public; Owner: tmnpierre
--

REVOKE ALL ON FUNCTION public.hash_user_password() FROM PUBLIC;
GRANT ALL ON FUNCTION public.hash_user_password() TO admin_role;


--
-- Name: FUNCTION user_has_role(user_id integer, role_name character varying); Type: ACL; Schema: public; Owner: tmnpierre
--

REVOKE ALL ON FUNCTION public.user_has_role(user_id integer, role_name character varying) FROM PUBLIC;
GRANT ALL ON FUNCTION public.user_has_role(user_id integer, role_name character varying) TO admin_role;


--
-- Name: TABLE order_items; Type: ACL; Schema: public; Owner: tmnpierre
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.order_items TO user_role;
GRANT ALL ON TABLE public.order_items TO admin_role;


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: tmnpierre
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.orders TO user_role;
GRANT ALL ON TABLE public.orders TO admin_role;
GRANT SELECT,INSERT,UPDATE ON TABLE public.orders TO order_manager;


--
-- Name: TABLE products; Type: ACL; Schema: public; Owner: tmnpierre
--

GRANT SELECT ON TABLE public.products TO user_role;
GRANT ALL ON TABLE public.products TO admin_role;
GRANT SELECT,INSERT,UPDATE ON TABLE public.products TO product_manager;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: tmnpierre
--

GRANT SELECT ON TABLE public.users TO user_role;
GRANT ALL ON TABLE public.users TO admin_role;
GRANT SELECT,INSERT,UPDATE ON TABLE public.users TO user_manager;


--
-- PostgreSQL database dump complete
--

