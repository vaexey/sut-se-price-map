--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2

-- Started on 2025-01-27 18:22:01 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16385)
-- Name: sut_se_price_map; Type: SCHEMA; Schema: -; Owner: docker
--

CREATE SCHEMA sut_se_price_map;


ALTER SCHEMA sut_se_price_map OWNER TO docker;

--
-- TOC entry 862 (class 1247 OID 16387)
-- Name: attachement_type; Type: TYPE; Schema: sut_se_price_map; Owner: docker
--

CREATE TYPE sut_se_price_map.attachement_type AS ENUM (
    'IMAGE',
    'VIDEO'
);


ALTER TYPE sut_se_price_map.attachement_type OWNER TO docker;

--
-- TOC entry 865 (class 1247 OID 16392)
-- Name: contrib_status; Type: TYPE; Schema: sut_se_price_map; Owner: docker
--

CREATE TYPE sut_se_price_map.contrib_status AS ENUM (
    'ACTIVE',
    'REVOKED',
    'REMOVED'
);


ALTER TYPE sut_se_price_map.contrib_status OWNER TO docker;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16399)
-- Name: attachement; Type: TABLE; Schema: sut_se_price_map; Owner: docker
--

CREATE TABLE sut_se_price_map.attachement (
    id integer NOT NULL,
    type sut_se_price_map.attachement_type NOT NULL,
    resource integer NOT NULL,
    title text
);


ALTER TABLE sut_se_price_map.attachement OWNER TO docker;

--
-- TOC entry 219 (class 1259 OID 16404)
-- Name: attachement_id_seq; Type: SEQUENCE; Schema: sut_se_price_map; Owner: docker
--

CREATE SEQUENCE sut_se_price_map.attachement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sut_se_price_map.attachement_id_seq OWNER TO docker;

--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 219
-- Name: attachement_id_seq; Type: SEQUENCE OWNED BY; Schema: sut_se_price_map; Owner: docker
--

ALTER SEQUENCE sut_se_price_map.attachement_id_seq OWNED BY sut_se_price_map.attachement.id;


--
-- TOC entry 220 (class 1259 OID 16405)
-- Name: contrib; Type: TABLE; Schema: sut_se_price_map; Owner: docker
--

CREATE TABLE sut_se_price_map.contrib (
    id integer NOT NULL,
    product integer NOT NULL,
    store integer NOT NULL,
    author integer NOT NULL,
    price numeric(10,2) NOT NULL,
    date timestamp without time zone NOT NULL,
    comment text,
    attachements integer[],
    status sut_se_price_map.contrib_status NOT NULL
);


ALTER TABLE sut_se_price_map.contrib OWNER TO docker;

--
-- TOC entry 221 (class 1259 OID 16410)
-- Name: contrib_id_seq; Type: SEQUENCE; Schema: sut_se_price_map; Owner: docker
--

CREATE SEQUENCE sut_se_price_map.contrib_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sut_se_price_map.contrib_id_seq OWNER TO docker;

--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 221
-- Name: contrib_id_seq; Type: SEQUENCE OWNED BY; Schema: sut_se_price_map; Owner: docker
--

ALTER SEQUENCE sut_se_price_map.contrib_id_seq OWNED BY sut_se_price_map.contrib.id;


--
-- TOC entry 222 (class 1259 OID 16411)
-- Name: product; Type: TABLE; Schema: sut_se_price_map; Owner: docker
--

CREATE TABLE sut_se_price_map.product (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE sut_se_price_map.product OWNER TO docker;

--
-- TOC entry 223 (class 1259 OID 16414)
-- Name: product_id_seq; Type: SEQUENCE; Schema: sut_se_price_map; Owner: docker
--

CREATE SEQUENCE sut_se_price_map.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sut_se_price_map.product_id_seq OWNER TO docker;

--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 223
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: sut_se_price_map; Owner: docker
--

ALTER SEQUENCE sut_se_price_map.product_id_seq OWNED BY sut_se_price_map.product.id;


--
-- TOC entry 224 (class 1259 OID 16415)
-- Name: region; Type: TABLE; Schema: sut_se_price_map; Owner: docker
--

CREATE TABLE sut_se_price_map.region (
    id integer NOT NULL,
    parent integer,
    name character varying(255) NOT NULL
);


ALTER TABLE sut_se_price_map.region OWNER TO docker;

--
-- TOC entry 225 (class 1259 OID 16418)
-- Name: region_id_seq; Type: SEQUENCE; Schema: sut_se_price_map; Owner: docker
--

CREATE SEQUENCE sut_se_price_map.region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sut_se_price_map.region_id_seq OWNER TO docker;

--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 225
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: sut_se_price_map; Owner: docker
--

ALTER SEQUENCE sut_se_price_map.region_id_seq OWNED BY sut_se_price_map.region.id;


--
-- TOC entry 233 (class 1259 OID 16503)
-- Name: report; Type: TABLE; Schema: sut_se_price_map; Owner: docker
--

CREATE TABLE sut_se_price_map.report (
    id integer NOT NULL,
    reported integer NOT NULL,
    message text NOT NULL,
    author integer NOT NULL,
    date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE sut_se_price_map.report OWNER TO docker;

--
-- TOC entry 232 (class 1259 OID 16502)
-- Name: report_id_seq; Type: SEQUENCE; Schema: sut_se_price_map; Owner: docker
--

CREATE SEQUENCE sut_se_price_map.report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sut_se_price_map.report_id_seq OWNER TO docker;

--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 232
-- Name: report_id_seq; Type: SEQUENCE OWNED BY; Schema: sut_se_price_map; Owner: docker
--

ALTER SEQUENCE sut_se_price_map.report_id_seq OWNED BY sut_se_price_map.report.id;


--
-- TOC entry 226 (class 1259 OID 16419)
-- Name: resource; Type: TABLE; Schema: sut_se_price_map; Owner: docker
--

CREATE TABLE sut_se_price_map.resource (
    id integer NOT NULL,
    source bytea,
    name character varying(255) NOT NULL,
    url character varying(255)
);


ALTER TABLE sut_se_price_map.resource OWNER TO docker;

--
-- TOC entry 227 (class 1259 OID 16424)
-- Name: resource_id_seq; Type: SEQUENCE; Schema: sut_se_price_map; Owner: docker
--

CREATE SEQUENCE sut_se_price_map.resource_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sut_se_price_map.resource_id_seq OWNER TO docker;

--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 227
-- Name: resource_id_seq; Type: SEQUENCE OWNED BY; Schema: sut_se_price_map; Owner: docker
--

ALTER SEQUENCE sut_se_price_map.resource_id_seq OWNED BY sut_se_price_map.resource.id;


--
-- TOC entry 228 (class 1259 OID 16425)
-- Name: store; Type: TABLE; Schema: sut_se_price_map; Owner: docker
--

CREATE TABLE sut_se_price_map.store (
    id integer NOT NULL,
    region integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE sut_se_price_map.store OWNER TO docker;

--
-- TOC entry 229 (class 1259 OID 16428)
-- Name: store_id_seq; Type: SEQUENCE; Schema: sut_se_price_map; Owner: docker
--

CREATE SEQUENCE sut_se_price_map.store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sut_se_price_map.store_id_seq OWNER TO docker;

--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 229
-- Name: store_id_seq; Type: SEQUENCE OWNED BY; Schema: sut_se_price_map; Owner: docker
--

ALTER SEQUENCE sut_se_price_map.store_id_seq OWNED BY sut_se_price_map.store.id;


--
-- TOC entry 230 (class 1259 OID 16429)
-- Name: user; Type: TABLE; Schema: sut_se_price_map; Owner: docker
--

CREATE TABLE sut_se_price_map."user" (
    id integer NOT NULL,
    display_name character varying(255) NOT NULL,
    avatar integer,
    password character varying(255) NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    login character varying(255) NOT NULL
);


ALTER TABLE sut_se_price_map."user" OWNER TO docker;

--
-- TOC entry 231 (class 1259 OID 16437)
-- Name: user_id_seq; Type: SEQUENCE; Schema: sut_se_price_map; Owner: docker
--

CREATE SEQUENCE sut_se_price_map.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE sut_se_price_map.user_id_seq OWNER TO docker;

--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 231
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: sut_se_price_map; Owner: docker
--

ALTER SEQUENCE sut_se_price_map.user_id_seq OWNED BY sut_se_price_map."user".id;


--
-- TOC entry 3252 (class 2604 OID 16438)
-- Name: attachement id; Type: DEFAULT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.attachement ALTER COLUMN id SET DEFAULT nextval('sut_se_price_map.attachement_id_seq'::regclass);


--
-- TOC entry 3253 (class 2604 OID 16439)
-- Name: contrib id; Type: DEFAULT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.contrib ALTER COLUMN id SET DEFAULT nextval('sut_se_price_map.contrib_id_seq'::regclass);


--
-- TOC entry 3254 (class 2604 OID 16440)
-- Name: product id; Type: DEFAULT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.product ALTER COLUMN id SET DEFAULT nextval('sut_se_price_map.product_id_seq'::regclass);


--
-- TOC entry 3255 (class 2604 OID 16441)
-- Name: region id; Type: DEFAULT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.region ALTER COLUMN id SET DEFAULT nextval('sut_se_price_map.region_id_seq'::regclass);


--
-- TOC entry 3260 (class 2604 OID 16506)
-- Name: report id; Type: DEFAULT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.report ALTER COLUMN id SET DEFAULT nextval('sut_se_price_map.report_id_seq'::regclass);


--
-- TOC entry 3256 (class 2604 OID 16442)
-- Name: resource id; Type: DEFAULT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.resource ALTER COLUMN id SET DEFAULT nextval('sut_se_price_map.resource_id_seq'::regclass);


--
-- TOC entry 3257 (class 2604 OID 16443)
-- Name: store id; Type: DEFAULT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.store ALTER COLUMN id SET DEFAULT nextval('sut_se_price_map.store_id_seq'::regclass);


--
-- TOC entry 3258 (class 2604 OID 16444)
-- Name: user id; Type: DEFAULT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map."user" ALTER COLUMN id SET DEFAULT nextval('sut_se_price_map.user_id_seq'::regclass);


--
-- TOC entry 3441 (class 0 OID 16399)
-- Dependencies: 218
-- Data for Name: attachement; Type: TABLE DATA; Schema: sut_se_price_map; Owner: docker
--



--
-- TOC entry 3443 (class 0 OID 16405)
-- Dependencies: 220
-- Data for Name: contrib; Type: TABLE DATA; Schema: sut_se_price_map; Owner: docker
--

INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (23, 1, 1, 16, 10.99, '2024-01-01 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (24, 1, 2, 19, 6.99, '2024-01-01 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (25, 4, 2, 16, 16.99, '2024-03-03 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (26, 15, 2, 20, 6.00, '2024-07-06 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (27, 6, 4, 16, 10.99, '2024-01-01 00:00:00', 'Fatalny Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (28, 1, 1, 27, 10.99, '2025-01-01 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (29, 1, 4, 16, 10.99, '2024-01-01 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (30, 1, 4, 21, 6.99, '2024-01-01 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (31, 5, 13, 16, 2.22, '2024-07-07 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (32, 2, 2, 27, 4.52, '2024-05-03 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (33, 13, 9, 16, 13.33, '2024-06-06 00:00:00', 'Fatalny Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (34, 8, 13, 25, 6.66, '2024-04-04 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (35, 11, 13, 21, 2.25, '2024-01-01 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (36, 13, 13, 16, 4.44, '2024-02-11 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');
INSERT INTO sut_se_price_map.contrib (id, product, store, author, price, date, comment, attachements, status) VALUES (37, 4, 10, 28, 3.33, '2024-10-10 00:00:00', 'Dobry Zakup', NULL, 'ACTIVE');


--
-- TOC entry 3445 (class 0 OID 16411)
-- Dependencies: 222
-- Data for Name: product; Type: TABLE DATA; Schema: sut_se_price_map; Owner: docker
--

INSERT INTO sut_se_price_map.product (id, name) VALUES (1, 'masło');
INSERT INTO sut_se_price_map.product (id, name) VALUES (2, 'cukier');
INSERT INTO sut_se_price_map.product (id, name) VALUES (3, 'olej rzepakowy');
INSERT INTO sut_se_price_map.product (id, name) VALUES (4, 'mydło');
INSERT INTO sut_se_price_map.product (id, name) VALUES (5, 'ser');
INSERT INTO sut_se_price_map.product (id, name) VALUES (6, 'kiełbasa Krakowska');
INSERT INTO sut_se_price_map.product (id, name) VALUES (7, 'Łosoś');
INSERT INTO sut_se_price_map.product (id, name) VALUES (8, 'pstrąg');
INSERT INTO sut_se_price_map.product (id, name) VALUES (9, 'skarpetki');
INSERT INTO sut_se_price_map.product (id, name) VALUES (10, 'kabel RJ45');
INSERT INTO sut_se_price_map.product (id, name) VALUES (11, 'makaron');
INSERT INTO sut_se_price_map.product (id, name) VALUES (12, 'mąka');
INSERT INTO sut_se_price_map.product (id, name) VALUES (13, 'sok pomarańczowy');
INSERT INTO sut_se_price_map.product (id, name) VALUES (14, 'sok jabłkowy');
INSERT INTO sut_se_price_map.product (id, name) VALUES (15, 'banan');


--
-- TOC entry 3447 (class 0 OID 16415)
-- Dependencies: 224
-- Data for Name: region; Type: TABLE DATA; Schema: sut_se_price_map; Owner: docker
--

INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (19, 18, 'Kraków');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (18, 16, 'Małopolska');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (17, 16, 'Górny Śląsk');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (1, 17, 'Bytom');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (2, 17, 'Tarnowskie Góry');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (3, 17, 'Katowice');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (4, 17, 'Gliwice');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (5, 17, 'Zabrze');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (6, 17, 'Chorzów');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (7, 17, 'Piekary Śląskie');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (8, 17, 'Sosnowiec');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (9, 17, 'Dąbrowa Górnicza');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (10, 17, 'Tychy');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (11, 17, 'Cieszyn');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (12, 17, 'Rybnik');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (13, 17, 'Żory');
INSERT INTO sut_se_price_map.region (id, parent, name) VALUES (16, NULL, 'Polska');


--
-- TOC entry 3456 (class 0 OID 16503)
-- Dependencies: 233
-- Data for Name: report; Type: TABLE DATA; Schema: sut_se_price_map; Owner: docker
--



--
-- TOC entry 3449 (class 0 OID 16419)
-- Dependencies: 226
-- Data for Name: resource; Type: TABLE DATA; Schema: sut_se_price_map; Owner: docker
--

INSERT INTO sut_se_price_map.resource (id, source, name, url) VALUES (3, '\xffd8ffe000104a46494600010101004800480000ffdb0084000506060709070a0b0b0a0d0e0d0e0d1312101012131d15161516151d2b1b201b1b201b2b262e2623262e264436303036444f423f424f5f55555f7872789c9cd2010506060709070a0b0b0a0d0e0d0e0d1312101012131d15161516151d2b1b201b1b201b2b262e2623262e264436303036444f423f424f5f55555f7872789c9cd2ffc2001108022f03e803012200021101031101ffc40035000002020301010000000000000000000003040205000106070801000301010101010000000000000000000001020304050607ffda000c03010002100310000000a0d4b5e4f5c4b0950d9c2cde59130aa174db4152e1d8234d826210e5a9e88cdacf5e057977086ecabac26ac5c49d50c94264a641152c190230a0dd7375d4d694eba158ef6b711a26712248bb622139179d7ad66ad15da66285e73937a2c8e020d8095d62175593ad489859d15ca960cefdaa879656edd7584cbcda4d26fb4936268eb9c1832c572690a4516398c888d1bcd255f52cac42e01455e5ac955057758b4e9c6c7a8063d348f39bcf59351665edadb4b5db9065499b566a6c59ab235684a9399dab158cd4b78b9437a39501b0015bb23d6489b102b1acee7a2e43abeac89adeb73e6ff2cf51f319544411b276b4f754f1b31608bf171cd6521e4739359105369f3aece996c65154275b6156b54838bcea688e20622c7ac9d791b0d306db5db2197557334eb8a1d8d9573816629a99066b806b1dad34aba87ea63ae73091de1c0d3839e06d79a312c5e6051c51b5a32d37a9c4805620d38841bd46b555d7b5cb5e7d2bb455d5ed80b4f5854dbbcac2c6bec67371b5db430da8e89828ca042476c9ce336a538945ad1f5aca8ad802c474e9475a7b032bac85d6e76e717e914cf5e796e955cf5a365cccf5d310dcb648b681c82b8a183a127368cd4b95160ed55992eb816092609507215db6591abdaac5ddc24e18ea791bab3a386e1d67ccfe79de7099cd01447556b4d734f974b6f24fe770cde690aedad726ab1647a45642c5e1119c7535b536f553ad4acd2eb58eb701cda51b70f5a55db6bcaeb6bb6430d05a91838d85329c240590f49117d8460ad7ab5694d5963531da592b39a61cae7748b332ecedc9b8ca0f3122ed7342d0f0652048375b49d1165b9ad16afb44634a846d535a55af64b317b541ea8b2b3afb3316da0b31267146c1a380ec2cf44a593c9a7b2c0b533c293549c5dd36a98e69d02c10f1601d8627580b912ba705da937cfab73559ecb8375f3a33047693934f6a6c2493a66c5802d6a4d62a902ca280487d1585a66d3558f54593d5efd4b7384d293e85a43bd86aa34bf9f38cea797db1a120c9356f516f53974336085846f1cde5e56317b5915d36f4289253ac830660d56d65f233a73a0bc02d29057616ea8aeedce5aa761a64d3ab3b39b4c01872c1c0424b83d265d0748287706815efa11a52d45dd34762b918cec7b0ad7ef2b7616676e59c270bc9745d4daafdea2329005458bb5f600ccb5b5504dd533d9149f5274440eae355b1b179bf668593c1c640d4a2b00654b4c2ed3a3160516130c568f8d54e8f33db524d69d2c431268479993848d22d61b424249d857baada3bbab8d292b2ee9f3d92da9281c302c5c92dc0f09a6108b9b3856eab2b08a93ac0d8295c9ac2b9fa9b37ebec10ecc4464ed2a6c53bca5b5a79d7e77e6fa4e6f7e7a22408b4b6a7bba6cb76acabac72d4793cb8e9e2de9e4945cd12b6d99094839115702cc4ae997b90aba605c81554658c6a56762c5495c54e64d9d2321c9a6470ce832752d6b14ef598e84ab21ceebab2f149d79f15d8d6d54eb0d546dbdb1a73862dc6f3ad42f141f3e3b60955c46664cec17700f38cd5413713cf649664136a89910d7644dd43d629bef16d8030a24c01849a6d678b21b6c15a3c8eab19d3144cd86b40c63635c859aa11a5266f5b82635c8b882a36b0ab10b54cba7a7e992cef8b9dfc23559e24642cabd7a8b2857caf178e83ba64d18057049e492dbd5ef32d9fae7c1d22e5099d5d33a3ab1a317e23ce745cff004674051cd3bca4bca3c3a5ab2aeb2cf686472a3b4d475a736f5ac14b70d8b7ade004661a6013019a005a14b522c41b14f72b8c9c76a6645260e1d571233307840d3bb1210b10b2b17b355d2207e13555ab0dad2b8cd48512ccba40a47c72a81f10eb076431d6e58444bb25980f6c602cbbe12aa43661cb7ab5ed032eb1bd95a69e55dac4e78364c5c8b93537c6f95b6b465793dec44680dba31e0c351c26521e4a0c960e0224218e60128138aac41b40563255543ba5e6a86aefa8726aab156728af3d6b126146ae596d469a74c0381e43d011eae79ab67ab5f07662206f59813abb2abcebc8286f28f65445119bbba2bda0c3addb2afb28b064f349ea30393ce5903067c5f1a6341933708c1298f50572160d1a86b42dcb44bcf51341c8a733a995886c865b183ea018eedbaf5ad146aa92b5afbb4a24880e7921c344c46cb198a79bdb2312602fa3e0d6835001ce6410f65c62e27229d682c813a5602cd7ceeb2479011b0bae0ee45a4e4f85d9a2bab32331a071e4e531e34bb20d1833a09a80e94c6383926a19513c869cc464c9a148bb563c2865c1066b1aafe7ae290cab07214632cd651069366b471951a63c65d868999b4f6ea6e1366fa0eb6e90070cccc0956da56aaf1ca2bea2e839f300f9bbca4bba6cba19b3acb3e6da3999b656980d40ce2db11f018d33a5f133697d24cc57d3670c44d9361908e65cfa625de4ea22c8db9935a2968265e03896f47889651f542aeaedaa74a405359d176094b62429c8c4c640def3052d660f33361ac96e88ef7b73992db07a2c0021642ad60b23cf44a0d6a5e3e27c66620596569371d38e81f48a6db2c1633b0589318cdb5b6e4e3146913611b83e81261a43386b721b7bd0412d8546b5e73af32af34296da9455a280339674b9c64644c5d15a5d84dd3accb4594652f6da8c32c9dac7aa6c0e89d0c6c121b758fd7baf21a1e839fdb3e74e2633d2e69af2931eb6df41ee6d35999a62ce0b699241908d91db791dc059184132c45a6e70d4112902749b6917aa18308d594dc03ca5ab452cd499c0b6e7703e89512b2af755951714add62e654d77309736c106748b2c96664a3366b378193d113d6a7b1c27b9d286172810da10941360ab5f46d2d15915b5426f0e8990c6522734d8ccf82c28333138a112c09088e1a61d6c2131c237328c4a12344c9ee51030aa41268e05c359b11163892a6529234d694f2ea556430e6dace2931e25b2660965b8d28d01b70c448809b2c1dac7aa5f328506240921c41948bf2de7efe82e39f6573abbda5b6a9c7a197d1770e8de6b34c3379aa30c13a252de2511184c583354278b6c18806232cd7231fb1acb221b606679b16295992f58a764919b1322c81c40b22fa2d55515e50baab58c09d346014a6ccb339a63719666e5a995ad4b4d4ca3349a896254f37346b73d885a631b4c4d8b4b4a0d4ea87d030661b3a9e6ae6b32de39557370348dbc8b7a4b87019cee3bd54880655302e508e24c20f0b1d01a228b9c0d956f2f34ad78c53879bb52713e35d55f4873ff003c7b9fadbbb2ab10fa4e26c7a69af2f1b2185b75371c9f7193265564166745a435284c3458b0c2b8270265d9023b9ed1259f555f92f3fd0526b973871196b6b556b53cfd2e3e8d963b0b379a63bd131ac2e1459b9e00d76c215a9d8a6c4b478b9044b19ac344c36ecd3b2699646c3c98b242c9458d8a3609b4caed138238816afb0af6a9b9fe839b7550180276764915b798ad6666c48a153676198d8d0b25988acd3762194b60cb9e59e7022790289a10cbbd283781b08d49d62fcaec8840b6f365f0eea4959d1d554a0d12198f1972d49219848576c23444cacb5dec32a2596153cbcb6d4fe7fcdfcef977dcfa28f079efe913441fe6ff00a6fce7ec7d7ebfd3f90eabd5ee260e32f6a11169da2eb92c9f3ec2c7b4c60f05b98668b0b2acb56333c2a22d8dc68ae4190912654c38c60621695cdf90d0df50d9cf98064edaaadaaf97a9cb1aeb2c36164b37c6584d9186819bdcb254862607220a58aa34e0dc18945908f471b087ac91b1068c161c33608d8195958d7d809a696651b8104a95afb1af0a4e63a8e58d39850e92d9a3a25a4f3d53632ac4e064459c64af422826b08a126db3a67cf47d95dc9a91b6c8d7d3983afade86c955176d5bab48560b36c2c1b173bf3dd1d23d4e4f2a7a4972dd07bfcb60c0e5f41ce3911a940c24952ebbb299a15aee9b9b3b35380e7bc6f36f798af47caf38d54292cf645dbb5a968a825c736dfd07a5d8b75e6f6fd2620b8299ebe354c3faf7cf379e0f1f5c8f5bca7abd5bcd4f571620dd262d93b4b267d905a686ca18682d0ca4d180785c08565a5415e4d477545734250b0b4b2acb3ace4eb72ceb6c70d37999ae46c675a488b2235adca4e45030d0b2ed853584d093504d04633c0a37df41f72d182c3871f41f4acdfafb049c6d5685b11c4a92afb2af6e9796eaf9a2b9146cd19e8d4e6766ac94b091c686e4384cf29d1456cc11a55e998c58d88b91a336aadb2d24d15bcad4e5fa4f2cc3d3b66398347a5d9f1b555959761d4f91b98f2faa4bcd7d2fe53913e4c3bfa2f5eefd1bc77aac3caf5e0d7f2bf6ff002be927aebb24693e3a9e2bcafd23c03e5bc9ed53e69ef2f82d13572f292830a5adc2690588929ec4a9e812fa8d9bbee696f53afd083e764eddfadaba82f364698f7e6f376dd6f94779d7dec49a17d27a3b702dd4bb66858d364b0235b388a9b6e24fa4630caeb5a244054f734a3f25a1bda1d228ce034eb675d6755cbd6fbc8bd969992c79dae891db1d4e320912322a01604200cd0480362134989d894b48d24caf2adb839866a86ac10b04ecec11b19965a0342c118452b5d675c552f3bd35017cd2d6a28d122b649b55e93f371708c4b1edc9ce95cb5c8674a2ddb926ea9ab1346c3b48d867ac9cd23974f2147691f3beceb2572df3df2d55e9143cb1c6efad1a545d6a6efcb783695e03f9de547b2a1e9bf42f13cfbe4ffa33e6cfaaf6eebbff002c873757d4fe83f0cafd5e77df3c8fca5ef57e1f97b9e9de3fe5fcdf459c35f71f35c491ce6c9bd0a3313d0b6d4a313ca0e499a12c7b4e90db91a118ba1a6beca2d986ea988afd589e7be85ecfa6465673d9e97ec11b0b1828ca8d944506dd49c96d14456e71cd8854b774a1e41477d43714651156f6d556d55cbd2f5857bfcfb5962d9bf358685a28bb04da3c818d1611195b1c429136bc26988070659026371c4de70c984c347b1afb24acdf45d138cacd23702886b21635e9d451dfd1ad2a62ce46a229a73436a2cad08d099864961169ad324cb44ced1b1d9561832e9135b28f395ec38dc3bb94248fc1f5b69d1d3fa3f91f251e6fd128a7e73cfa69d56ff67e6fd371547e7fa7ec05f9faba3cafa77b5f8e9afa9f17a5f22558f67e816dad97d269ad6865d74fddbc2b9ff287e55ee70794854f524ac79f6ac91078bcf088ea35cd3f1374b827cf2c1d28297895c71b06af2c26431dd3d08c0d351c360d93bd3722c2d3d899e5fa8fa7f5ec5f42c3adb048143451cc1a751724748133a9eb3411a7b7aa678f50f43cfdcd0b0b9e75b6a8b7a9e4ea7df42c30d4f99971640e96bf7ca9e660cd6f2388d824ab20ac512dcdd762a7f2b648b43d6b8cb6b1acb278b6d2aca1a7d07e66cdf42c1261a55a7441ce292e83e92d2a69af692aeb37ad67b1cab9e28a50b52cac859564388f1722c091b3065a78ee7c0e9e8d4d2934ff000dd871187a9573565e3fd8df77fe625f3bc2f65e539017079d3e58f40be9a35c38761514f6d4fe824d3756f4fcdaa4af55ddd0e5ac3a8a8fa33c7fed9eff00972725d327dff15f2cabefde1be1738233d7072ce6312cecb2ac99c1d1391cd20fa60ecb9d62d91d1ecd52adddee5105cf46cf2bd0645c8a00e45b18a3d14c4d3c6769ea3e27edbec7a6fbe8587a7d0c1464164a3b069c49d434701872d668329ade947e4b437945a4d0b0b30aef6aed2b793a997d07b9f72e665cfa8a1d329d9c7c8567614f1a7363b4433d53afb2ab555b5edd51b4f16d2a6495c426e6c296c6a3a0b5a5b8317db4da91b711754da5956582970e06554e25d2154ac515a55515f73cf5a488f27a1d6546f3b69951a065854f34c195dcdb789022ece74bb8ab8ca72976e4ac369365cfbe9e5d1c9a8c17e57eeeb03c9b3c3ea75c4e558e7e5ea6ad5174f0d0d4bd41dcd0a82547b9e85842bc5d3c1662ac8e993f257d0ebcef69f5790fd9fcbc09b89e99d6f98fa6d4631e092bca6f9ae3801bdaceb00f0b4e7af2b2170068119cc865c933313870a50f49bad2a2c0894d1d15ebf5d6c21559d3adb9903e185ffb9f837bbfa5e8d9bc8bfe9f430581035bd6c196d36d0db0b9ca96b7a0852dcd2079350ddd1e9344c2ec4dde57be8f2f532ea4ef3ee4cccb8f7852d97ede0a3ade8535af2f59d7a59df1149dfd12bf3fa8ea7968e80e420b626c056ac6ceaacccaf6de9ee5e4fb00654b2f23613361635f63038caeda0919c258117927ad4f3bd1f38f4e6f5998f6bae22d2a71b4590748a6e5b30005054e0916de5564d5c9b9fca7d4cf9c69e7745ad65c0790ed18e5f47c414f7fe6bccfa3f2e9c21c238a6c1b73c2bdc576eaa0a7e8ea7afd1a61957f436d14370b88ff005c796fd0bd7f9f6e138fa5f36ba8da89d6535cd33aa6f26f65e17c9e7e34a0df85c19394639f25bc9886e7b4a0704447d2ebdb717414df5b0a7854fa7d2e2816ba341bb26b1c30fa2f3656def1f3ff00bd7a1ea5d3a93be9eed4e1316b7a901db51a91c3ac76c91de0c74779481e45477949a2a1640c2ab94deafe4ea6dc51bc369e66567f442e7076712cbb3a9a496b51051d37555755c1f07eadc4e7bf0216d58eb84c7b4ed2d2a6d48bdbaa6bb583ed01a03be9bc93efa4fc0d34bb3125d4b0d1645f456951ce749cd2d39ccdeb3ed65a49829c3224077419246860ca1d7b55050950a4e9a9573445dd9d55b1162daad49049c4a91bb2e05955d2f99fad4f9fb3e7f1fa3f2187772f59d650cbe7eb6ceb31f7ea95b32f5da5da2ff476ff002dd1daa6d7b9f0a6d6f549749e402ae8aeb9f1ad80da7e6b59ea5e77f37c35da20fcfe424d6838684b2facb195e874ddb255ea74eb615b92e9d5765a6e254b034f8f9807d414e4b615767eefe07eefe87a3d23a9bbeaf4b52d104396a4066956646cc133279ad950a4baa50f22a5baa6d2685955a35b9af7ebf8fa5f6d37b2d333309fa096829d9c4c4d23cb663b8a16afb24ad737c6773c7adbcdab2e6933ed1ee338dac2e2a2e145fdd545c1cf64c2edca65f49f94ed825611476c2d29cd1233aac93e8baa9e6ba5e7569cd0d95a3aa64191d4ca13818839b99036aa63a57a9db40049370b183a9d8da56581362654cae606740aecda560b4af28bbff3fb5e778ab9fe37bce2f1fa2e52afaae962bcc7aff4ae97d6f975faaaeb0f4be65d6d56b6836b7a00a0f2214fcd74bcc32b363c6d954b3c5f972de93e73f35e7c013ce7e6485602df2aacb185aad8d8e68ebcafe948a2c062632d46ab7b1c2f5946185b1f41fcff00ef5d7d7d7b4b35eb75b2484d9acd6c0acaec426cc13539c6512a34b714f279450ddd26a73ce2adabb6aeb1aee7e876c2bec70d7599847b2250afde6d1da2b0aceda75e4791512203aee47a3e456fc552da56e7dc22e1f2d1ab8aeb85373715772f071a03691ec52b19979e51c91b388f248731ab0a2ed73aade7ef691694017a13b2d3624c5cb39d386e70acd751e129ab46f04d73ec5acd6b5d37610f4e81aa4d3abbeb5949824ec841e09a24f82de31e7f8de9395f238eaea1fadea5e83dcd2597578a8b6ab3ec558bc83f50fb69b768dade31749c4c29f99e9f996536a7a6f79adabca1be0f32f2e1f55cbfce795198f33c7599938c445d6b311960c1c363d69783096bb1e219e9652a93439ee5e13ee1af57a032b35ec75324111bd6f5b03182784d1445a25bd637aa6b8a7ccf24a5bda2d6a81a55b2edab6ceab93a6c6c6b6cb2d63998e3d4d6b41f374d51ce2d339cd60f460ca30afd217e3ef7968e9e7d674587680f869a6adebadc9b7b8acb77cedb4bb24b3608bca6c5c45d49e22c468c1c1263ae6abd885359d2949ed7dc6cc6d6d94cc9795058c675843278402061a05858aa044fb2b4d0da54cbcb3b1d062e8b3b8d76c0ed5b3ae3f272717ce5c73dc7cf5b54f2ef97ddaafabe5bdee2c6d763b5bd615cf39b07126a9311d63029b69854739d2d0d147b369b0c4f09a105812b6fc9fd1e9fc5e3f3e81c1e7706f43d34cc61a78945935325dc8294d6ba576d6902dabd9b9a30d8597ba7847be5f576ada4e7a9d2c9065a7094a2c31d73c26ca12b25bcc6429ee2955795d0ded16850b6ab73a5ad4dc53f2f4d859d5d961ae666547b2c58879be8a8abcae909a2ed5f460ad74ab3a256e76cea33e94f0b91b09819e1b36f5b6ca2dedaaad6f27185d87934e2477164ed6364bc45495071c60e435eed7375b4767ce1608530a36bf9f3cd05f12b1ea8708b4aa4d002ea18d23369cdae59649424accc28c67b3ee57373d0fcd6246a40e01a9098a7f33cfe4b9eb5a2c22bdcafebf2e0f68e63afe5beb6465c96ed8751758fba8b6c34722d4153a8d57505ed132bb538b2233462c016162d455b4717c8d4f77c5fcef9080195cc37b8c1cb581da921418b36e63cc2d5aae86bbb75a8cd87af7b0fa2fe78fa477e9be75173d0d9b284adef5bc021c0cca60c33379a94591a6b9a655e554d715351ceb4b32696b516b57cfd6fd8a4ef36999bca8f7181f5e4faa8a5668693554d75cfef9d457b896f9d5d658d79bcb3455602ce69ced2bec8ced6daaad2f074ea4cc5f322cd4beda2d287580334b5a2e5246bae2b9ae7792edb92a3cfd73539d57165cdd8a7d55973b6ef2b3c5364114d26e593a0e21b6566154b5829d88748b8e96ced5bb3a3b35a33a9951aac7aa5ca7f1fcee7286e293979d4efbcff00d4579de9349794df67d43def5a223a8b837da49a11f078d4136d20aea5b7a6a14c8edac1906ac206031682166ac5dd79ff00a271bf3be571a8da039b96b54b047b2633501be96d3a33e4ef235cc659dcce92d314952f64af46d5bf47f81fd09e9f6bcea0ff00a3b34514c27a8c80ccacd4b64c1332719e8074b754a3f2aa6b9a6d239e6956e74b4abb4aae5eab2692631d8b82c23dfa328f97eaac93a9d2a9a1e929bab0e652bc4779e7abfa1ad34afc6a4b55cc39b966c2adeac6e6c2b2cde0ccc65ac8ad2ed3862c90b1cdb8d0acdb5c961b2ea11beaeb39ae77b4a253e6bc97a571396b52734ae9db7a9b5db9dacd6d4014796a717977d339b0cac0bbabce8b4b259eae3e9bb9d1c055a740a664c56b44f55789e6f3d536351cdc40f54f2df70ae3eb689fa9fb3ec2e8596d96d075275b4db1135bd204a32a32b692e68e9ab209294a1b8cdc61396569da34df080f39eb10f9be0f345fb3e37af9889d058566da365253ccd6f66a76d72ecd8adbd19da59e2754ff002f69c19f63ebde2becbe97a364fd7d87b1d0dca1366a5a9019b51a919304ad9332210a7b8a60f2ba7b9a6d173adacdc5bf59695bcdd6c3a8bdcfbcb278e3e920f53b8ae315eff03cc2abd8f4d78021f45429fce355f4ca957f3143e95135f33b1f450dcf811bdca0e3c7ac7d54951e5a7f4d88bcf5aee26971f6b7f68d54db5934695d2b4dcdd2d5f589aae1697bda45a799713ebbcc62fcf23d98ef1e62c6ddaeae7aa95beedd12f7c29aaab065d4d62bd397560b612ba49596e3683249086b343456ad66ac13a8b34fc7e2e2ea6ce8fcdf365edff3f175e2fb5783e0fdbbd8ecf39cefb9ef67a2a5e096dbada8da99eb2231a6d2745651dd51b681d638e7a9c53dbebdaf0a9d1433e6301e8d2c44a87a35e9f9a56fa0d4745722b769ab8e36cefd88cf992f4f993e4abfd023b1e75af445ef3e47d8384b8d76f5b7b99ea3e8f6608326a64e1302b2b332d9308ac9ea7a10a9aea94af2fa6baa6d279d655672d6cabac50e7e89ba83d8f44f258e3ea89788e73e9ee1af0d6d3f68df8fcae3d7b7e3ed27ead9e5a571e9dbf33db3d2a3e6ec13df6709317712e2329f6fae2e4cecb38dc93b0df1b036ee27c38569e81af3ed51e819e763aaf43879d8b3af465bcf869fa00bcf56df93d1e5e682797a8e797e2af4b179b4257a44bcda4dfa4e79bc47e8cbf018ebb9ce1229f7b1e122df720e2601d9039114e7d653d3432cfcee8bade6fe6fc4e6ac586bab85ab8e74fe6e5eb1dafcf077b7d4e7f9a3a0efe9f751f96d876ebe869505bf46d80296d73749e8e9557197dbe73963d0c3e4fda6623c703cbb3d7d2edd2279831b073d4af35e61e90d42b5f046b5b8cc6a804adb416a5a94bd6b32908641b62c9e5a6fd4bc96d7bcf6b973973f483534f2cb16aa9992d4f58763f8a60cd4f615a2f35a9ea6bed79e31624c7782173558f441e45be7dd8c8e10b89684ec4142124b60d060a22a4784022de26354fcab08d3910c18ded5db1ad2b169d921a6ade55479decb148e1ded96b079eb6d95302af774236fa5ce672a7a6ce5835c7d96b8fcbe5ed8bc3143b72f0f26bbc2f0660eea7c2e43f40df05b9aef67c0625e89af3e95cf7bae0e147a0e79e411e890f381e9977dc7d6e72f9a4d349791e2ea62c8cd9d2f3a868a8c79e6e2c397928ea65cde87d7c791264fb24f9ac6ba9a8afa7d9f49d4ade73d7e9577a1a37ea9b22951cdd80e0a777e879ad7634173c3d260c839f4ea8ee7cf7af153d2b82eb2b3b196b7c5d909646d71777cf25e9737a0ee1af3fa6693945d0fb6f46f05eb3d5bf55870daf575ed14e4e08eab7c7413ed77c4623b8ce1e0d76ec79fe27db4788c97d6f25181a41b09b0d4f80c155aec8e34456b48cbaccb28b2a94bb1934b97101d142e203ae2378d2827e6240ad32caa1deeaca595c4dd5492ce78ef511b9d63db4fbba8ad69f2db1555c2de2aeb66dc4178322d3887296af98a55c8e1c9a73a1c9a9329c2a1b96e453c437a4b265c9556996a3ab5ea6d854e071750a5854dd0e835be3d49f8f1e58f50a55da799c39236b9f8812d2f3ccc695954be2046535b4f4dbd1500277b1e27b18dea8c0bb8a9b81cc3bb5e70d9fbb924e9a5cbc0e5a573d97b32c182b5a0ad83fd5e3a56880eebb5d6671fafaaab8e52f10256a2eaf2b5d3f9e77d97ae78eb796be67e83c75b7a73d7e71887afdbe845f3a9e87a14bcee32fd237e69197e9d2f2d8b3d4e7e5124bd5a5e4f21faa4bcab61eb32f26c17a6e7986176d9d1c38fa39c3dd0ea6a037504528ae8414dab683aab85a689afcb0c1d7eac661573b198eb32d4b4eaa77122ea256fa9da97773a5bd4c6e471bd5cad64e29b2ef12a1d5ec48a51ddc9f351eef634a98d6726ab676389a536f63531cd82b26623562c0a12dad0da98a21a45804170d69285e4e41316b9584519b6dc53085a128c707625e375963d5cb8f9461d81f88cca3ac638cda5db8b902cc77ba2d9791c38b935cf9b5c85a72fd7da6b71319f919bc86136add7b8fdd9f277dc5f4e0eb82daf1e153734bd15dfcd4678bdf0f297355d3e7b4b4ceb879be9d11f47a3d3c9327176d453dd53fa5cf63cdf57cd7a7ea8b09aead0584d0c792da0722480722cedadb6757509447a8cceb23addae55656ddc6fb7dfce7370f0ef2047071ed42df16af7a14f889769aa5c74ba9937c96baed3392cea974f9a874c17a5065f49573f97f3aae6f3a78d69cd6fa2d2d39ece8715f3d9d0c6679ecbfc5145aba9d2a4ce8368a095f6c28b77bb152cae71aa8d5ced14dbb78855e5ae9cd40ad801531b2805782d064d50ed61a4530aec7a63531b3db9acdd969959b7e2da523e00b27898746d0477b888b83c64ba4e5fd038f92e4a40fcc780a60eaeba286c64c7472cf090e6cf23015ab96548bf768d603dd3e39e10cc79c55b66974ddf5cf25d7737b1ca6213e8f36e5958bcd9976294513516f5eaa25acaa7b6dd32dd27afedf2e1e850f57d2a80d885e88ccf12810202ea3a1829b02142d1a22c68930e44b581cccf7928e5e0f913866c9888ba05e33106c2688d41b993a044c08d5455f09aa716f2b65a4c44a069b9690aed9d50be31a7418b1a42617a10d2998892646c2c0e8db80386d350def42dcb7371094b02319c49c1104dc4240b880ce1a2119c1c0c648b9081885ce6f78f38409b18f0b8d0a0c0c05a9c59181743164f4d4725192d3d0966fe6fc41aae23e5f1a0b321d45f211a920f63b520ec217bcf59d26dde66231cfcc9849a0008b9d0d1eaf8cb6aeeaad4aa3b32b0b7e14c5fa66f9cbaf3399b92b2c9dbf336ec74f425d6f3dd37d07b29569ea3d2f5e0a82b8dd84d354ddb5422aa38203b836c10d133b5b6435a5e78b672192fe83d7976fc0e2f4fdf97689f4d5bce223ef89e7a397e9ab79eed577b2e0493d3dec7852c69d9438fd3d3b0df21b1f581e676efa2272f94fa8d72f82e9f3958bcfab1f2b0d33eaf7c9cc9eab5cb633a81f33a6fa7ce676974d0e7312e9339cc174dbe6708e9b5cc8daea7395c6ba78f30373d4039a0a9e9f7ca699d543951691d687940e91d66b92d5cf5dbe3f42ecb38e987579ca6c7d4672ba0ea05cf419d2673520e87541817d65c5faaf2f2f531debe4be71455a5094d73af40e3317440b44d00c531da094d0b35acd29dc23b160cb0ba536786a0127d7e8db9aaebfa8f43aafad299ee0e5bc2d53dc59d85854932d2d225a6f7fe8e15f2aff5bdb1adb5eb6d0b515708433452110551a866b589e430921973614e60320f4ac9ebe4b48e6f1a844db2867d4f3d23bdce760c5bde7a2246611a02268d50772d35a9ef4396b7b2c23623285138ef25b0d9be20c369c870b8a4387dda5e459d640d3114070da18a3280a1194696437046c72d2428907b38689a523c98dcc205d5a144daa4091b1b0e8fb10747c4c186c54be98d12bc5bd314c771bcf57e77aaf2be6a21329e6783058806c2a32b680969836ce7adc4a88f5ad515e1d65745b4f8fdefaf48a2b67973ad0b2516605ad75754e3607be55d49d351f774cac79eba4ec2c6b19e0e7b5328cf3334d46bb3d6e640217d2fd7e8380ad3219a60f3234b4398dc64270b986471c1661de365c5f11eb9a5b3e55b3257436e486d5bf244b9f53734e71a35b565367c52632e031d1223d145d43528b82d945c161338e654c352d5e11c96ab0d64f190c9e323bd6ab3964748deb58310a43a9d47710dc7714b7a8c5990d66866a3168829445a19354a3bde35ad6f6cd6f30335bd2359adb3799b4477ad86e703a9f569473c4f88daac27cfcc055a4a9894dadd131d443a041c32a65a98ea9ae7eeb92edeb50630f7eb6373caf4984296fc95d22d5195437d3c612e4e0154dc23b69ced8250eeebbf7ea1de2e5b57ab99e3c9b66bcd1b5053f5fc7fd37dd44721f5756e3b8b59adc6a74298ea76298e88e432209a1c332781c95fffc4002410000202020202030101010100000000000102000304110512101306141520160730ffda00080101000102009ad2c4f1a31a397249861802c408116a15c42b160f02124b9b1ae6b4924050a140d1565752bad0002af56574b434ecaf5bab24ae244359429162c52083bdf870d1c58193d5ea7a2ca1a8f4ad75a222aa845454540a5595c38b15c376ec67554ac23073635981679f9ecc8860882d144507f85958034d1cbb3b162c498b102840a102448b16082086317369bcd84c1e16001745595d48ebd428554e852c5b51d5fc56d5ba356c8562448b162952203fc306570c9eaf57a5b1db19f17eb1c715aaaaa22aa050206160b058aeae18328540ba56167b4d9df15eb6867cddb2218b125d288b1a6f7b58917c3c7961b1bb76262c58910204091208b04101258d86d37358c209a58a35a3183c335a015557a9475b12d565654951495cae24409122c1e01820226886565e82b14ad3e934363b63363b502b445550b01ec5bbabab06575740a0466367b058ac0995361d91a7cb9b2218b125d280a1bf812b83c387969b0ef7b0cb12204082b091208a55b7b258d86d37b310437642b07831a393e562051a2aeb6a588e8ca0566a5ac56122848800510400400000ab02a10562a150a8d6f5354687a0d4174087f60b7d9d832bab572a54019ac7b4ddec52917c29c3b81b4fca1b23c0892d9440186bc2848b36f2c371b4ef64a9495c4091228409041010dd8b3358d69bd99837612b2b00d18f1e13b8b10ac034e2c5b15d5d0a28a4d51224589162c5f0000200001d4af55408b5ad66bf5b546a34bd565654c77367b03870fd90d62b4ac073635ad686428522f812914599d6fc81b2010b105a280b0c357a7d4a88aa0ab8b05cb62f5d10b12572b15840aaa1401e0424968e6d978780f60d59483c3473692760a148b00d30b03ababa900552b882b0a142c48b0000000050abd3a0ac56a8142f5e86b359aecaed4b23b3bf7ec1bbab22d55575a90e6e6b8da595ab95942be16532a9cd373072218b125d288b1a7acd66b08abd74cb6576d4f49a1a8f4fa56ba96b158ac284820f3bd924bcb65d2cf1d81a8a15f0631b231049428560f0d1c3870eaca16b154ac205022c4820f0200aaa157a74e814285550a10ab2b2d92d970b2587bf7575952555ac0fec36fb7b76dacae57122f85949aa73679797c31224ba511630e9d0a0555eba6565b11eb359adabe816b5ac56122942206ec5b7bdb1796cb85aac16095448be1a34b0b41375942907860e1c3071ad20a8561400b162450b00002aaaaaa85ea542840a142f560c1cdb2c96ada97825622d75d4a0fb3d86eee1b7b116572a8914ec1a5aa7e69b9697c21222dc288b1a7acd66be817af42a55ab7acd65193af445ac2c4808218376eddbb76258b8b2bb696a3d22aaab4454eacacb6a3a7522b092b80c6964784302220a96b081608b10ac58aa15551115542f52a1428500021a316964b15d6c4bea7a6baeba5555bd86e360284106002546b2841deeab29b3996e56640312572f94458d3a91ad01a20ab2b2946435b566ae811408a43060dd84d75ea14860c1832327ac575a22aae8a94b2a7a7d2d4a5495aa01a22c0c082a46ab5a82058208a2b0aaa8116b0aa142803af50a17426d9989843870caf5be3d988b8e012d61b7b86529041114c5951aca4077b0d5ddcae472272210b2a97cc78b18c30ff2669810432952bd7a803c760c0ac50abd7a1428e8ca432327afd688aa075ea55d0a1adaa15aa2a85d69d1d0d6c8d5f445ac285802aa22256888140014280a142eb5a849625a1f1606535fa9a9b2ab03358eee4a90565644110b1595cae21077e10f2673ce44316572f98e1638def7b077bd98618610411340424b2b24515aad62bf5fad91d58752a57a7408a817a9528c86be8502040a0742acac8519194aa84091428554545ad1574000810280211a24924f862d0c20d62bf5b2df2f67b1d8cd2c58a122c58092a6b35448bfc29e4e67cc8f092b99131e00c37bdf8dec9ec5898492de34268cd2ad6b5ad75a5613a14747570619d7a95d000688d152a2b29d0284e9d4ab2321564652aaa82b08aa115151560020002c40be364962c4ee6cc200e9d0ab1b0e43decc7c10b14acacac1e54572a8913f851c8af2232018b2a97ae3811a76defb77eddbb13b27649248f006880aab5ad495a2a8428c8eaeb60226fc0800feccea06bc688646465656454415aa2aaa058914280a14280b1613b662c4cdef73404db33b5af79ba34ded9962c529160f22572a8850f913929c8cc8862caa5f31e08d3d9ecf677efdbb16efdbb6c9249104100d0545ad2a5ad507520abad82c8c4b760c08220f03f9d680f047860430218008b5a2280a50a844450bd3a80206ec5cb6e6fb020688d96676b1dec369ba3b76efb5080442b160f0b1256c85581d82b39299e326189125d288234d93e078def7dbb76ee5bb2952b04000ac56b52a2a003a9160b45b1e13d8104159bfef5ad4d68c30c2194a8544ad0011424a95155557af520cdef7bd97edb580466676b1ed6725cda6e6b4fb36b1400a1224583c08a50a1520ec156e44e78c986204170a208d37bd8226e1848309266c14890058056b50ac2051d486164b25b1e1f0b04014407c880758275d68820c3e3455550200a151116a081142e8830c3364962db01542c677b0d8d6f72c4b9b8dc6e3b11228004528560f2a51919486ec194f2273a64c32b95cbe511430def608f2616eddfb6c9ec0a1ac2c50a2b5a96b0aaaba21c38b45c6c8c4158b1409ad7903426809a85486565d688a71beb22a2045444ad1150688d3430c2c589d0550212f63d8eece5b70cb0db2e96401456a0082095c53bded4a442a4180a9ce39f326195cadae944049f220f2d1896edd8b17ecad59acac58a2a5a95151402086160b65f1cb7848b120f0079100d403406b5a2a548328a12ac1c3cbc1f4050102048a4430c686392441028f059ed8987570367c76af8e66f186d396b99f8f994b8eaa1040415284104121422a05004110670e42640d20496ca2286f2228d68868f18efb16d82a525714244154ac561028d3422c97cbcbb120a952a411011e548226c4100d75eac0875a69c6a68a2eb8d8aad4352914a1583c18c58b78000df62e88f559f2dbbe6cdf344f9a7cf3fe99f05f979b19894b6fbec48b1482096465658a000155151157af50a8b9c33c5f0c58b2d38f1419ad055004218386844260882b15840a116a158ac2851a60d2c990320d8fdc10432b860db56dec10c0c5220001061840ab0b149516595aa8a71ac5b315224483c3168c18681d9654af1733e4799c8be67dc5b293cc5ff01e089f0c59f344054cd92ad594080055454545550bd42aae78e425f1a21596ad11234d680035a2183ab2952a400020a9515028ac542a95c58be0c7964c93912d6ee2c0c194a9041077b043078b162910833417131721f0f1f2332b8b2a4f63db69158543bde9832b824b22d38777c9f3f9c6e432327d88117817ff00aae1fc46d07b1666b5be2d6f33c3459bdc5948ad5542a8408102a81a004cf9c8cbe3448b2d94c48c0c01401a01810e18752a4680ac542b0b04495caa2458b0c68f2c993328dce6c1607564658b17c184f70c195962c002eba32e4cc2cbe2f0b93cf06967ca5e528cc5b4b2d209ac40ba6561614ad707339ccee62dcec8cb5ca5b02f6329cde6389c5a7b762ed65b653c8617219f8020f1a45a96b5550aaaaa81001d7ae84e40f212f8456165b28891a6b4a000002086564ea558680415040a1620a8562b8a008d1e59320658c85d00b165214285f063125486435c50a813a7afd2cbc260f2bc8b1598c8ef8dc7b2d6d8a5c244738e06885c7bc64fc872f95b732dc97b6d660f4f55478f4e072155ddcd8d63dd75f7ddc672b93675d2802b5ad6b5550aaaa1024000d1139199e6f3b42a6c94442c7ae9628f0610630d10c3ae90551208b12552b89162cd307964c89942f8400aaa29081542f5647429a12b948ad52b5ac57cb735feaf139de47e67fec69f962fc9385f9060259f34b3e7983f27e2b280ac24506b23e47cb8e68f21dc06b8dee958b1ab56ad635975baa3331fe46390b332dcfb32845b384e4b2e8d08a116a15850045881028d6a19c84cf991e2b8b2c94c48c7af50bad7520c208eaca411a495c58b1624aa571200be1838b05e3285e86b540a8952d6aaa13ab2babaf409557525495a2d7ca65353663555e461be0d58ab5f19561b0c2bfe478f97f0a4e6795c0ffa061f26b1ab09f28e26fc84cc3986fb2db0f65466b2eb19adeb35bb286c4af1bd28914d37713c85b4854092b15c502696244820f0619c81cf37c32b8b2c94c48c3440820f061061520a95e81152b550a1624aa5410280218f2c170c95b13d4b50a96a4ad2b440850a3a3542a15575d55d495d60725735428f49c5bb12bc56ab8fa546f231f1388e3b0ffeab90b31f91e2ff00e99c6ffd8f0be6c39bf927c5b2e95cd4cb37568e6b5f63582e7053d7ea150a7d450a852209837e2e590b1257122c101589122c1e0c339199f2f8624496ca6573508d0820f0d0cd99a2089a58b142cac572a15c58218d1a592e9902c4e81022a256aaaa13a1adaaf48a05094d75575aaf297d8e152a1869c7be1b632f1d8b55f6ae72e6d1958aff00f6abd2cf6b59d95f89e4b1be699bf26e6f8ac4e62bc96b904676beb46447043066818c20061369660e655628489122f811656522c1e0833919c84c8f0b125929887b6c9826c312c4cd93b309d82b10285092a15048b07860c2c970bc32f4158ad6b5555450bae9d052b50a9294a950273ad74acd1561e2ae0dbc35787975f21c953cfa5e30e8e338fc5ffaaf3c68db80eedf1bc546ad0d191c70e3fee57c95198d606ec57ba8f70b3bab92c492618457389cc5292b89160f091224583c6cce417905c9865650da688b04d93d81dec92c58bf7ee5fd9d94a448b1620a857122c5f0d1a5b2e17861a551162c40b04500050aa81542c0567344ad5462d7c7d01390b4e6f33cb5b8f918b65365f47ca791f9ca07ca24b03c4f1fcf7c2f27016ceeaf1d1f09f8b76ab2d7256f6b16c57d8604ad6cc744b780d55bc365a4489166a29488548f0499c84e4a64c31220b463c10434b2f51e58b1776b3d86c36070e8d51ae2c5882b95440b17c18d2d168b810008000020500281162002760dd859ce5a6c5bf1f278ce4aee572b96cdc8bcd8b7537d3654f4352f4bd2d48a2c4ff93fc6ac7e7385cee3478ec1ab8ae45b4d981761233665595f62ab9aeab205e97a33166eec51f84b9056122f9110d7041e0c33923c81c920a1a85c298b36f8f650f5910c62ef658d67b3d9ec575646a8d50440b2b95448b1492d1a3cb45f18a90c0a850a1608b0152addbbf6ee1d5fe42aa035561cf4ceb727225ad6dc6fc8bacbdad2cd1c309c1f0b8d8cf1cfc838ab283002a1ac7aef7b96c77871ece3df1dac4cb6c9aefc5405dbb16edd7896ae57120f222c48bfc34e4a67cc98224a8dd298be1e8b31eec7b2964d3cb4daed67b7dc6d4b11eb7a4d5162c12b95c4822020c60e2d9931d83215890452a761bbfb3da2d36fb03860dcf263867b736ac8191f66bb332bc9b2cc8c9cb7c8379bfded77b437fcd3e3ae5a592c3f28e382faf4e1cba002d162dc2f168b3bb621e331f04026db1ae5b8b86e31e935c48be44589011e0c339299f3260892a974a62c31ab7aaea6ea6cadc582e971730f84646a8d06b2914835cacd6444f0430b25d324d850a450b1629520f63635deef7fb458b67b3dd9338ae47e5d9af935641c85bebcac8cbc96b9b2a33766626227c2fe38aad1a3cb65c398c25246995aa7ac56d58acd3d3d0b8eb515667beeb1ec3656e0acc35c695848a3504589041e0c339239e7248892a36ca62f835bd76576d3663db8d6d1915df1cf624c5359a651122458b2b95cae0890431a592e3932c28ca519583292dddac7b5adf6fb96d5b96ff78b01cbc37e0b91e2ebbbd8971c87bdecb96f4b2b6f0652b8f87f0be04931a3cb65d391c3b9430254a2afa8d62b50500edd9aebaeb6e6c96b044af55b71f31a57122f911624117c18672533e64c116552d94806157574747a5e8bb1b23173316e5849286b94ca254102c415cae56162c10860e32264cb22c589162c0ddfbb33976367bbec0c94bd2c460c5972862739f10bb15032ba9161ba5ab6c266351f01f8e82618d1e5b2e9be7f8e109d9404c04b776b0d8d90f7d971c8b6d50b5555954435e3360b2448be562c48b0783e39299d3220892b961a60f0630756428f5db4df4e6636763b030c4351a6502a881428ac562b8b1608634b25f32a59142c52a55bb6f64b1b59ddad6b6bb2a6ae24018d871792e2eacce0b94f8eb56f5db5d896cb058beaab1be3dc2e0628f0630b25c6f6ed6af2186504685bbab35cd7b5a6d7bacc96ca8942e3fac046255a89c59488140f022c48b0410f8e4a67cc80224ae5a689a84b127454ad8b6d79757214dea6344354a65129091428ac562b8b0010c6164bc65cb22c52183860c1b65ac7becb2d6b3b5469958ae02c5e75a2fc7e4f2939bf8d363dd8b7d778b03257471dc6fc7f8652a618d2c974c83dbbe5e266e1c6059d85b658f91ee7b43f54a569aeb0bad82149a5f837ac2459a822cae2f81e79399d32208b2b96cc786699d9b63c1160b57217393314c6892b944c715440b1657122048000634b25f32858a208082a54efb335ad7d965859052b52d710f62586bacc6ce4a6fe3f2b1f293215c574f17f1ce1b8748917c18d2c97cca6ee1837238d7e39215d987a4d4d8e69f47a854aa4180ea12457380650817c1022cae2c1fc72333864c116566e98de5ac36fb11f6634b664cce1c8068620a85031c57122c49584081001a8f2c97cc9960d08208a008cced6b5b195512aad2b88548801429d4ad3566e5af2dc8e7652d7807e0f85c2542a89122f8318d93206583010779f857d31d95594214f5905442a61630c2e194d27e3256241e441122c1e0f8e46669c9822cae5d3186a3d8d72588e1fb3b5ad92f9cd9cce7482a140a1690814562b15840b07831a59322640b14a840814010c70f1c58829140ac048b1222aa942a54af1d57296e435c6e3ff003fc6e6ed5892b891229863cb25e32e183c6f7ca61bcebb4478588d057ac396dd8c96ab02a6b1f1171122f910448be4cdf27334e44589125f3149f1633ba3a3871635973e43e7d9967af5ad6a142d32b081020ac20ae281e09636b5c6f2c0a81ad0520c20a9ada914fa8a755555ad6b50bd590a95a31b30e41b9ac3ff0038c6e42c5892b8910ac10c78f2f39708f2430e678b2c18dae74618d0a356ebea64059cbad959f87c1120f062c1162f924ce4a672e4c588125e717cbab54115859ed6b2db722dcfb2e9a0b5ad494ad2b5aa05892b892b8b37b62ed61b4dc588f1b826ccea54823a90542aaa2a2d6a0052acac975b9565c6f364f8d51a50b2a89122c11a3c797cc9857a95d69c58d958ef04760410fd831063232b40da5154f89858917c18b0458b078d4e4a674c989162cbe6379eac8c85492ef6596645996f640bd6b5aa502915848a125710a10c18b333b58d735ccce1bbf7d86f26187c184000244890410925a65365bdef73d00d7ad24ae2442b364b97974c8046b444602de7715eb30cecaed62c42d01647a6c1d4c5349f8c848907911624583c186723336658ae2c5974c683c752183861635b6596645b71235a415ad22995850b1221aca10c1b6cce6c3735eef68bbdc2c5b0329decb17ec1b7041162152a764b103947c8b321ac6e2eae62ad75515942917c12d1e5d32211a30868d2c8cd9b8e4382ddc9562e58cec8b914b2c0f44e0550a41e37162c583c18672333264aa858b2f98aa3c1521c30b25ad73daf73590af52a82a14caa5514ac58850a3020c68f2c392725ecbc640bd6da9d4a924bb59ec0eac0820865642aca7b1676c29c9b64b5cce7e2147c85b40448b1229d98c5cda6f046b443068e09cac5b90c20888dec04bf547796d76a8986bc5d6b122c1351628503c106723332644104536cc7f3a21d5c5b2e6b99e5a5a2afafaa84954a6565602aca50a9461e08716cc919c722ff00b15df55b53ab062ceecfd9624584efb23a3290dddddecc6b390b328d86d3f054e6d809a4891082092c6c369bfc68c21a3478e38ea790c6b11ab27d82c169b6b22df657630b719d78c5c58b122c1e562c582688239299932608b1459299bd8843cb25d3263cb25d0c0d000aa2915448a4152ac8522451aeac96a642e7539d8fd5254f4588e18bbb960d5948b092dd95eb65605999ddf04f22d79b65b3fe789cdaf83122c48b0125a592d371fe1a10e19788c2e4e58ae9625955aace322bc9190acb6a5816ec2e2f1aa5595c59bd88b142c1e0c69c8ccc993162805e5477b10c7961ba6406160b019a52194a8a85712290414292b0a1405eaeb6a5f565519d8cf47a916809e087042ad6b5ae88611657126ddd9ddf8ebf906b9ac360ff009eb731593bda152917cb47969bc83b87c10cb87c767676457cb5b5e4866ada8b316da1e7b6bc8aee5be9756e3e84886b8be44589160f2672533264c58be1c5504d431e582d5babb2a7aedc76c7347d66a56812a7a9eb604050a10542b094ad3e97aac4b93253313226f74c420ed81082a0a3a90eb1656106dcb179863916b9ac227fcf713919da6d0a448a618c5cdc6f3b137e00c3e3f2b2ac36ae6f0f9581f771f915c9eec8d8af84f8669ad8645191c6e4e33d61229f002c58be0424ce46664c98a140960a88809e1db886e1ece22de27238cb78f7c17c6baa35b46951114575a542b5550a2b142515256a9eb7aaeaaeaf22acda32314e3fa2aa52b5abd4e9eb55a91502323a9555ac292cf1a34e34f3097169dbfe7dca3b59c793bae2448b09db07974c89b1e40c4c4cccb73ae8f5e560e57129c47e3d9875630e27f33f2db88b38afa8b550dc066d7122f810458b160f2672332c648114acb25504d81e37bdc656a1f05b8c3c4b70c7833c0ff9e1c10e0ff0bf03fcf0f8f27c768e06be31708637d76c7b30afe32fe2b2b8cbf896e28f1438e183f53ea9c638cb8d5d0b4fa8d66a6a050b51435b54686a2aaf9a4c99659664e1f29f15e7d392ccf8d59c29c64091618631b0dc72088b0a014539596ce488492e2fa9abd7415aa00175087a7eae0dfc6f22917c0822c58be0430ce46660c9822c4964aa2020640c8fb1ee168bbddedf6fb85bee369b3bf6f3d7d7ebf48ac007bf7f77d86ca3946f63a65f594d68d4d47d618df5fea9c36e3cf1e303f34f1a78d7e2cf16dc53715cb71192990965589457661f2789f2fc3f9827335e09e21b8cfccb30fe9ddc6df8b6609f8de37c693e3799f11cba73390e3724b824b5ec5e595f4ebd40821861861f18d7715c92cd0822c58b07969c84cb5c940044968ae2163febff00d78f98afcc87cd3fd98f99afcd07cc97e5dfeb7fd72fca97e4c3e4c3e4bfe93fd1afc83f77f77f77f7bfd07eeb73ff00bffb6dce7ee9e74f39fb879d6e7bfd01e7cfc887c88fc8cfc93fd1ff00a1ff004079ff00defdcfdb3cc8e54f267953c9fea9e4cf287956e4f31325114051b1626462f218fccd1f243f22c7f94d1f2b7f94ff00ac4f92d9f29bfe53c87c868f9153f2de5798aeda8efb72fcdf1390492d1841c94035e1c91ad2cc6c8e3793f7fd8fb0b92b96b9632fed7da3919b65b45f84dc5fe77d7b421530d450d6d5facad8decf635e73ff004bf4bf4bf4ff005ff63f64737fb9fb63991cc0e4ff0053f4bf4c72ff00b1fb239afdafdafd9fd8fdcfdbfdb4e6bf6072a3931c9af243925e48723fa1fa0b9df6bdfee0db24a35795458843950afd89476ca5cb4cff00b0dc80cefd4fd2fbd5667239bc4ce4331ace2f0c156e6b9b4a384afbecb4e5732a00ee6e73d93c6e6f53165999839d4722724e4b6637227961cbfecfec9e6bf657903c89cafb1917de50280766187c10e8509762854284f4b63ad071feafd5fa9f4c622628c3384708e17d2fa5f4feafd5fac71ce2fd6fac28150a42880efb0b3dbedf78cafb7f6bee1cd39c73db90fd24e4450cb1ac0bd8b0808b6bbd9fd82df76fb65361e37239183860ef94e4a84ae9e3541edbb1edb2daf8eb44d83759ac7b96c3e39ea789cfc1b7d650c30cd9309eddcbf6ee5f600863586c7b3dbecf6b5af62d8f6172c8ddbb960e2d6b7da2ef78c8179bfecfd9fb3f6c66fdbfb7f6d730e6fdcfb6b94335738670cc193f65727ded68b3dbec36f6f633b78286a359a2a66b0d6c03ec3025d194bb2b8b5dcdccdf1fc4e7f93e3706a453959569ad14f1e823309cd65a51657c2b6c9d728f4ae7d7c2e50f0e315e8bdfe47fe93fd10e70f36399fd6fd51c99cf19a2f36084ac151aded652853ac2492231248d6c4d864b4dbdfb4ea21214214f50c5fa870be91c3fa4708611c25e3ff3871e304617d2fa630ce27d4faa719b1febfa5ea2850a95610936539b5f2aacf87763c66161bbb9b3d85fb54b9d91838a59017cfcdc6aeba997066ccc8baa6960e29e0332d82dc28b55b7be6f1b8fc8cda051f5bebfa4d3ebf59137d8582dec1fdbf67dc198971e092c5d881d3d3e8141abd613a74f57aba004eb4a4b03b2ddcb76ec5fd9ed170b8640c8193f6bed7da195f6bed9cc399f74e61cd398737ee7de39df70e61c9fb0323ec264dbcde3679b56afcecce1b1b8d3c55bc19e230312bab483b731c863e22057b060f83393be9ae5b3b862322dc72a6e3929c664ec4e493167249b2e6cf77bfdfef368b3d9eef70b85def178b4e4fb19cb7b19cb331b0d86cf677f67b3d9dfb8b3dab93f68647d9fb5f6bed0ca391ee17fbfdc6d3677066b4075e9eb150a7d3e8341a0d0d4fa4d3e938cd8a718e29c36c418870ce19c7f57a453e9f5fabd666846c9c3a4aa56ed51e533b1ab40008f660ced997e2a83d9a5e311f7ca5d5a570d56e2f1d4760d9cce0b1b7dded36fb0d9ecf606075a85cd8cfb03f2bf24f13f9278bfcb7e2cf12389fc75e1cf1678efa2710e39a7d3eaf4fabd66bebd7a74ebd0d5ebe9aebd3a85d058089dbb7b05becf61b5ae371b8de720e5364b657dafb9f73ee7db394320dc323ed7d9393f64650ccfb7f68e670d6535babb5af64ad4824584621d72791500ce4bdb387b77c95955b5c4337d7a651e9845f8d380709b14d5ea0a6184962c5fb160c0a9f584ea55abe853a7520afafa98434226e0017a75ebd7af5ea40046d4efc6c7f007529d3a7ad91ab359afd5ea6a8d2696a7eb7d5fabf58e31c6fafe8faff5febfd738df5bebfd538fc0f1fd6c72735d2aad1a18cf61c199b914a6839865c786b492f4b2395082035b67e2ab02719f1ecadeaf41aca90eecc5cb76df658ccacb50abd26af49c734fabd0d41a0d2286a1ab6429d027afd7eb09eb2813a1560475f5f409d75ad6a750817447824c2083e4c31e6d443e35aebd75ad1135a9c760aab173702a17abb33a0c97c199f720d95d90cd8cd9f90cc993f7aae4d6dd82ad2daabc7c416d76556076b2d6b9ee2e5cb86df625589acf7f60b3ddeff6b3fb3dc6e379b0d8cc614f5fa82ec30fe766184051089ad6b5e0107c1f0618d1898c268868c3a80475eba87c1135a2212671d8fb736032e8e018cdbb4a6457588c7b77eef18655e519ee6c4cba2f8b0b25d955f13635b7655b936e43ded6bd8c49277b2c0960dbae7b0bf6d957b1afadcc24c04b16d96edd8b96562fdfd9edf67b0d82cefdfb97efdfb970fdfbf7f67b3d9ed361b7da5d9fb972fdcd8d67b3bf7edd8bfb3d9ecf67b0dbeef61b7dbede36951a74b0bcb1c967236cd6c5407b12b34558847865b45f4aca6caee4b95d4d161aefbecb6cb6d72e58966d99b2c26f622c49e8f47a3d269f47a0d02beba820434fa863fa3d071febfa4d3ebf59aca7415f4ebd75d75d7a7afa74d4d9336446257a142a50a94e9d7a9226f5d4d613d669f57ac5650afc7f004db2da4921c12a5802419a0190c00d6498411635a0ad455aa35bab97a0e53bbb9b0b1309304309f1bd82a41ebad68a7445ea53d66b357a45457aea6b414a32eba9057d7d3af5ebd3a7408535d7af565d15d786f041f021857a1435fac546af50a8a74f594e86b159ac5787818b8cc183172d1c17630802574362a5df66f0a5cecc60615babb971ca4495104ca6ccf47762d0c24c30427c12583081bd9a9bd83ad6fc6e698930c1e47823461f27ff00123c184ecc24f93e483e0cdf9defc6fc68882680f8de36cb3308eaceeec58e9a6c0adb26f19a32eac8aee7e4ec6a6596bc12d97223d4ca56550152f1ddac662ddb6618419b337b0499d8b0f3dbb020ef7bec66f64ef7078decc3fde87f27c3124c261826cf9d98619d75fd68ff0023c54ab8eb0c0ae6cb59bac21989d6bb65e458c6caf22dc86c9c6b6fb2ab4b1362de8eb43a32324470f45bc9d7b249dee1fe1a6e6c9d862e2c36fb7da1c3f7167b4b87efbd96df6277dbb6fc11fceb537b277b3e0c3e0ff1b2dbec61fe37fc6cf81fce397bb7d98c777b1acdb312b082436558ccc6b372f6c1b335d6ca8b0d5d2f943ab56d5d819486e4d0c27f8309dc30cdf62dbfffc4003d10000201030106040504010303030501000001020311211004202231415112305261051323719132404281531443a10633622472d115255082c1b1ffda0008010100033f00f3b3b99ddc79392ecc9733e7b1e992c215d0b731a60c79bcc6f5b8f23b8c7db5c790ade43d2c210b4b546ba3dcff00ee6fec60e2672385fd8e3df7bb6fdce599d33e5677f98eec7b99fd9e0ce8b4c1eda5869ee5b72c231aabeade88b085b969178ad54b6f977384e2672387fa38cc18f2b07333e667cbcf938dd42ddce8c7a233a72fd95fa68ac2b688888b6e216e3d51efbb6dcbeb665e36d1f865f62fb748c19672385fd8e331fbbb17ddc18d33a634e5b983064cee6373998dcc991daffb742ec2d1763d84972dc5a2168cc97d52116d33b98d6cd174996a727eccf16d726709c4ce4709c6637f1e5f2d31ae3731b98d3061e99dce5bb833bb8decee6476fdafb08f6d7d86fa085a584b7d8d9cb456d6fa5d6fe2cc50a32cdae84f6a97dce1389e9c3fd0bc660c6e3be8c7b981e8c7a72396e63796b83060e667c9c1933e7675565a67f759df6363c162c25abddc6bcb4c0d51c763ff0050ee70996647e1388c18d16b916f5c5ab1af311830635cf938d33ae4c6f2b0b5b6bcb7b3e4a179583067758d97e9a5b4f7158beee56ee74c23e93fb1ff00a86709932701c460c6ee77702dc5aaf371bcee677b1a675ce97ddc698dcc1cb731e563c95a2ddb5c7718f5485adc63dce5bdcb4fa3fd1f5d9c264c9781c5b8b4f6f33dbca42deb89ad5df478ddc6ee7cbceee371efa168f796b7ddc191dcbd8484b445f4c6ee77eda2f93fd1f599c07133270238d9831e65f442d73e5318f79085bc84df233baf56318f5ce98fdb5bc9ba32245b565c6674c6972c677ec34c5f2adec5eab384cb328fa67198d33a21792bcbbe97d5efe7cd5bd7dc6677b3bb8df42f2b3a32fd0425d0ce9818efbbcb4b1733b98dcc9f4ffa3eab384e26651f4ce33060cfedde98f2519dc5e72deceff2d56afc97e4645a21585a37ae7c8ceb831bbc1fd1f599c2713328fa671e981dff006d9ddf6f25790b5f633e5e74c7ee73aa2c634e7a675c19dcc6e67731bbf4dfd8b566709c4cca2f4ce27e5a179b916ead71fb1cfecb1fb75a634bdf4cbd703bee63733a637fe9ff0047d66701c4cca380e27bc85bcbca4674ceead71a67f78fcdb79cb77999f37264c6ff00d3fe8faace163f13328e138cc6af718f5631f71f979f231a675cfee33adb4cf98f57b98ddc6f5afadfc9cf93f4bfa3ea3fb9c2ce26651c07198f3179b9dcc6e634cfec197fd967c9c7916fd963cde0fe8fa8ce1389e9f4ce331fbbc0f5c186634cfee9129ae76ec548f35a63c97bf7deb8ae67c8cfec31bb7a7fd1f51fdce1389e9c071981d87fb6cf95933e7e4c6fe0b68e4ef61415dac953699f862ba65f448a7095bc3e17dd7264a3efe73df9cb926cdaa72b2a53b7dbb93bdaa5d36ae9f44cda629b52527ec559c63294bc37e9d8d9b66c4abaf17659641376571afe28a0da55295d7571c14f6b8396c9594a495dd39625fd77274e4e338b8c93b34f9ee5b771e6fd37f63ea31f859c4cc9c271983919d73fb5c6ee4e7ae77f1bf83263c9f132318f89f4e48adb4d68c211bb6ffe0a5f0fd9fe453ccdfea90e6eecb1197e9e64e0f3176ee2d3060c7956d2a5495a09b76e46cbb2f1579a6edfa17ffd2852c52a31491b4ce4ecd24ba246d7269397236b8269493bf73e3146ac366d96ab8cb129c93ff83e35f10f8b54a7b5557529b85f2b93dca94e6a50938c93e68d9be2fb3b8d4b436b82e19749aecfdc71934d59a79d33e76372c7d27f63eab3819c5a709c660c19fd9e35e5e473d73e4d842d5795e222ef2788aebdc7564a108ddb7648a3f0cd9df275a4b2fb7b13a937293bb7a2229a93ebc91194a54e78cfe09d377e6ba3d71bd9dda936d462ddbb11a51f995e4a2967c3d59e0baa3051f7ea4e7394a526df51357bbe6424e492ca2c9dc9d5aaa30bbe6ff055a9f12da2551352751acab72c0b63d85579d9ceb2bdd76e9bb28494a2da6b299fea23fea22b2d7d4b747dfc8bf979d3e9ff0047d5670b38b4e138cb2d33fb5e463731bb8399c5b8bca5e4a1d59dba75646ea9c3f4c7fe590d836775ea5be6b8dd2ec4f68aae526c4588c63e2973e8894aa2cf2652af1f0ce3e19afe7ffc9528cadcd0aa7146c9f6251766b3bf6d15993a9751576538d19d4af2f0db92b9b36cd786cf4aed63c4cdaaac9b6ef72ab6ee3ed7b8bc16ea3f0b63cbb32fb54ddad6582943fd2578452937252697f639fc0b636ffc6b770529ed95366a96f056834efdcda362ad2f14783c4d45fb6f674e5e670ff47d5670b388ca384e331a67f638d31ae34e5a635cebcce2f2ede4bd6ab6947fbb15614fe5aebcd90a31f9f5b9daf14fa13da2abcf0df1a329d2b397e08c9dd94dcaf729fa91e3595743598fe08cd25359ee4a0fdbbefd4a92b422db367a4a32af53ef146c5b2cd7fa685da5cd95ebca4e52e6ef612fb92e71253959f32fcfb916dbbe4bf0a76b138ff2e6f990d9f688b7ca4d2363f8a508d2aebc5152525676782950a30a54d2508ab24b7a5b3575560f897228fc57e1de0acecde13eb744f66aae2fbe3f67c1fd1f559c2cc9931fd1c66118f2ee5b5ceff2f27060e66746318c7b98dec6b8d197651d9767729abc9ac11aa9d79a4a29dd27d4751b845e1634c964db5776ba44aa4db7d5978a9497f4538bc223295aec945aea892b4e2f9f314a3ee4a2fc32581b8f8e194b9fb6b720df1548afecd828bbcaaa9fb228d383f914d45f2b956acb8a7715ec4af2f0e58d538f896494df2690e0972c9852f15efd08c7f9119d4591f896302cb6ae4e178cde172646514d3be88b0b2619776455a0d47c4ed721b66c49ff0038e535d4ceef2f37e9ff0047d5670bfb1c464c1c460c7ec3267771b98dec69c4675cf936d1e97dca7b24fe5c178a7ff08ab4d27f2937d49fc47685f361e18457346cdb2c5d2a5172b229df34657363935e28497b9f0a86cd2f954a55aac961b5651f7284aa57a55a5e194a2d2b652f614aa6792366a3f323f2272f0d4f9775c9b365559c5ec956f77d19f0cda9da3514657e4c8d6834a49dbb1f498d1e2c3254dde2c8d48de2ad2ea877b316c549462f8a4bf057a9377949b26a325293f13657aaf33b245936ddc8bba42ca439c5bbf215f32fe851e9726e5e2cfd852b390a9c6e86d5ee3942c991f073c9b4eced38b7257fd26cf3c546e0fdd1b34962a47f253b7ea45157b4c5523c2f477c13a73b3e4c8cad5216b359dde5bb9f2381fd8faace167119384e331aaedfb0cadce5e4e198d1f898ee318ee3303d1e9833a64e4331affa5d9db5fade22894a729cf3293bb6265482b430bd8f13c908e7fe05276b12a71695f27feaa1cefcc4a6fbd9d8f886caaa78f66f9c9d775538befec7c2e9d6b4f6769b59bc79773fe96aaaf2516fa24bafb94d7c436d749cbe55d786e52f876c12af53f4a691f03af6bd5517ee6c15e2a54eb4657f713434ee853c5ecfa12da6178ae28ae5d4ad436874e574d3c9195d3e7dc8f86ddc9cbf0538462adc4c69ddb5fd0edcc57bd8574ad72d8b5afd48f8559dc4dda2d9c0257ce479b8ddd2437d10996e63571a7c895d9ec28c964f17049dd3434eeb93d33a72dc465698dcc69f4d9f519c2ccb32709c660c0fcab8f76c67ccc18660bdcce88464c8fb0f718db1eaf551577c912da6b395ad18bb21dcf6d2e658d318fe7c7d90e324c6d5d3366aa9a9d283fbc4d8b9428415fd8a7b3dfc292bf3b0e9ff00d396f5d48ad36cd9da74ab4e36f73e39b1f87c6fe647aa66c551a8d7a3285faf43e0bb62bc2b252edd4d96ad6f96a71f13bf5e650f88d2954a768d65cadd4dab61aff2f6884a3676bdb05295bc2d4bdd1ec2964f1664f1d885b04945e7255f0dda5824d5ec214b29a44bc2b88529ab731b959893e43931dc6c7918cc19b9e177215a9257c8d3d796ee7c8e03ea3fb9c2ccb328e138cc19236e5e4e7c8c2dec7918d33b8afba85bb6dcf97b334b9cb02e4265d97e87d372b6123c5278145610e596528ed328f5b721536b17231e774507cec5356b58f134c51f876c5493ccaa37f83023b1151f72ac25e284da66dcb6a838d5978ae4e854f0f894ad6f13f73e09f11a7f2768a5cfadaf6365f86d752d936953849789439dafd08395a7c2df729b96249fd9977645de45c933c386f0293f0a5d08bea4548a7e113ca1259159ab732cb04793174d6c8b963c381c26b2c8d5a6a51776b999d396ee4ce98dde03eabfb9681c4cca3819c6709c86d0b756ee45e5e0c6fe1e992fafb792bb1eda7b6bc74e3fd976724395ac894e4935d514d509412e6b9928a6f16ee465369724428d26df444e1b67cc83fd2cf87d5847c7523195b299b0d658a907fd9b3cb95bfa62725676b0e8c65294f0975e86c5f12dbf66a1b34fc7fe9d3536b95df44548c731666c388cb588d2a3576ca8ad64e34fdd8dcaf7e65d5d907cca325cb2caf46a78a93b7b1b4c7f542fee45f3c14a4f9a20db641ab89f222a37ea7872d0dabdec2764ba1272c8d8af923ccbf22c5f4c916cb2254a56e6ba9192525c9ad396ee519d31bbc05aab384e26651c2ce33072f231e6e3731bfcff006284210bfd52ff00da26cbe49292c8be526b9be64630c8a3465657bf41d0a8dd8855d9a518bb368bf31742a47949afb336ea6f82bd58fda4cffa8a835286d5276e92573fea2db764742a57518be7e05e16d128cafd6f72b3596c771bea58adb7fc4286cf4d5e552697d90dfc26850d99a4e94795b9b36bd8aa786b41c4977386f722fa644c8b5c91426b315725169d36d1b6c159e50e1faae88c95ee46d65231dc8b5dbd8bc9dba0dbc8ec64c73319137a58c0cb590e0ef73e653f0b795a72ddcf91c3fd1f564709c4cc9c2711c3ab43ddc6961f9b831bf8d33aa16ff2df635b5fff00ae925d4926854a0fc6dd9f228b85d4afec377ba48a736d94dae647a3135739888f621916e78470a753e235e9b526fc34aeba771a365dbe8494a2bc56c346d1b2579539a6acddae3458974649f36658af6173c3212cb8a13582bc73166d34f9abb1b7c49a628ded2e63922d2cbc0dc9db9166eef0394f2646d0b5562383c3b52f7d30bcdfa7fd1f559c0cc991780e231aaeda5996ddb5f47ae7c8e460c7939d10adbb8dd5a2dc6abd397746057145dc6e495c76e678d5992cd98c69f363716849b1688888888abf13f89d0d9e09b529713ed1ea52d9765a5429ab461149218d14f6dd9e4fc2be62ca64a94dc649a6b44606992e686d5ae4962e4f1923d4838f2294b9a452bdd60ad1fd3945657bae43f0f21f7436ec90de5e0b60c99168dbc3271daa0afd4c2fb79dc1fd1f559c0cc99380e231a64f63d84598d68cc8eecceff2391931a72d3063c8771f909210b45dc5df77c546325fc592da24e14d5dae88719b8c959a7d4495931b635d47dc52165a1a638a673b97ea7be885dcbe9fe8f6296d7563f52b7e9bf48ee584daaf08f5e239e9611e1567d48b58766497377192b96591df2c4d732c295ee884bf891e888c57215322ddce3c0a321498ba0ed7b896d106df52f14fd8e467ccfa7fd1f559c264c9c27118d7d85a7b0c6635cbdc77ddbebcbc9c1cccef677123df5b8b5f73e6d3945f53ff00a57c5155a90bd3bda5decfa9f0eadb546b6c93528ce09cad8b333cc67b89ae628be629279132d72eb4efadcb65b25f13f89c2325f4a0d4a7dadd88c20a11568c5592f6dcc14e49a9c534d0b66da1db1193ba2ecb09ae4464f2453178702b60974436ec4af8465608be446c2121ac9e224b90dabdc6fa8ee5d60e57647e6c12ead1f4a3ff00b518467cce03eab384e22cce1388c6e32fa2bf239e068699933b99f330637384c33898f796ebee33dcc8b46cc10da236b2f17424eb3a53b5393587d19b5ec751a9a76e8fa0d0d8d0da18e56399df76f225566a2b2dbb2447e19f0c8a92fab51273ff00e34c69ccc694b69d99c1c57893ba7d474e728f663632d24cf1312bab11b0ba1dc5e2e442c2b1663b8ae5a264e686c93c2258b96e45d650be743ee2f950fb2308ce98ddc6ef01f559c27119384e331bc85db44fa1ec38dd8d31e8f73272f3b0ce27ae37d8f445b4637a3194aac7e5ed1cba4d734350942a4555d9adfab9d91b24a9fced8ed6b7e94fa95a8c9c65169af61d876d79975a674bb31c8556b2daea47820f86fd598ddc6be097cd8ac49e4b31df989aee85d1d86b0311710958497322893eb63df22b659e2781b7a24d324de993c3522fdcf150a6ff00f14635c795c07d56701c4cc9c2ce230b7bdb5c0acc5665ba167b99d391cbcac6e59338b5c6e31eab3ab1dc7b8f4da7674e1195e12e717c8a1b4534e854b554efe07c896d552ac6ac634ea7ff00efd8dab649e6375dcb3b342b611d8cbd1086d9c9d8adb76d71a718f0a7c4fb229ecdb3c29415a315bbccc18191ab4a5092c343d9ebb8f4e9a58ca6490ec6327804dded615856237763036c9498d8eeae248b585925e2c319c4b25f65a7f6463cde03eab380e26651c2ce22f15af3d50b5c3159e0c32cf7b918f2b1b9833a67c8b08c8cbebcb7aad0a8a74e4e325d8a7b64a3f325e0aa959497527566a8d56acff915365978a2fc517d8f63aa2d7d6ec7d8afb4d6853a70bb7ff051f87ecca0b337994bdcbeef339ee53da216973e8c9d1aae2c4b997664687c99677b9688fb927dc9b7c8931be859181215b9e99132ccbb3c5b14316c18d71e5707f47d56701c4ce470ff00464c2f2b07330ccbdde5a63cdc32e8cbf2ed7325d99325b4b69732674b134d466ef1bf5e84eaeccfe5b55236778be68a72f1593ba64a29f625e279424dad1b97266d3b4cd5d38c7ab66cdb0c2d0576d2bb7e47318f4653dae93bab4d2c344a9b7169dcc094723b7224d17e65e563d88b1ad55b264498ac5f4772e35245f61a7f6f271bbc0fec2f9ace16713328e1388c6b6d6fbab22b3325b4cf92cc6ee1e98660e2f271a5db15c5a5b72eb794e693656d9da9509b8d95ae8a91aaa4db52bddbe9716d1394dc95fdb026dbb95b68aaa9d38f8a4f9236aa538ada26a2dabf8573499b1ece978609beef25ba2397918ddc14eb506d5fe6ae4ba13849a6acd31bc0960c32fc87726fa16396082426d5865c8f242ea3e83192b89c917d863e4e37781fd8faafee701c464e167118d5699ddc18661992ef4ce982d6f3b060cf9581f633c8c722de4ad20eab72574b2272924925a58bb2954f8a45ce3e2b2bd8954f88556fa3b2fe87a72dfc0edbd623520ea25c5d7dcb4b91e2e8492f0ae475624c6cc69779229e1d8b1689795ce8348b0adc856389586f6369f731e4637783fa3eab38199328e1388c185abbeab4f739981644dee675e5bb8f231a67cb42bf22da67ca70d99d6534ef86baa149b7aa293ab52ace56f0c7039ed5524e5e26df3ddc6f6197befce8f86adb8679458cdc4a5613635c87a4b921f31f31b562cb03bdcc8af62da647fe91bf7f271bbf4ffa17cd670b3272387fa38cb44c68f46996d108c6b777d73a72396f63cacfec6fe428fc3d251577d4c3d5df04b66f80d59f87335cf5e464ce98dcc18661ef60a5b46c0f6794578bf8cbb0e9549465d1d8b32ecb0cc5df2133036f49224a37d2c644cc8ae5b625ae77b1bbc1fd1f559c07119383fa38ce13067716b6d1e4bb7b99d791cbc97bd9deceee45e42dcc96a097b0eecc181bad0c5d363a3f00a11f1664f96ee77f0233aad5c257ec46a4615a1fcbf57b0d0efa32d863e911b8924f086b2c8b646c2b60e78eba58c89c871d821ee7233bdcb7b819f559c067fb32701c663c8b0cc174c6efbb9f316ed8cee634bfecbc534bdcb617445efacaaed94a297f2478286cf1ed1b5bccc3dfce978b8be4782a356c16631a3c4f2842489126c4acfae9e2c1cec59e97388b6c1497b1833bdc8c6e60fa67d465e065e9c07198dfb1ccc9832cceb6d396e634c793cf4e634de8fb98f256e5b79689ed097b31aab332cb96155f88d3bf465f688c52c28af330cc6f64e6598ab529c97ea8aff81a2e6744ef922a291e29586989b2f1b8d31b1be8598cbc95fb9f2f64a4bdafae7cac1f4cfaace06713d380bccb2dec8f4bb660cb33abb9933bb831bef5761a4c6a5a5f4ce98decee2f23eb44bd4917beadedd169751bdb64bb24b4ce99d71e6b1dcd965426e5e2f1b4fec285595962e450f9a1a59129322a4ae2f15d171365b0648c9222d174ec38bb58bd682f747d0a7f6397918d16bf4dfd8faace06713328e1388c6e2169cce7a634ce975aad71e4ad5986618d4c95c921eb8d72677f3bea55ecfb31aa92b772eb4c32a7fac8d961b2db7d56babdc77d30637f3bf72a494aab4fc114f3d052a924bb89cac5ac5d60497b8c71434588b5922d732ccf173224669db9928ed94d35d44a2add979df4dfd8faace16713328e138998dfb9cf715c458427a60c0edb8cc9cb7f1a277c0d49ad2c72ddc99f2d8eda5587ccf0a4d3e6665f739eb27b4a8dacbb8a3b44e4e596f1f6d1699d71bdcfc88ed2e368c94639a937cadec49507b3d395a9ae4ba92526da6d5c8c2506b0d119c2ed58a6d3b733c4cc722fd071e84ef8276e634f98a5ccec78965962352bd397fe45b1ede77d3fe8faace0671b328e1fe8e231bf8dc63b8c7624993b5c92e83ec213df6fa17e87b0fb0d6981d98acf071bf232675c7972f9d6bbca2d519cc65cf146528acd8adf31f8dbc3692edfb4957776d460bf54bb14e10f954528c1736bf97b971b8d92b90da29b52c75274a3e14f0960a9464d5ae8849bc7e48cf910bdaf920ef7b107d88771f42ac792271256c44765712aa9dec853a717edb98f2be9ff0047d5670338999384cee6d3dd1b5765f936cf49b6aff6cdbbfc4cdb127f4a5f836cff0014bf06d4b9d297e0ac9669cbf0555ca9cbf0554f3097e0a897e964fb327d84fa117d0f61d86896e5cc210adb961e4ba63f1b18c7718da18c771f61f618c631a1eab722b6b8b972b33c35a59bddbd6c51a1e28c9f4361f8a539a85bc6b29f72b46aca1e1b3b36afd6c59f95cf4ceeceb4fb4565bec46df2e92b417fc97d5b8b14972c14ddf84a7678b0a0ef093bfb9b5c5dd24cdb272b78125dee55e6ea7f4557d5151f62a764564ff4b2715669fe0f0f36712b33e65349bcadcc6b9d31bbc1fd1f519c2ce2664e1fe8e27b92ff002157a54457f5afc15bd68afea4577e964fd311b5ff006e027fecc483ff00663f82937ff623f83667cf675f8363ebb3c7f06c0ffd85f83e1dfe1ff83e1dfe3b1f0ef4b3e1e7c3fbb3637fee1b32ff007514ba554671550a1cea2628ff00222ba915d442637c8acf92368b7e82be7e9cbf057bff00db66d17fd0ff00057ff1b2b2fe0ca8bf832afa5953d2c9dff4b257e44fb0edc86319ec6796963db46318e15632ecc5f31493c33996b9e1ea6d4a7f4e4e3f627b3c92a9368f87edaa9dda6de2e41e68cd3be4dae9fea895a0af28b4b731af3d725f04adc863a93515d7a918c151a7fa561beecce74573b1915859c0d3d2e598f55a26ee529738c7f0504efe148545e3042a25193cf7deceff00d33ea33819c4cc98389eb621e9643b329fb90f723dd90f5323ea17717717717a90fbebf62fd88f6453ec8a5e946cfe946cfd8a051e97fc90f54bf235fee4bf24bfc9227fe4654ff2ff00c1597fb88adeb8fe0ae9feb895fd48a92ec36f9445e88917fc63f8217fd1129f5a68a1fe246cff00e146c6f9d247c3ff00c67c3bd363e1e7c38f86bea7c3bb9b03fe46c4bf91b1fa91b2fa91b2fa91b37ad147a4d14bd48a5ea447a490ff00d2b6a49b8a24e4edd09598e4ec28bbd892656a4d5a6d1b5538c578ee2945295bfb360da69a8cd459f0dac9f82767d8a76e1a89b2a455fc51655b5db48acbf8b2b4bf8b3698f38f3455b3e16ffa3699dbc3093bfb1f138a4dd2e7ef91a8c7e6cbc0ef97ec7c3e2d4957bbf7c94e49ca94eedfbd91fe87c54bc49cff00935d0a5b3c653a92b5b9153698baf2568c9f0af6ee64771d88466a3292bbe48bf51317958d19384d34c8568a8cb12b6ee77fe997a8fee70338d994709c5b925d593b7325ea3ff220faa21dd10be5a297b1b3be763667d51b2f746cddcd9dbe66cb6e68d97ba364eeff0026c7ea364f51b2bfe46cdea366f51b2fa8d9bfc88d9aff00aca1eb450bfeb287ad14df292fc897542ee85dcf72dfc87ea24961955f7fc95bb95fdcabee56f72af6654ecca8fa153b137fc4a9d89f664edc99364993eec9f764fbb2a77654f532a2fe4cad7fd4cab24d393b343536368b2e4243ee586a238b5c4ca917893bfdcaf14bc53b3fb959357967b95632bf89b45e2af2fc918dfc714d742978ae9220f9a366eb4e2518be18c525ec4e56b3c159de5e27cb9152fe3f1bc3e457abb24acaca5c994e84655272bb368f8bedcbc575453cfba2318a8c7092b21f7d28ecb07152bcedc91b4ed1f1384ea4ae95ec8c0bb17d158a2f6bf90b32b5f733a256bbb5f45a589c249a7c855a167fa9210844481029f721dca7dca7dc8ca181b9325289554d951128c728b4b723dc8f72371772dd49772cf98fb8fb8d7565bab1fa992f532a7a99557f2654f532afa9957d4cacbf93fc95effa9fe4afea7f92bdff005b2afa9fe4aaff00932b7ad957d6ff00256f5bfc95d2fd6cafd64ff256f532af5932a5ff005b27ea64fd4c977249f31f72e46d929b2243b102994bb144a2ca050650283ea50ee8a3ea28fad143d68d9fd48a2ff9146dfa884a93b357e835cc57158f715ecd8af818d19c8d752f1cb2fc9928ab2913514fc4491c3772771cb989279c8f3c5ccff513505caf9fb14364d9a56c4629d8da3e255fc52bfca52c2ee53a14b855ae58b9fe9e2e14dde6d13a8dd4aadca4f392db4a6ba45e8f4b9f2a938c7f53c2254ab42ab6fc5e2577f71349f46ae761eb52538d3837c2eeff00a16d34537fa961adcf93b52a72c29aba63a3554af8367ab4d34ca3dca36e6525c9914c8aee47dc8fb91f723ee424baa28b95db365b7ea46cceefc68d9bd48a0e386989bc0f444bb8fb8fb9ee7b8fb89f3624f98b4876c902040834525d0a7629be85229762914c87723dc8fa85eb3ff31fa992f513f512f513ee542a153b952f72a954acba15bb33685d195d74656eccac56ec56f72aa2a950a88a84c9935dca9dca9dca9dc9aeac9f7645be2e5dc5514a74e5e28c79bec32c45f445b931e89a658ba2c84f237d745cc9c9bcd90a38f11372b24db7c97721b07c3e2e708c6b4a3797ff00056f886d2a117c09e48508a49df58ecd41bbf135844eb4e5566af263ea28d49dbd2674c8a316df444b68aeea3e5ca285e0678f6783ea959e981362853949f443aae53e6e4d95365da93e517862924d3ba7d477d273d93c70fd54df890abd04faa5624e5e0bdbb13ee55e8cabdca9dca84c993276264fb12648631bd5915d44fa8fb932a150add0aefa959732af62b3e85425d4912b153b153dca9d993ecc9fb925dc90c91344fdc992eec9a2431dcf7d176108425d88fb11f620fb10f621ec43d8a6fb107d8a7d914bb22976451bf2450ec8a1ec507d1141942c51281b3db99b310a70718bb27cca353c29b51c5ae34da8bbaee4966c5cc73c9dc4ba8ac34ad615b2849e9c4f1815b0c9358c12766d9157da6ac138c55e0df5654da26e9c1b6e4f27c9a2bc5fa99677d21469393762aed759d4936d27845b1e1122cea3bf431a7525e18d283cb79fb0d411c1cfa1c3385f93d18c71a36eec4a3c873a6dd86e9fca93cc79688f142516b0d589ec7b6ca176a2e4d0e328cd3f729464e328e51b3db91b33e8cd95aea6c9dd9b17acd8dff2ff008362f57fc1b13fe68d8dff00b88d91ff00346cef94e252f544a4ff00947f2515fce2527fca3f921ea4452e68a6baa29fb14bd8a4b922047d88fb11ec88f644089121ec535d8810b9023ec525cd23677d0d9fb2367f4a287a5147b228f64517d1147b22858a1d9141f4366365366ee50ee52b6194bb94efcd10ee43b917fc85ea3ff224ba92ee4bb93268993264c9952c542a156d8c958add995bdcaf7ea57f72baee55f736aa6d383771f8146ad18cfdf91b14e29a94a0fd2f2912baf0d48cafd8ad4ede28495fd8976122c262dc77e64aa4d453cb7623b36c50a30794b3fd9797cc973624590a29b6f912db2b38affb7176fb9656489761dfa1c33b77d191a54a526f921d69caa4babc181f84f06d967ca4adae07536879ba8e89c58e86d7095b17b1749ead6d2e697b9e3a29379445d4f15f9a23dc5dcf73dc6ba8fdff0023eec92eac97724545d5957bb2b7a9955ff2655f533685fc9fe4da7d4ff26d1dd9b4dfa9b57b9b4ae772b35d4aa8ac55eccadee56f72abee54f726df364fbb2a2ea4d32a150a8552b76656eccafd995bd2ca9e92afa595574654ecc9dfa953dca9d8a9d8a84fb153b132a5fa953dc9953dca9ee4ca9ee4bdc97b93f7264bb1225d87d87d863ec2d23d88dc87621d8a7d8a7d8a6fa148a441f44534d59e4ad51a739276565fd1b0cbc6eba4b85dadd59b05472e171ed93636acaab5f74529b5e0da20eeff0004b674bc75a9abf257e64aadfc32585d58e2edf360e5dae6d11a6a6e51516f0ee54f0a6e7057e59e647668cab4ede2e513e6d572966ec515c852a9911294be4d279ead114287e095addcb34bf247e4c9ae5e2b688756aaa4b92e64a38e8245d0e15e125d248f124f4f974a52ec8724e52e6d89182f1bf5591d4d9a0df35862d2f57ee874abdba31ba319479a762aa7d4abee564575dcadee55f72afb955f72a954a9d8993ec897625d8935c85d48148a452652ee53ee536525d4a5dd14bba29f7443b91ee47b902246c4489012ec2110ea8a7d910ec47b10ec8837c9147d28a1d91b3f6367ec8d9fd28d9fb1b37536566ca6cccd98d9ca051f628b28f728143b947b94bb94bb94bb91bf322448f72e2ee2ee2ee3ee3ee3ee3ee3ee35d49151f72adba959722bdfa9b47b9b424f2cdaddaf26edcaecdabbb36a8bba6ee6dd25e17295974b9b4d6da210bcb9ddbec8f9928abb7082b2f72318e89df046852f0afd4c49b72cc9f53d84b2ddfd8bcaecc8d6cff793d1d2a3295b36c13bca4de64ee3581a762e857678a841ff00e3a35494573931f82fc86cb8a69e0adb3ce7195fc2f286338d7d87752ec78b6797dae7b1ec2ec2ec22244f62ebf49ec4481022b490d8caff00e666d1fe666d3d2ab36cff0029b5ff00951b57f98dabfca8dabfc88dabd68dabfc88da973a8995fd48da572b1b52e88dad7f146d5d8dabb1b4f6369ec6d5d91b4f636aec6d5d8dabd26d3e9369f49b4fa4afe92b76657eccafd995fb15bb159f42bf62b7a5fe4add995bd2cabd9953b32a7664fb325ee54f72a7b9326c992264c993b1227ee4ee4f24912ee489132649f3d2c3d5e8bb0bb085d910a9e34bf57ffc231c16111a74dc8956aee724da161a43d22b991f0b68becf1c736f4752aa8278458f6173434893e65f67717fc5e8e7b4f853fd28b70be4452c0ba915a2b6069979d8525633283e86cd6650452292297621d8a6bf8a1744863de6332445d88f61088dc8e8848bf522210b45612dc42f211818f71084448f622fa11ec47b10ec43b10ec47b10ec47b11ec40876217e453ec53f4a2935fa514bd252ec52ec53ec53ec43b11ec47b1122448102244891b9f26878dacc84b45e2577d47524e2b921a5642be7442b721b8762db343fb3e5d193be7a12e6f2dbe63b721098931bbd916ad287744545b7d11e394a5dd9c7c88b2fa5cc917865a5e34fa64773e5d5a73f5606e37f62dd077b0c6675463c9b17ea2ee211120889110c9df90f4b0f5bf4d18d0c63dd636cc16f3d97f22c5deebde5b8b49d7a97b3f0a7c4edc8518a4ba68b285fd9c2351e626ee497264a4b22ea59607fe969b62ad5fc0b94596302b161b43f0d9a3e5ed31974b9186ccddff561128c6e8c5c49ac89d973f720ed6121093155a6e16b3b13a526a4ad61d7d8e765c50ca14f65a6df54212b916452168cb8bc87b897422fa085a7b085d85a36890de8c687b8f7518d55bf60c7bf7dc7e43deff4fb22a7e3f178ed276e59d12ea75b89bb974accc13c76132c48e1c9e1d8a3df362d77dc4ba0ee26ec2573381b4494cf99b3d385b2b996832d27f72edb1a766ae36d231cf4c925c875e9dd7343a759a6bee88c636585d848bbe621e46331bb9ded9fd6bf250ff247f251f5afc949ff0038fe4a3fe45f92947f9a15ff005222f9c914edfa910f52fc99e685dd11ee85dd11ee88f7447ba21dd10ee88775f923dd0bba23dc8f7447b91ee88f7443d488f7447ba23dd11ee88f7447b91ee88f7446dcd11ee88f7447ba23dc8f7447ba23dd10ee88f7447ba23dc8f7447ba23dd11ee88f7447ba21dd10ee88bea88f7447ba177447ba23dc8f7447ba23dd10ee8877443ba21ea443d4887a910f5221dd0abed115cd2777f623d30ba232c57bb63781dad62de1467dc97225d0c97135624ed7785a2d127920db15b058bcafa2445b6ec2cd8f0c90fc29925d59e2339d1459e1ade25c98d36ae365aeb4c68fcc7ea97e497a992f5cbf24bd52fc92f54bf24bd52fc937fca5f92b27fae5f92b2fe72fc9597f2915bbb2afaa4557fce454f5c8a8ff00932a3fe4c9fad93f5b25ea63eec97a9935fcd93f5327ea654f532af7654f5326fab2a7a9a2aafe4ca9ea654f532a77654eeca9dd93eec9f7654f532a7a9953d4ca9dd953bb2a772a772a772a776547d4a9dca9dd957bb2a77655ee557d595bbb2af7655ee55eecabea656f533695c99b4f5656ee557d4abdca97e6ca9dd93eeca9dc99224ba92ee4d753e46ccaa7cc527532d754604394bd8b2690d2c9795cb8d60b3e64591bd85e2177d38895c77c88687c99610863c8bc5717857d8c193db46ac29c39e50d4da624b4cf9b8d10b772217617617617610b7d0b5f6dcb6fa16ead5f9485b8b55bac631e93da7688d28b49beac8d1a50a69dfc2ac3583a097512626f44958bb2cf448bb252959128c6f745282b5aeca72e71488bca323bdeccc17338632e6344e260659644268688b8a9aed933e7d87bab7908458beee7f64bff00c1227194b695184a11e1e2e69f74751f31df9176c4d8ba232645715c690e458b45b26bab2519d989be627cd9460eed5cd992b38ffc1464bc505629a8de56b942575e148b3b08566b46a76d12ea4a5d4c2b8ba21df278e84d2e659b2fd7f6b67bd6d2eb5421698fddafdc5e714fab28ecf4210a4f866af67cd3f72c262bb62771c562376633cc8b4db3884d96e437d456c96670926edd8ca65ac3bdee25045d89c6dec7856197964be97464b48bad2fd495cc644ee46323c3b44acac9e7c9ce99de6cb0cb0c63b0f542d18fccc6885bef733fbf6ab41ae6a489556bc56c47a2d10dbf615c4ae2931f25a647a634b459c6cb9dc7e2427453f63887e34bd8b0d49178afb6974733235245c68458561744296cf19db29997e7319fffc40032110002020103040202010401020700000000010211031012210420314113510561221430327181429106152333a1b1c1ffda0008010201013f0010843d5310f46bb5bd17916afce94363627abec68e74485128a1a24b91b7fdba12e0c6fd08650cbd2c44747ac747a576de8bc89f1ad963f1aa2f47d8b44842f0596318d0f5b176a1a12232a65f05f3a4989dbd521163d150bb78d59c6916c5ade8de8d9671a3ee5a5f0363d2f46bb53d544512968d11c8fc098dd12179d2914576af3a310ca28a194f4447568e47a31084c6fb588b2cbed92eda12d13d2b4a1223e06485e4b121ead68b4b1e88bd194568842d2f47a3d50bc8fcf63132d7f6286b4484848625a5ea881224c5e4a2cbd58eb4b125478d2f45a51565142f1ded0d6ab5b2f545f63d5b189722457033d6887a3d22364c5a5965b148dc597a2f1dd7d8c4fbab4687a782f47d8b92a84f565e8a363895a7a18bc689eac5e45154325e08b765965965965ea98fb93d1b2cde8dd6589965a1490da2c636365f722b5459e448ad28a2862f1a2ec5e4b4364bc0bce94514514568b4f45ea9e898d8c6c6cdc58e4290a46e134291637a3eca2b4ba382cf42456aca2f47fd88aa19262f3d94514515aa1e97aad192d2b4685aa627a2563490d0842ed45a32f598b1f964bf2d89783a4eb7e79ed89b69f23a286cad6bb90b91ae497b3df727a315eb7dd7ad228a1a2b5a10e4c8a697ec7624d928e8971d89599baac58fcb56753f937296d8dd124e4f967c7e0fc4e28431eef6c94ade886d5f6d15db1244bd89bbef4c7de865b2d88b2c6c722523732cdc6e1c8c6a95b232b767e73f312e92318c12729786fd187f3bf928638cb2e3c7b5fdf0d9f8efcc4baae3624bed3b1a4568dc5797464eaf142f9b32fe4b24af6f08937295c9bb36abf2592f0741d5251dac524d0c4cea7aa70cdc783164df14cb17f6203f2493b625fcbfb4b5bd2cb5aa636363958c6cb1c8723267da47a877cb25d4b1f5d35c2f7ecfcc6753eb30465ced4aff00e45d2749d5e38fc924da5c23a1fc5c7a3eb60f1e5b8cdd38929c54aac4d0d23f211cab2db6f6fe84a0fece12d1781a55425c8a34d3461eb1c523fae544fad93ba24db7cf36747d4384b6bf045da284bbe24bc926854725f6de899658f4be7b1b1b3732cb1b3721b43649a4ac72526c94d2259e97930cf74acfcbcdbeba4973c2ff00e88ac977be51ff00bfff0087fe1be9ba6b5937b9e4fb7e8ea5373b213c8bc3643a899fd4426dc3246be9993a586e6a2f827d34d2e0716bd1457ece452e08cb81b11165736743d4dadad91fec459226bc917c96b55d962edad6c7d8c93d2cb32ff8b2a933a9791adb04dc9bae0eb7a1974d0c4e7915ca3fe3ece9b2e2589bbe57a32f4b87aa7ba4dc5fda23f8172ff0ea297ed1f89e865d245ee92936fc991ca52e2a8da6de4ea70c953a67f38f816792f28dd17e4f8e0c9e0e381e1923e377e08c1dbe0dafe85688c99c5107534d7a3a79ee827de8489f924dd9c5e9b46bb2bb516362633d0fc68f46d8c7a6d33c7f831cd99f771252a6bc13f9324f7e49b94abcb230fd109d7fd3e8e9e79110c8eb92391a67c92a3a65bb97e894232547518763fd1499282364d78629645e7c11cabda14e0cf854910e94cd8a31211b144715e8e8bfc2bf62ef8325e49f91f9d2892e3b2ffb1b87a365e96318d090d138ee8b5fa324724252b6b89525edafb326f6efd15330a7255f463c5f68c38a3b45890b0a142da48c70db149699b1a9c1a25070934c7244648b8950b1c626f515c3175724b825296431616bd0f10e34ce8970ff00b11244fc8fceac6915ad0bb1f91f8d1c8dca8b19656943424288e8c9d3427cb467e878e3fec7f4d1ba663e9a117c09246395323e0c925189d26275b9f97aa3aec16b72f25f0c4fe894a5429ce84e55c918368861e7c18f0d247089cd0d9d1bb4c5df1244fc8ffcb5bd5c47a22f565b2cf7d9473ad0d16589b36a6f9326285f83653f04a11fa3d8b252306296595cbc222a95764a36a99d5e0706e97035c21a4c8e3e111c2990c3145451398f236cbb62b4749c3ff62d58b589227e7b2b44325a5ead8d8d965e8fceb4509147365086b492e18e49f1ec9a9987164c927fa31f46934df9231495216ab4c98d4d533a9c1f1cbc7025ec53e05968f96c794f92df81097271ece95ff362d578d591264f5f911bcb566e372252439098d9637a3d3d14310bb1b2b5bd32cab1b30dbbbfb26d247e3936a52f4de885dd9b14671768941c24d7ec944516989888c5114521c4e97ff70f7aaf1a32988913f27bd1c88cc52b2f81be07ad97d94531ad68a28ad2b47af532fe15f662a5eccf2a859d146b121212ec4343383adc4fca12e391ae2c51e3c8d8a4fec84d594a86b83a65fcf44515aa12a43e49a13e74dc4590916498f4a12285e0a28484b81ab361b0511a29946d1d6945091d6caa918d2a3a86ee31fb660558a3fe8b176bd6714d1956ccafe8dda3486951e198b259e4e9d7f262d2ce7b137a643de9645884c7a35a5702456885a24869695a51450d6943451d7ff9222da4895bcb0ff6635515febfb0f4b3f212aca84dfbf0469d51b13258532587829af0432f1c9d2bb562d5762f07a27e46b468444498ecdac512848a28daeca2b46c6dd8a453287e35657235af5d7bd09a68c7ce78222b85456b7a2d5b33750a117c99326f95b235248961cb1e53e08e69a7ca31e64dab439c5928232e27e8fc7cb8a7e7b1f62f0364cb7658b163fb3e187d89450b2237237a1346e45a2d1685c8f1c9af07c72fa36497a298ec8223e0e068e0b1ab28da6d248eba0e9331c7f63c528b53fa3a3fc8465c4991c90978687a2d16967539e308feccb91c9f2314da6a85d44bc59f3a1e63e66991eaa43ea2fc9873286452b31648ce29a7abf5d8bc12648f651b4a46d367ecda6d68e4a7f67272725b47cb3fb1659fd8b2cfec795919bb148de8f90f945958b21f21f223e447c88f9119e119c1a31b719b4fd13cbfc690f0fbb6991cd9f1be1ba21f95cd1ab4c5f98e39890fca6367fe6d82fc8ff2786bc993f3104b8317e537195bcaf737486420e4cc90dae8e049b64e324f9288be077f446474bd4384abd109a92b5a35aa2e8932486f92cb8b1a4705966e626b4e4567231b65c8b91cf05b23265f6d9644a545115667e9134dc50b1b4f94791e3544f12b3e2b3e1b5c12e9d8b0b3174eef94431a4fd19b2aa715e0c707267f1845579334f74af4c2bc36750af912e082b64b1c658d5154cc4949d7b3a5cae0f6b164fd1f21f21f29f21f29b872e06b928a457ef4afd897ecad627fcead7ecafd8d31589b133915ead68da108e485d97c513c317e8cdd136ff88f0cd7946c5ec5046dfd8e099b515526c94db5c79145b23150564a7ba4524c8c6d92fe29125fc10da31a314dee6bd19e3b6441d493269ee8c911e51451450e26d66d36a36fe85128ad291b50d23836a23435c8d2b1c50a2b91a369b0dbdfb4a7f62b15893bbd299438290fa6858fa383fa3fa18fa67f455ff512e9b6c5b324f968b76628fb6659d90ae49784628a4ac94f7323fe04e3fc88249116acc8e32827ec488cae1fe8e99dc0a28a66d7f4283fa1617f42e99b174f05e4f8f1fd0a8dc5a62a38fa151c14ac7e04921f26d46c566d1c4a292d2b5a28da6d36b369188a3fb3614cd850a1fb1c4da6d3ac96cc7fec6ed91e1f81e4e381ddb31a5e4ff27fa2496da12af662fa64d7fea5128ff0e092684e5f645a6c548e8952684a3f4251fa2e3f46e55e054cf5a49945236a291b515c0b44588a5ab1a29945695d94508ad3d77d0dd1f90ea374a93e0e6ec4c5e46b831c55323148f327c8d331ae49e35bec846d5197a34d1931ed12b212f4ce8ddc57ff003afbd23a31967cb13e589f2c47951f2a47cf1fb3e68fd9f344fea222ea607f5303faa87d8ba883f63cd116689f2c4f951f244f9228f9627cd116489f247ecf917d9f2216542c8989a65a2d168dc8dc8dd137c7ecdc8ea72a8e364a5ba5c8abd11e5890c8a3d11490fc9174c72b31cda233b899636ec944f0ecfc7c938b2df647593d28486ce4727e069d09689f059632284f4b148b1bd1791b2cf7ab14a48df242cb237b66e66e639322c72a3aacad8fc9c884f8126c567c6dfa3e095128c97a29f915fd0bc18a568cb1e09c4767479766457e1962d10989b2d8fce94efc14c634c6995678d1c522d099684b820994515d9e169ce884931a168b4e0f5acbc1d43fe5a2e688c0da914acda618f228928a52466c6b698e0b67fc0cc6dd92fe49138d125c8bcafd1d3cf7634f55adebffc4002b1100020202010303050002030100000000000102110310210412311320410514225161307123328124ffda0008010301013f003e0978108a2863169ed0bc904244c6f55ab1090b4d0efdad69f8f6591227025c88631f81fb6d0df23f3a7e0424ca6523b4a24222b54343d3d597a8ae482d495922f762624476d0cbf621f3ba1448ae44290b5432cba1adb197aa1888fc0f564bc12d4772f03da624347040821a1d93f3abf6262db632c5ec7a5112e3d89917ab3e46ca18d8e4396e235c0ec445f287aef1cac6f92c4fc16770e5a63f05a28e3f63b2041ea6487e0425b4445a9781eaf55aed28484b496e3214ac747c8c7e0721c9deef4997c12f2448f91eac6cbd2627a63d32b92cae7488ccef252e077a5aad2179d5921a194228ed3b04a84b698d96264589a1b1c9129f237b5ecb2488a20b925b7ec4f5c8d8c4597c098fc8b8232e0b43637a5ed4f92d698f490a256eb76597a422c9641cff00c2864518c92d289da51d876f234848687a671ae36bdabd88f91163634769421eab4cb1e90969c894b4b4b6af4d8b54220d92f05945145228a1228922865eac4211451456e9ed0af5457f81bf6245d0e45de9c595fdd2f6312285e0b644831ff85921eab69088a28a28a28a392871121444b7456d898ca28ad36893bd22b55a5ec65962f0498b820c7e3df7ae490c4b545692223dd0d7b12d2450ec4db7a63d3115656e79a287d540866526588b1ff8912e191e510487c12f3bbd56969f81eab6d085128ed28a28a144ed3b50e2288a23abfe698d8f688a1b464cf18fc997ab6fc129ca5f3ae961f8defe74fd96597b4c688b2164bc7b2cb2f4b6c7b48a122868a2b91214450140ec1633d33d3649128d1d374ca7cb7c2278713934a5664c3da58de9ca289f5118af264eb1bf04f2393e7d9d3e649509aa393c12ce94e8524d596362d514316a5e08f8440978dbdad2d31b2847c0844572228685123114448ed144503a4e85e46e4fc13fa6c1c692a62fa5c2b94eccdf4a8ff4f43b20d2f968c3d1f491b51e9e592fe6323ea7d3628e19b8c27071ae24bf6471ce51b49b4355e50df0751df6fc92726be4e46fd89d321d4b47de704bab931caddd9832f842aa3e7d8b69a449db22407e0b5b43dad32bd8969216945097245092144488a31e372925fb661c71c704abe079f1a219b1cdbe7846578fb59971da67fcb8dfe37ff875fd46776a52957f4fa5e1ff00e54ebcb327478e7e624fe8d093e2547d4ba286069369d92c6992834c68edda4523b5091da45d18325f9f6adbd44831f8299451cea8a122b4d143d2d2425a425c88488a12e06923e9fcf511ff004c9c9289f53ea9e34ebe4e93acceb276a6f96ac58b3ca71f2e2ccbd32692b3274593e24751f49ea323a728d1d3f4d1c386104ee8ec465518425275c2b3ea5d44b3e772f8be06d96c52452638128f02d58c5e358e54c83b8a7ec5ec64480ca135ba12122868ad3f621458970515a48488ebb99f4c6bee57fa1c55551d6fd37d78b5474bf458639729b218d46349eb241b8928b4cb67733eb9d7b50f4a2f97e4ae392705f0531c51daca6393b2e2526c78e8945511b1a1230bfc7d887b644c63d290a4223e448ed4768c777a656d7813228ed3b448a13172727274d9bd3cd097e99d2f5beb759e92c6fb5c2d4bfbfa64a58e36993c907e09ccc6d363a68963563c68eaf2c30e394dbf08cf9a59b2b9c9f9d4a3c0d512a2523b86f9d2b14dfc9cb31c58e348f930c7f1f62f64bc10663197a4c52a23222f56343d515a484b822b9428aa3b515b4b8d58e48b474bd7e6c12b8b23f578e54bbb897ec9e77e533ef1af28c5993e511ccc725465c89267d6bea1eacfb22f85a5ac90e09792b91791f9d24ecec6c8c2917489484607f8fb117a4488a318c7b4598e5c89e98f74212e05e08ae45e35658b574391435a4e4bc18fa8924931494d2a31b945fe2cc727dbcf9279691f54fa8a845c62d3932527276f686accb0a2ac6a8e0845212565a4c9cd129d9e448e9fc7b10fced90203382bd98fc913e07f235c9456924d8848485e0b1eac52e0bb197aa121f83067e69b3a75d3d26e68cff51e971abef5fe8eabeb9295a84697ec9ce73936dfb531c6cc98e992133bdd9dec73396288a251d3bf6fcfb22631e9621c28a653229905c1da38f0515aa1445a4c4cb2cb6390a6290f20a56262d65925131be6ccb929097736ff00a311c7b1089c1344e34c942c7168a676b178125424a8a307bd6a040914c48942c70685176423c8bc09125c0d50868ad5962627c1677224c4f4a477117441917c166797045f0669f0465c69897b508cf0f9db298dd322d9fe8e4c1ef4591640916768d124248844a1224c9550e8658df058989f3a6d9659dc771dc21112c7233cff002a14a919e4db488ae043f6ad44714d1963db22d17c0ec9088b1231f8f6d6d9131927a44868688f08bd49122f4de9e9115c14499dcf6909091162199ffee4e4e8c927de85e36fdabc08475335dc34bc899c0e0a8ed627446768c5e3d88f9d2191204915a6893ad459689490d92921bd2299db63831c190f0325e4624e84844442a2d0da337fd89499e668f82c7eee444a464c5dcec78e4be0962747e4bc8b21dc99289746169a1ada47cee44570407af5b27f0f5e7fc3d593f28ef6778f20f28e765a2f5685911eb445963fb138bf93e09c86ce0b1348b132d5174771dc751764e639b8cacc79a2fe454c6b8f65142252a458997676a258d1f6f13ed603e997ec7d318f1b8fb22595a9114406b4959da86bf8707723f1634aced28a452238d33d047db44fb687e85d3c7f44b17e3c12c6d0f19e99d8c58c706850653299438b2716d19ed326db15a239e4be48754eb93ee50b3c5a16789ebc497511463cea4c97250d572277af8f75090d091f2569f247c18c6569594ca428a6cec89db13b6276c471476908f24521451dabf43821e35464c6870e4ed1a28a621a2b5c0d1d4f4fdcb8258a4bca1ab1c4ed651cd1ca2e42b6e8c78d638d989b94acb467cd6e933a74fb11465c8a28e9f2f73d37488e6b956e11b3d34281e9a3b0f4cf491d847865a2b56cee2c4cb2f56cb17923e484bf877509d8a4872899249e9d14243a3b76c6b91a291931465f04fa4fd13c135f038497c1dbfc3b68ed3b533163ae59924db48c51ed8233e6f844bf661ffa21f1c99f23948e9a55342334aa2424efff004c734d0c84b939ad5eed96cb1499de368ee2d6ad1626588f917923e48ba2ec73af81e5fe1eadfc136dbd342dd8dad31a1b2b563a7f03c307f03e9e0c7d1c59f66bf64ba2825764da5c23147ba68cd95455225c94ed1897e08ea3252a1be4c6ea488be11d549f820cc0cb22ff00321ca4248a2bf857f0ed7fa1637fa3d162e9f9e4f42239a3b909a3bd1dc770a426c56217914d8a477b2536771658f7639167723b90e690e7c0e687242923bceeb2ce0b47723a9caa301be4c32edb64a4e52242234b1a6679b72f3a8f0cc52b8599a4dc85c0a6d18f2b5e493fcece9a9c7916280b14058e37e0ec8fe8ed5fa291c6db6725b3913762b6280a0c8c4711a122cbf625a636ecb1b6263f3ab2435c1471ecb7a675792e49168f8d488ab32e4ac6909f27c88c596a0d1156c947813626c5ca3a59371441488a6247c6ec4523ed99f6cff62e999f6ed91e9591e958ba567db3fd8ba57fb3edff00a7daff004fb563e9a8f458f0b3d263c4cec68f4d9e9c8f4a47a521e267a4cf4a47a721e363c6ecf499e931636c5859e9316167a32fd1e8b3a9ff008e249dbd31945b24dbf273a426c8be44d5135429109727d3fb649915c89698c7c697828b1884ac8c68427c6d0b4d1e18de9eefdad155aa45145228696d559f54c89ce932b5637ce9a31e2b56c70543c56f82789c48e36d16d10e5124c7112a67439bb32afe8a3c210c7a650bc6ad09f022291e56d0c5ab1b26d7c0e458deef6deac4c7ec5edc8ea0dff0ea25dd91bd5f0594342f063b3e28b49d1952a20bf11fcffb31b2ad1254ce6c849a927fa3a4cbdf8a2ecf9d3d50e8bd7fffd9', 'kermit', NULL);


--
-- TOC entry 3451 (class 0 OID 16425)
-- Dependencies: 228
-- Data for Name: store; Type: TABLE DATA; Schema: sut_se_price_map; Owner: docker
--

INSERT INTO sut_se_price_map.store (id, region, name) VALUES (1, 1, 'Warzywniak ABC');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (2, 2, 'Lidl TG');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (3, 2, 'Carrefour TG');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (4, 1, 'Biedronka Bytom');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (5, 3, 'Biedronka Katowice');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (6, 11, 'Sklep Elektroniczny Kabel');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (7, 8, 'Sklep Elektroniczny XYZ');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (8, 8, 'Warzywniak Pomidor');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (9, 10, 'Żabka Tychy');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (10, 10, 'Biedronka Tychy');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (11, 8, 'Biedronka Sosnowiec');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (12, 11, 'Biedronka Cieszyn');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (13, 11, 'Lidl Cieszyn');
INSERT INTO sut_se_price_map.store (id, region, name) VALUES (14, 11, 'Żabka Cieszyn');


--
-- TOC entry 3453 (class 0 OID 16429)
-- Dependencies: 230
-- Data for Name: user; Type: TABLE DATA; Schema: sut_se_price_map; Owner: docker
--

INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (16, 'Pan X', NULL, '1234', false, 'Pan X');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (19, 'Kermit45000', NULL, '0000', false, 'Kermit45000');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (20, 'Wlad Palownik', NULL, 'Wallachia1431', false, 'Wlad Palownik');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (21, 'Herr_AB', NULL, '123456', false, 'Herr_AB');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (22, 'Stanislaw1', NULL, '111', false, 'Stanislaw1');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (23, 'Adam Nowak', NULL, '4321', false, 'Adam Nowak');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (24, 'Jan Nowy', NULL, '9999', false, 'Jan Nowy');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (25, 'Gandalf Szary', NULL, 'Gandalf Szarybcdef', false, 'a');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (26, 'Gandalf Biały', NULL, 'fedcba', false, 'Gandalf Biały');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (27, 'R2D2', NULL, 'r2d2', false, 'R2D2');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (28, 'Jan22', NULL, '2137', false, 'Jan22');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (31, 'Franzl Lang', 3, 'jodler base arena', false, 'Franzl Lang');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (32, 'Franzl Lang', 3, 'jodler base arena', false, 'Franzl Lang1');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (34, 'franzl', NULL, '$2a$10$XyaQ5y664ZaOlz91MDeZteoXzZMORsjUc3P1UmYuJtttgc6QeNBAG', true, 'franzl_lang');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (33, 'Jodler Base', NULL, '$2a$10$XyaQ5y664ZaOlz91MDeZteoXzZMORsjUc3P1UmYuJtttgc6QeNBAG', false, 'jodler');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (37, 'ben123', NULL, '$2a$10$hVEa77JWki/z3xU/4pOhpOOtm3v.7xN7Qdp5GOHrKEmRjfRlB4a0a', false, 'ben123');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (38, 'ben1234', NULL, '$2a$10$3rfGJb.dVq2YbxU/LXamEO0wVN7gmH3pyOKpVTOpX0sY4JK1/bMY2', false, 'ben1234');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (39, 'ben12345', NULL, '$2a$10$HXCMtThpOAZ2zZMacJ3upu15SjblVwvKPhsdRPKUZh/bQEpbe6jmi', false, 'ben12345');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (40, 'ben9', NULL, '$2a$10$gBl7mVDNM2sXEV8uV51On.WGohFlpK7qksJj3fHwB4krT7ivf9gUy', false, 'ben9');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (41, 'ben', NULL, '$2a$10$u/k4R/pFcB3nsEtXV6ONzuVD0pmc6JsB72HWHbAWQ2ycRZ7g0VAbC', false, 'ben99');
INSERT INTO sut_se_price_map."user" (id, display_name, avatar, password, is_admin, login) VALUES (42, 'ben', NULL, '$2a$10$DARJmbCI5HGQeSb13GfYoeK4j0SWs0giAPCnfoeLKy1G6PBXSvrIe', false, 'ben9123');


--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 219
-- Name: attachement_id_seq; Type: SEQUENCE SET; Schema: sut_se_price_map; Owner: docker
--

SELECT pg_catalog.setval('sut_se_price_map.attachement_id_seq', 1, false);


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 221
-- Name: contrib_id_seq; Type: SEQUENCE SET; Schema: sut_se_price_map; Owner: docker
--

SELECT pg_catalog.setval('sut_se_price_map.contrib_id_seq', 37, true);


--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 223
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: sut_se_price_map; Owner: docker
--

SELECT pg_catalog.setval('sut_se_price_map.product_id_seq', 15, true);


--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 225
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: sut_se_price_map; Owner: docker
--

SELECT pg_catalog.setval('sut_se_price_map.region_id_seq', 19, true);


--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 232
-- Name: report_id_seq; Type: SEQUENCE SET; Schema: sut_se_price_map; Owner: docker
--

SELECT pg_catalog.setval('sut_se_price_map.report_id_seq', 1, false);


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 227
-- Name: resource_id_seq; Type: SEQUENCE SET; Schema: sut_se_price_map; Owner: docker
--

SELECT pg_catalog.setval('sut_se_price_map.resource_id_seq', 3, true);


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 229
-- Name: store_id_seq; Type: SEQUENCE SET; Schema: sut_se_price_map; Owner: docker
--

SELECT pg_catalog.setval('sut_se_price_map.store_id_seq', 15, true);


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 231
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: sut_se_price_map; Owner: docker
--

SELECT pg_catalog.setval('sut_se_price_map.user_id_seq', 42, true);


--
-- TOC entry 3263 (class 2606 OID 16447)
-- Name: attachement attachement_pkey; Type: CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.attachement
    ADD CONSTRAINT attachement_pkey PRIMARY KEY (id);


--
-- TOC entry 3266 (class 2606 OID 16449)
-- Name: contrib contrib_pkey; Type: CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.contrib
    ADD CONSTRAINT contrib_pkey PRIMARY KEY (id);


--
-- TOC entry 3271 (class 2606 OID 16451)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 3274 (class 2606 OID 16453)
-- Name: region region_pkey; Type: CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 16511)
-- Name: report report_pkey; Type: CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.report
    ADD CONSTRAINT report_pkey PRIMARY KEY (id);


--
-- TOC entry 3276 (class 2606 OID 16455)
-- Name: resource resource_pkey; Type: CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (id);


--
-- TOC entry 3279 (class 2606 OID 16457)
-- Name: store store_pkey; Type: CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 16436)
-- Name: user user_login_key; Type: CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map."user"
    ADD CONSTRAINT user_login_key UNIQUE (login);


--
-- TOC entry 3284 (class 2606 OID 16459)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3264 (class 1259 OID 16460)
-- Name: fki_attachement_resource_fk; Type: INDEX; Schema: sut_se_price_map; Owner: docker
--

CREATE INDEX fki_attachement_resource_fk ON sut_se_price_map.attachement USING btree (resource);


--
-- TOC entry 3267 (class 1259 OID 16461)
-- Name: fki_contrib_author_fk; Type: INDEX; Schema: sut_se_price_map; Owner: docker
--

CREATE INDEX fki_contrib_author_fk ON sut_se_price_map.contrib USING btree (author);


--
-- TOC entry 3268 (class 1259 OID 16462)
-- Name: fki_contrib_product_fk; Type: INDEX; Schema: sut_se_price_map; Owner: docker
--

CREATE INDEX fki_contrib_product_fk ON sut_se_price_map.contrib USING btree (product);


--
-- TOC entry 3269 (class 1259 OID 16463)
-- Name: fki_contrib_store_fk; Type: INDEX; Schema: sut_se_price_map; Owner: docker
--

CREATE INDEX fki_contrib_store_fk ON sut_se_price_map.contrib USING btree (store);


--
-- TOC entry 3272 (class 1259 OID 16464)
-- Name: fki_parent_region_fk; Type: INDEX; Schema: sut_se_price_map; Owner: docker
--

CREATE INDEX fki_parent_region_fk ON sut_se_price_map.region USING btree (parent);


--
-- TOC entry 3277 (class 1259 OID 16465)
-- Name: fki_store_region_fk; Type: INDEX; Schema: sut_se_price_map; Owner: docker
--

CREATE INDEX fki_store_region_fk ON sut_se_price_map.store USING btree (region);


--
-- TOC entry 3280 (class 1259 OID 16466)
-- Name: fki_user_avatar_fk; Type: INDEX; Schema: sut_se_price_map; Owner: docker
--

CREATE INDEX fki_user_avatar_fk ON sut_se_price_map."user" USING btree (avatar);


--
-- TOC entry 3287 (class 2606 OID 16467)
-- Name: attachement attachement_resource_fk; Type: FK CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.attachement
    ADD CONSTRAINT attachement_resource_fk FOREIGN KEY (resource) REFERENCES sut_se_price_map.resource(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3288 (class 2606 OID 16472)
-- Name: contrib contrib_author_fk; Type: FK CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.contrib
    ADD CONSTRAINT contrib_author_fk FOREIGN KEY (author) REFERENCES sut_se_price_map."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3289 (class 2606 OID 16477)
-- Name: contrib contrib_product_fk; Type: FK CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.contrib
    ADD CONSTRAINT contrib_product_fk FOREIGN KEY (product) REFERENCES sut_se_price_map.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3290 (class 2606 OID 16482)
-- Name: contrib contrib_store_fk; Type: FK CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.contrib
    ADD CONSTRAINT contrib_store_fk FOREIGN KEY (store) REFERENCES sut_se_price_map.store(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3291 (class 2606 OID 16487)
-- Name: region parent_region_fk; Type: FK CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.region
    ADD CONSTRAINT parent_region_fk FOREIGN KEY (parent) REFERENCES sut_se_price_map.region(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3294 (class 2606 OID 16517)
-- Name: report report_author_fkey; Type: FK CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.report
    ADD CONSTRAINT report_author_fkey FOREIGN KEY (author) REFERENCES sut_se_price_map."user"(id);


--
-- TOC entry 3295 (class 2606 OID 16512)
-- Name: report report_reported_fkey; Type: FK CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.report
    ADD CONSTRAINT report_reported_fkey FOREIGN KEY (reported) REFERENCES sut_se_price_map.contrib(id);


--
-- TOC entry 3292 (class 2606 OID 16492)
-- Name: store store_region_fk; Type: FK CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map.store
    ADD CONSTRAINT store_region_fk FOREIGN KEY (region) REFERENCES sut_se_price_map.region(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3293 (class 2606 OID 16497)
-- Name: user user_avatar_fk; Type: FK CONSTRAINT; Schema: sut_se_price_map; Owner: docker
--

ALTER TABLE ONLY sut_se_price_map."user"
    ADD CONSTRAINT user_avatar_fk FOREIGN KEY (avatar) REFERENCES sut_se_price_map.resource(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2025-01-27 18:22:01 UTC

--
-- PostgreSQL database dump complete
--

