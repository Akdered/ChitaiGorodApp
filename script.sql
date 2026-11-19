--
-- PostgreSQL database dump
--

\restrict xM5heSvIqytKMFKfpEyln98XNoBfiVNPYOakLo6wjld0ILaDf4LWwQqBKCiwCxx

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-19 21:09:19

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
-- TOC entry 5145 (class 1262 OID 17047)
-- Name: UP_Ushkova; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "UP_Ushkova" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "UP_Ushkova" OWNER TO postgres;

\unrestrict xM5heSvIqytKMFKfpEyln98XNoBfiVNPYOakLo6wjld0ILaDf4LWwQqBKCiwCxx
\connect "UP_Ushkova"
\restrict xM5heSvIqytKMFKfpEyln98XNoBfiVNPYOakLo6wjld0ILaDf4LWwQqBKCiwCxx

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 17275)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    "id_Категории" integer NOT NULL,
    "Категория товара" character varying(100) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17274)
-- Name: categories_id_Категории_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."categories_id_Категории_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."categories_id_Категории_seq" OWNER TO postgres;

--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_id_Категории_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."categories_id_Категории_seq" OWNED BY public.categories."id_Категории";


--
-- TOC entry 226 (class 1259 OID 17286)
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manufacturers (
    "id_Производителя" integer NOT NULL,
    "Производитель" character varying(100) NOT NULL
);


ALTER TABLE public.manufacturers OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17285)
-- Name: manufacturers_id_Производителя_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."manufacturers_id_Производителя_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."manufacturers_id_Производителя_seq" OWNER TO postgres;

--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 225
-- Name: manufacturers_id_Производителя_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."manufacturers_id_Производителя_seq" OWNED BY public.manufacturers."id_Производителя";


--
-- TOC entry 238 (class 1259 OID 17387)
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    "id_Заказа" integer NOT NULL,
    "Дата заказа" date NOT NULL,
    "Дата доставки" timestamp without time zone NOT NULL,
    "Адрес пункта выдачи" integer NOT NULL,
    "id_Пользователей" integer NOT NULL,
    "Код для получения" integer NOT NULL,
    "id_СтатусЗаказа" integer NOT NULL
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17386)
-- Name: order_id_Заказа_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."order_id_Заказа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."order_id_Заказа_seq" OWNER TO postgres;

--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_id_Заказа_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."order_id_Заказа_seq" OWNED BY public."order"."id_Заказа";


--
-- TOC entry 240 (class 1259 OID 17416)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    "id_СоставаЗаказа" integer NOT NULL,
    "id_Заказа" integer NOT NULL,
    "id_Товара" integer NOT NULL,
    "Количество" integer NOT NULL,
    CONSTRAINT "order_items_Количество_check" CHECK (("Количество" > 0))
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17415)
-- Name: order_items_id_СоставаЗаказа_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."order_items_id_СоставаЗаказа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."order_items_id_СоставаЗаказа_seq" OWNER TO postgres;

--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 239
-- Name: order_items_id_СоставаЗаказа_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."order_items_id_СоставаЗаказа_seq" OWNED BY public.order_items."id_СоставаЗаказа";


--
-- TOC entry 234 (class 1259 OID 17330)
-- Name: order_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_statuses (
    "id_Заказа" integer NOT NULL,
    "Статус заказа" character varying(50) NOT NULL
);


ALTER TABLE public.order_statuses OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17329)
-- Name: order_statuses_id_Заказа_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."order_statuses_id_Заказа_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."order_statuses_id_Заказа_seq" OWNER TO postgres;

--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 233
-- Name: order_statuses_id_Заказа_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."order_statuses_id_Заказа_seq" OWNED BY public.order_statuses."id_Заказа";


--
-- TOC entry 232 (class 1259 OID 17319)
-- Name: pickup_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_points (
    "id_Адрес" integer NOT NULL,
    "Адрес" text NOT NULL
);


ALTER TABLE public.pickup_points OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17318)
-- Name: pickup_points_id_Адрес_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."pickup_points_id_Адрес_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."pickup_points_id_Адрес_seq" OWNER TO postgres;

--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 231
-- Name: pickup_points_id_Адрес_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."pickup_points_id_Адрес_seq" OWNED BY public.pickup_points."id_Адрес";


--
-- TOC entry 236 (class 1259 OID 17341)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    "id_Товара" integer NOT NULL,
    "Артикул" character varying(50) NOT NULL,
    "Наименование товара" character varying(250) NOT NULL,
    "id_ЕдИзм" integer NOT NULL,
    "Цена" numeric(10,2) NOT NULL,
    "id_Поставщика" integer NOT NULL,
    "id_Производителя" integer NOT NULL,
    "id_Категории" integer NOT NULL,
    "Действующая скидка" integer DEFAULT 0 NOT NULL,
    "Кол-во на складе" integer DEFAULT 0 NOT NULL,
    "Описание товара" text,
    "Фото" character varying(255),
    CONSTRAINT "products_Действующая скидка_check" CHECK ((("Действующая скидка" >= 0) AND ("Действующая скидка" <= 100))),
    CONSTRAINT "products_Кол-во на складе_check" CHECK (("Кол-во на складе" >= 0)),
    CONSTRAINT "products_Цена_check" CHECK (("Цена" >= (0)::numeric))
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17340)
-- Name: products_id_Товара_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."products_id_Товара_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."products_id_Товара_seq" OWNER TO postgres;

--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 235
-- Name: products_id_Товара_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."products_id_Товара_seq" OWNED BY public.products."id_Товара";


--
-- TOC entry 220 (class 1259 OID 17245)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    "id_Роли" integer NOT NULL,
    "Роль сотрудника" character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17244)
-- Name: roles_id_Роли_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."roles_id_Роли_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."roles_id_Роли_seq" OWNER TO postgres;

--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_Роли_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."roles_id_Роли_seq" OWNED BY public.roles."id_Роли";


--
-- TOC entry 228 (class 1259 OID 17297)
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    "id_Поставщика" integer NOT NULL,
    "Поставщик" character varying(150) NOT NULL
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17296)
-- Name: suppliers_id_Поставщика_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."suppliers_id_Поставщика_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."suppliers_id_Поставщика_seq" OWNER TO postgres;

--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 227
-- Name: suppliers_id_Поставщика_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."suppliers_id_Поставщика_seq" OWNED BY public.suppliers."id_Поставщика";


--
-- TOC entry 230 (class 1259 OID 17308)
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    "id_ЕдИзм" integer NOT NULL,
    "Единица измерения" character varying(20) NOT NULL
);


ALTER TABLE public.units OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17307)
-- Name: units_id_ЕдИзм_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."units_id_ЕдИзм_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."units_id_ЕдИзм_seq" OWNER TO postgres;

--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 229
-- Name: units_id_ЕдИзм_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."units_id_ЕдИзм_seq" OWNED BY public.units."id_ЕдИзм";


--
-- TOC entry 222 (class 1259 OID 17256)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    "id_Пользователей" integer NOT NULL,
    "id_Роли" integer NOT NULL,
    "ФИО" character varying(150) NOT NULL,
    "Логин" character varying(100) NOT NULL,
    "Пароль" character varying(100) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17255)
-- Name: users_id_Пользователей_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."users_id_Пользователей_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."users_id_Пользователей_seq" OWNER TO postgres;

--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_Пользователей_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."users_id_Пользователей_seq" OWNED BY public.users."id_Пользователей";


--
-- TOC entry 4908 (class 2604 OID 17278)
-- Name: categories id_Категории; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN "id_Категории" SET DEFAULT nextval('public."categories_id_Категории_seq"'::regclass);


--
-- TOC entry 4909 (class 2604 OID 17289)
-- Name: manufacturers id_Производителя; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers ALTER COLUMN "id_Производителя" SET DEFAULT nextval('public."manufacturers_id_Производителя_seq"'::regclass);


--
-- TOC entry 4917 (class 2604 OID 17390)
-- Name: order id_Заказа; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order" ALTER COLUMN "id_Заказа" SET DEFAULT nextval('public."order_id_Заказа_seq"'::regclass);


--
-- TOC entry 4918 (class 2604 OID 17419)
-- Name: order_items id_СоставаЗаказа; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN "id_СоставаЗаказа" SET DEFAULT nextval('public."order_items_id_СоставаЗаказа_seq"'::regclass);


--
-- TOC entry 4913 (class 2604 OID 17333)
-- Name: order_statuses id_Заказа; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses ALTER COLUMN "id_Заказа" SET DEFAULT nextval('public."order_statuses_id_Заказа_seq"'::regclass);


--
-- TOC entry 4912 (class 2604 OID 17322)
-- Name: pickup_points id_Адрес; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points ALTER COLUMN "id_Адрес" SET DEFAULT nextval('public."pickup_points_id_Адрес_seq"'::regclass);


--
-- TOC entry 4914 (class 2604 OID 17344)
-- Name: products id_Товара; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN "id_Товара" SET DEFAULT nextval('public."products_id_Товара_seq"'::regclass);


--
-- TOC entry 4906 (class 2604 OID 17248)
-- Name: roles id_Роли; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN "id_Роли" SET DEFAULT nextval('public."roles_id_Роли_seq"'::regclass);


--
-- TOC entry 4910 (class 2604 OID 17300)
-- Name: suppliers id_Поставщика; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN "id_Поставщика" SET DEFAULT nextval('public."suppliers_id_Поставщика_seq"'::regclass);


--
-- TOC entry 4911 (class 2604 OID 17311)
-- Name: units id_ЕдИзм; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units ALTER COLUMN "id_ЕдИзм" SET DEFAULT nextval('public."units_id_ЕдИзм_seq"'::regclass);


--
-- TOC entry 4907 (class 2604 OID 17259)
-- Name: users id_Пользователей; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN "id_Пользователей" SET DEFAULT nextval('public."users_id_Пользователей_seq"'::regclass);


--
-- TOC entry 5123 (class 0 OID 17275)
-- Dependencies: 224
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories ("id_Категории", "Категория товара") VALUES (1, 'Художественная литература');
INSERT INTO public.categories ("id_Категории", "Категория товара") VALUES (2, 'Учебник для вузов');
INSERT INTO public.categories ("id_Категории", "Категория товара") VALUES (3, 'Хрестоматия');
INSERT INTO public.categories ("id_Категории", "Категория товара") VALUES (4, 'Учебное пособие');


--
-- TOC entry 5125 (class 0 OID 17286)
-- Dependencies: 226
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.manufacturers ("id_Производителя", "Производитель") VALUES (1, 'Яуза');
INSERT INTO public.manufacturers ("id_Производителя", "Производитель") VALUES (2, 'Т8 Издательские технологии');
INSERT INTO public.manufacturers ("id_Производителя", "Производитель") VALUES (3, 'Прогресс книга');
INSERT INTO public.manufacturers ("id_Производителя", "Производитель") VALUES (4, 'Время');
INSERT INTO public.manufacturers ("id_Производителя", "Производитель") VALUES (5, 'Лениздат');
INSERT INTO public.manufacturers ("id_Производителя", "Производитель") VALUES (6, 'Неолит');
INSERT INTO public.manufacturers ("id_Производителя", "Производитель") VALUES (7, 'Амрита-Русь');
INSERT INTO public.manufacturers ("id_Производителя", "Производитель") VALUES (8, 'Златоуст');
INSERT INTO public.manufacturers ("id_Производителя", "Производитель") VALUES (9, 'Аспект Пресс');
INSERT INTO public.manufacturers ("id_Производителя", "Производитель") VALUES (10, 'ВКН');


--
-- TOC entry 5137 (class 0 OID 17387)
-- Dependencies: 238
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."order" ("id_Заказа", "Дата заказа", "Дата доставки", "Адрес пункта выдачи", "id_Пользователей", "Код для получения", "id_СтатусЗаказа") VALUES (1, '2024-02-27', '2024-04-20 00:00:00', 1, 10, 901, 1);
INSERT INTO public."order" ("id_Заказа", "Дата заказа", "Дата доставки", "Адрес пункта выдачи", "id_Пользователей", "Код для получения", "id_СтатусЗаказа") VALUES (5, '2024-03-17', '2024-04-24 00:00:00', 2, 10, 905, 1);
INSERT INTO public."order" ("id_Заказа", "Дата заказа", "Дата доставки", "Адрес пункта выдачи", "id_Пользователей", "Код для получения", "id_СтатусЗаказа") VALUES (9, '2024-04-02', '2024-04-28 00:00:00', 5, 10, 909, 2);
INSERT INTO public."order" ("id_Заказа", "Дата заказа", "Дата доставки", "Адрес пункта выдачи", "id_Пользователей", "Код для получения", "id_СтатусЗаказа") VALUES (10, '2024-04-03', '2024-04-29 00:00:00', 19, 10, 910, 2);
INSERT INTO public."order" ("id_Заказа", "Дата заказа", "Дата доставки", "Адрес пункта выдачи", "id_Пользователей", "Код для получения", "id_СтатусЗаказа") VALUES (2, '2023-09-28', '2024-04-21 00:00:00', 11, 7, 902, 1);
INSERT INTO public."order" ("id_Заказа", "Дата заказа", "Дата доставки", "Адрес пункта выдачи", "id_Пользователей", "Код для получения", "id_СтатусЗаказа") VALUES (6, '2024-03-01', '2024-04-25 00:00:00', 15, 7, 906, 1);
INSERT INTO public."order" ("id_Заказа", "Дата заказа", "Дата доставки", "Адрес пункта выдачи", "id_Пользователей", "Код для получения", "id_СтатусЗаказа") VALUES (3, '2024-03-21', '2024-04-22 00:00:00', 2, 8, 903, 1);
INSERT INTO public."order" ("id_Заказа", "Дата заказа", "Дата доставки", "Адрес пункта выдачи", "id_Пользователей", "Код для получения", "id_СтатусЗаказа") VALUES (7, '2024-02-29', '2024-04-26 00:00:00', 3, 8, 907, 1);
INSERT INTO public."order" ("id_Заказа", "Дата заказа", "Дата доставки", "Адрес пункта выдачи", "id_Пользователей", "Код для получения", "id_СтатусЗаказа") VALUES (4, '2024-02-20', '2024-04-23 00:00:00', 11, 9, 904, 1);
INSERT INTO public."order" ("id_Заказа", "Дата заказа", "Дата доставки", "Адрес пункта выдачи", "id_Пользователей", "Код для получения", "id_СтатусЗаказа") VALUES (8, '2024-03-31', '2024-04-27 00:00:00', 19, 9, 908, 2);


--
-- TOC entry 5139 (class 0 OID 17416)
-- Dependencies: 240
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (1, 1, 1, 2);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (10, 2, 1, 1);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (11, 6, 1, 2);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (2, 1, 2, 2);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (9, 2, 2, 1);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (12, 6, 2, 2);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (3, 5, 6, 20);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (20, 8, 6, 1);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (13, 3, 3, 10);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (18, 4, 3, 4);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (4, 5, 7, 20);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (14, 3, 4, 10);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (5, 9, 10, 5);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (8, 10, 10, 5);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (17, 4, 5, 5);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (19, 8, 5, 1);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (6, 9, 9, 1);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (7, 10, 9, 5);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (16, 7, 9, 3);
INSERT INTO public.order_items ("id_СоставаЗаказа", "id_Заказа", "id_Товара", "Количество") VALUES (15, 7, 8, 3);


--
-- TOC entry 5133 (class 0 OID 17330)
-- Dependencies: 234
-- Data for Name: order_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_statuses ("id_Заказа", "Статус заказа") VALUES (1, 'Завершен');
INSERT INTO public.order_statuses ("id_Заказа", "Статус заказа") VALUES (2, 'Новый ');


--
-- TOC entry 5131 (class 0 OID 17319)
-- Dependencies: 232
-- Data for Name: pickup_points; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (1, '420151, г. Лесной, ул. Вишневая, 32');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (2, '125061, г. Лесной, ул. Подгорная, 8');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (3, '630370, г. Лесной, ул. Шоссейная, 24');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (4, '400562, г. Лесной, ул. Зеленая, 32');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (5, '614510, г. Лесной, ул. Маяковского, 47');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (6, '410542, г. Лесной, ул. Светлая, 46');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (7, '620839, г. Лесной, ул. Цветочная, 8');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (8, '443890, г. Лесной, ул. Коммунистическая, 1');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (9, '603379, г. Лесной, ул. Спортивная, 46');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (10, '603721, г. Лесной, ул. Гоголя, 41');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (11, '410172, г. Лесной, ул. Северная, 13');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (12, '614611, г. Лесной, ул. Молодежная, 50');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (13, '454311, г.Лесной, ул. Новая, 19');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (14, '660007, г.Лесной, ул. Октябрьская, 19');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (15, '603036, г. Лесной, ул. Садовая, 4');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (16, '394060, г.Лесной, ул. Фрунзе, 43');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (17, '410661, г. Лесной, ул. Школьная, 50');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (18, '625590, г. Лесной, ул. Коммунистическая, 20');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (19, '625683, г. Лесной, ул. 8 Марта');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (20, '450983, г.Лесной, ул. Комсомольская, 26');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (21, '394782, г. Лесной, ул. Чехова, 3');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (22, '603002, г. Лесной, ул. Дзержинского, 28');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (23, '450558, г. Лесной, ул. Набережная, 30');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (24, '344288, г. Лесной, ул. Чехова, 1');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (25, '614164, г.Лесной,  ул. Степная, 30');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (26, '394242, г. Лесной, ул. Коммунистическая, 43');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (27, '660540, г. Лесной, ул. Солнечная, 25');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (28, '125837, г. Лесной, ул. Шоссейная, 40');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (29, '125703, г. Лесной, ул. Партизанская, 49');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (30, '625283, г. Лесной, ул. Победы, 46');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (31, '614753, г. Лесной, ул. Полевая, 35');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (32, '426030, г. Лесной, ул. Маяковского, 44');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (33, '450375, г. Лесной ул. Клубная, 44');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (34, '625560, г. Лесной, ул. Некрасова, 12');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (35, '630201, г. Лесной, ул. Комсомольская, 17');
INSERT INTO public.pickup_points ("id_Адрес", "Адрес") VALUES (36, '190949, г. Лесной, ул. Мичурина, 26');


--
-- TOC entry 5135 (class 0 OID 17341)
-- Dependencies: 236
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (1, 'А112Т4', 'Прокляты и убиты', 1, 585.00, 1, 1, 1, 25, 6, 'Роман-эпопею "Прокляты и убиты" Виктора Астафьева по праву считают одним из самых сильных и пронзительных произведений отечественной военной прозы.', '1.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (2, 'G843H5', 'Тайны и загадки отца БраунаТайны и загадки отца Брауна', 1, 193.00, 2, 1, 1, 30, 9, 'Гилберт Кит Честертон — признанный классик английской литературы, один из самых ярких писателей первой половины XX века. Классикой стали его романы и многочисленные эссе, однако любовь массового читателя принесли ему рассказы об отце Брауне, тихом, застенчивом священнике, мастерски раскрывающем наиболее запутанные загадки и преступления. ', '2.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (3, 'D325D4', 'Девайс', 1, 1599.00, 3, 2, 1, 5, 12, 'Молодой фрилансер Захар Скаро устраивается на очередную подработку. Задача, казалось бы, тривиальная: тестирование нового устройства. Вот только вопрос в том, тестированием какой реальности занимается этот новый Девайс?', '3.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (4, 'S432T5', 'Необыкновенное обыкновенное чудо. Школьные истории', 1, 549.00, 4, 2, 1, 15, 15, NULL, '4.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (5, 'F325D4', 'Чук и Гек', 1, 209.00, 5, 2, 1, 18, 3, 'В книгу вошли повести и рассказы Аркадия Петровича Гайдара: "Чук и Гек", "Горячий камень" и "Сказка о военной тайне, о Мальчише-Кибальчише и его твердом слове"', '5.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (6, 'G432G6', 'Информационная безопасность. Национальные стандарты Российской Федерации. 3-е издание. Учебное пособие', 1, 3899.00, 6, 3, 2, 22, 3, 'В учебном пособии рассмотрено более 300 действующих открытых документов национальной системы стандартизации Российской Федерации, включая международные и межгосударственные стандарты в области информационной безопасности по состоянию на начало 2023 года.', '6.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (7, 'H542F5', 'Linux. Командная строка. Лучшие практики', 1, 1799.00, 7, 3, 2, 4, 5, 'Перейдите на новый уровень работы в Linux! Если вы системный администратор, разработчик программного обеспечения, SRE-инженер или пользователь Linux, книга поможет вам работать быстрее, элегантнее и эффективнее. ', '7.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (8, 'C346F5', 'Квантовые миры и возникновение пространства-времени', 1, 1349.00, 8, 3, 2, 5, 4, 'Шон Кэрролл — физик-теоретик и один из самых известных в мире популяризаторов науки — заставляет нас по-новому взглянуть на физику. Столкновение с главной загадкой квантовой механики полностью поменяет наши представления о пространстве и времени.', '8.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (9, 'F256G6', 'Вселенная. Происхождение жизни, смысл нашего существования и огромный космос', 1, 1799.00, 8, 3, 2, 6, 2, 'Знаменитый физик Шон Кэрролл в свойственной ему увлекательной манере объясняет принципы, которые лежат в основах научных революций от Дарвина до Эйнштейна, и показывает как невероятные научные открытия последнего столетия изменили наш мир.', NULL);
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (10, 'J532V5', 'Пушкин. Бродский. Империя и судьба. В 2-х томах (комплект из 2-х книг)', 1, 529.00, 9, 4, 3, 8, 6, 'Первая книга двухтомника «Пушкин. Бродский. Империя и судьба» пронизана пушкинской темой. Пушкин — «певец империи и свободы» — присутствует даже там, где он впрямую не упоминается, ибо его судьба, как и судьба других героев книги, органично связана с трагедией великой империи.', '10.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (11, 'G643F4', 'Иосиф Бродский. Избранные эссе (комплект из 6-ти книг)', 1, 4925.00, 10, 5, 3, 2, 24, 'Шесть сборников избранных эссе Иосифа Бродского (1940-1996), великого поэта, драматурга, мыслителя, лауреата Нобелевской премии по литературе (1987): «Будущее или далекое прошлое», «Верь своей боли», «Как читать книгу», «О русской литературе», «О тирании», «Путеводитель по переименованному городу». Все тексты представлены на английском языке и в переводе на русский и открывают автора не только как поэта, но как историка, критика, и глубокого и ироничного мыслителя.', '11.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (12, 'J326V5', 'Тысячелетие императорской керамикиv', 1, 2599.00, 11, 5, 3, 5, 4, 'Фарфор стал величайшим символом китайской культуры. Это одно из выдающихся изобретений, внесших неоценимый вклад в мировую цивилизацию. ', '12.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (13, 'J632F6', 'Вечные спутники: Портреты из всемирной литературы', 1, 1599.00, 12, 5, 3, 0, 6, 'Книга "Вечные спутники" - это цикл критических очерков о культуре и великих литераторах, сопровождавших жизнь и творчество русского писателя, поэта, литературного критика и общественного деятеля Дмитрия Мережковского (1865–1941). ', '13.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (14, 'G632H6', 'Формирование литературной репутации Н.Г.Чернышевского в ХIX-XXI веках', 1, 1349.00, 13, 6, 3, 2, 8, 'Монография Д. А. Щербакова - новаторская. Поэтапно рассмотрены не только многочисленные суждения известных отечественных и зарубежных критиков, литературоведов, философов и политиков, различным образом характеризовавших Н. Г. Чернышевского в связи и вне связи со знаменитым романом "Что делать? ', '14.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (15, 'G543F5', 'Религиозные верования с древнейших времен до наших дней', 1, 879.00, 13, 7, 3, 4, 6, 'Настоящее издание представляет собой сборник переводов лекций по истории дохристианских и нехристианских религий, прочитанных в Лондоне в период с 1888 по 1891 гг. авторитетными исследователями данного раздела религиоведения. ', '16.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (16, 'M642E5', 'Теория искусства. Краткий путеводитель', 1, 879.00, 14, 6, 3, 3, 2, NULL, '15.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (17, 'B653G6', 'Русский язык: Первые шаги. Часть 3. Учебное пособие', 1, 2699.00, 15, 8, 4, 8, 9, 'Пособие является завершающей частью учебного комплекса. Третья часть содержит 10 уроков (21-30, последний-повторительный). Усвоение лексико-грамматического материала рассчитано примерно на 200-240 часов аудиторных занятий. ', '17.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (18, 'J735J7', 'Синтетический образ индивидуального психического мира', 1, 1099.00, 16, 8, 3, 9, 4, 'Психика подобна определенным объектам, это фиксируют сами люди в языке и искусстве. В данном исследовании рассматриваются в этом плане образы сосуда, воронки, дерева и крепости.', '18.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (19, 'H436H7', 'Английский язык в спорте: Учебное пособие', 1, 1999.00, 17, 9, 4, 2, 0, 'Учебное пособие подготовлено для слушателей, изу чающих английский язык как язык специальности', '19.jpg');
INSERT INTO public.products ("id_Товара", "Артикул", "Наименование товара", "id_ЕдИзм", "Цена", "id_Поставщика", "id_Производителя", "id_Категории", "Действующая скидка", "Кол-во на складе", "Описание товара", "Фото") VALUES (20, 'H475R5', 'Лексика и грамматика современного китайского языка (к тому II учебника «Новый практический курс китайского языка» под редакцией Лю Сюня): учебное пособие', 1, 605.00, 18, 10, 4, 25, 12, 'Пособие выступает дополнением ко второму тому учебника «Новый практический курс китайского языка» (под редакцией Лю Сюня).', '20.jpg');


--
-- TOC entry 5119 (class 0 OID 17245)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles ("id_Роли", "Роль сотрудника") VALUES (1, 'Администратор');
INSERT INTO public.roles ("id_Роли", "Роль сотрудника") VALUES (2, 'Менеджер');
INSERT INTO public.roles ("id_Роли", "Роль сотрудника") VALUES (3, 'Авторизированный клиент');


--
-- TOC entry 5127 (class 0 OID 17297)
-- Dependencies: 228
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (1, 'Виктор Астафьев');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (2, 'Гилберт Кит Честертон');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (3, 'Кирилл Каланджи');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (4, 'Людмила Улицкая');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (5, 'Аркадий Гайдар');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (6, 'Юрий Родичев');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (7, 'Дэниел Джей Барретт');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (8, 'Шон Кэрролл');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (9, 'Яков Гордин');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (10, 'Иосиф Бродский');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (11, 'Янь Чуннянь Янь Чуннянь');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (12, 'Дмитрий Мережковский');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (13, 'Дмитрий Щербаков');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (14, 'Роджер Осборн, Дэн Стерджис');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (15, 'Любовь Беликова, Инна Ерофеева, Татьяна Шутова');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (16, 'Сергей Моргачев');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (17, 'Екатерина Габарта, Ирина Игнатьева');
INSERT INTO public.suppliers ("id_Поставщика", "Поставщик") VALUES (18, 'Татьяна Лопаткина, Софья Маннапова');


--
-- TOC entry 5129 (class 0 OID 17308)
-- Dependencies: 230
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.units ("id_ЕдИзм", "Единица измерения") VALUES (1, 'шт.');


--
-- TOC entry 5121 (class 0 OID 17256)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users ("id_Пользователей", "id_Роли", "ФИО", "Логин", "Пароль") VALUES (1, 1, 'Никифорова Анна Семеновна', '94d5ous@gmail.com', 'uzWC67');
INSERT INTO public.users ("id_Пользователей", "id_Роли", "ФИО", "Логин", "Пароль") VALUES (2, 1, 'Стелина Евгения Петровна', 'uth4iz@mail.com', '2L6KZG');
INSERT INTO public.users ("id_Пользователей", "id_Роли", "ФИО", "Логин", "Пароль") VALUES (3, 1, 'Михайлюк Анна Вячеславовна', '5d4zbu@tutanota.com', 'rwVDh9');
INSERT INTO public.users ("id_Пользователей", "id_Роли", "ФИО", "Логин", "Пароль") VALUES (4, 2, 'Ситдикова Елена Анатольевна', 'ptec8ym@yahoo.com', 'LdNyos');
INSERT INTO public.users ("id_Пользователей", "id_Роли", "ФИО", "Логин", "Пароль") VALUES (5, 2, 'Ворсин Петр Евгеньевич', '1qz4kw@mail.com', 'gynQMT');
INSERT INTO public.users ("id_Пользователей", "id_Роли", "ФИО", "Логин", "Пароль") VALUES (6, 2, 'Старикова Елена Павловна', '4np6se@mail.com', 'AtnDjr');
INSERT INTO public.users ("id_Пользователей", "id_Роли", "ФИО", "Логин", "Пароль") VALUES (7, 3, 'Никифорова Весения Николаевна', 'yzls62@outlook.com', 'JlFRCZ');
INSERT INTO public.users ("id_Пользователей", "id_Роли", "ФИО", "Логин", "Пароль") VALUES (8, 3, 'Сазонов Руслан Германович', '1diph5e@tutanota.com', '8ntwUp');
INSERT INTO public.users ("id_Пользователей", "id_Роли", "ФИО", "Логин", "Пароль") VALUES (9, 3, 'Одинцов Серафим Артёмович', 'tjde7c@yahoo.com', 'YOyhfR');
INSERT INTO public.users ("id_Пользователей", "id_Роли", "ФИО", "Логин", "Пароль") VALUES (10, 3, 'Степанов Михаил Артёмович', 'wpmrc3do@tutanota.com', 'RSbvHv');


--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 223
-- Name: categories_id_Категории_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."categories_id_Категории_seq"', 4, true);


--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 225
-- Name: manufacturers_id_Производителя_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."manufacturers_id_Производителя_seq"', 10, true);


--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_id_Заказа_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."order_id_Заказа_seq"', 10, true);


--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 239
-- Name: order_items_id_СоставаЗаказа_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."order_items_id_СоставаЗаказа_seq"', 20, true);


--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 233
-- Name: order_statuses_id_Заказа_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."order_statuses_id_Заказа_seq"', 2, true);


--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 231
-- Name: pickup_points_id_Адрес_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."pickup_points_id_Адрес_seq"', 36, true);


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 235
-- Name: products_id_Товара_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."products_id_Товара_seq"', 20, true);


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_Роли_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."roles_id_Роли_seq"', 3, true);


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 227
-- Name: suppliers_id_Поставщика_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."suppliers_id_Поставщика_seq"', 18, true);


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 229
-- Name: units_id_ЕдИзм_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."units_id_ЕдИзм_seq"', 1, true);


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_Пользователей_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."users_id_Пользователей_seq"', 10, true);


--
-- TOC entry 4932 (class 2606 OID 17282)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY ("id_Категории");


--
-- TOC entry 4934 (class 2606 OID 17284)
-- Name: categories categories_Категория товара_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT "categories_Категория товара_key" UNIQUE ("Категория товара");


--
-- TOC entry 4936 (class 2606 OID 17293)
-- Name: manufacturers manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY ("id_Производителя");


--
-- TOC entry 4938 (class 2606 OID 17295)
-- Name: manufacturers manufacturers_Производитель_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT "manufacturers_Производитель_key" UNIQUE ("Производитель");


--
-- TOC entry 4960 (class 2606 OID 17426)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY ("id_СоставаЗаказа");


--
-- TOC entry 4958 (class 2606 OID 17399)
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY ("id_Заказа");


--
-- TOC entry 4950 (class 2606 OID 17337)
-- Name: order_statuses order_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT order_statuses_pkey PRIMARY KEY ("id_Заказа");


--
-- TOC entry 4952 (class 2606 OID 17339)
-- Name: order_statuses order_statuses_Статус заказа_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_statuses
    ADD CONSTRAINT "order_statuses_Статус заказа_key" UNIQUE ("Статус заказа");


--
-- TOC entry 4948 (class 2606 OID 17328)
-- Name: pickup_points pickup_points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_points
    ADD CONSTRAINT pickup_points_pkey PRIMARY KEY ("id_Адрес");


--
-- TOC entry 4954 (class 2606 OID 17363)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY ("id_Товара");


--
-- TOC entry 4956 (class 2606 OID 17365)
-- Name: products products_Артикул_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_Артикул_key" UNIQUE ("Артикул");


--
-- TOC entry 4924 (class 2606 OID 17252)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY ("id_Роли");


--
-- TOC entry 4926 (class 2606 OID 17254)
-- Name: roles roles_Роль сотрудника_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT "roles_Роль сотрудника_key" UNIQUE ("Роль сотрудника");


--
-- TOC entry 4940 (class 2606 OID 17304)
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY ("id_Поставщика");


--
-- TOC entry 4942 (class 2606 OID 17306)
-- Name: suppliers suppliers_Поставщик_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT "suppliers_Поставщик_key" UNIQUE ("Поставщик");


--
-- TOC entry 4944 (class 2606 OID 17315)
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY ("id_ЕдИзм");


--
-- TOC entry 4946 (class 2606 OID 17317)
-- Name: units units_Единица измерения_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT "units_Единица измерения_key" UNIQUE ("Единица измерения");


--
-- TOC entry 4928 (class 2606 OID 17266)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY ("id_Пользователей");


--
-- TOC entry 4930 (class 2606 OID 17268)
-- Name: users users_Логин_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_Логин_key" UNIQUE ("Логин");


--
-- TOC entry 4966 (class 2606 OID 17405)
-- Name: order order_id_Пользователей_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "order_id_Пользователей_fkey" FOREIGN KEY ("id_Пользователей") REFERENCES public.users("id_Пользователей") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4967 (class 2606 OID 17410)
-- Name: order order_id_СтатусЗаказа_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "order_id_СтатусЗаказа_fkey" FOREIGN KEY ("id_СтатусЗаказа") REFERENCES public.order_statuses("id_Заказа") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4969 (class 2606 OID 17427)
-- Name: order_items order_items_id_Заказа_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT "order_items_id_Заказа_fkey" FOREIGN KEY ("id_Заказа") REFERENCES public."order"("id_Заказа") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4970 (class 2606 OID 17432)
-- Name: order_items order_items_id_Товара_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT "order_items_id_Товара_fkey" FOREIGN KEY ("id_Товара") REFERENCES public.products("id_Товара") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4968 (class 2606 OID 17400)
-- Name: order order_Адрес пункта выдачи_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "order_Адрес пункта выдачи_fkey" FOREIGN KEY ("Адрес пункта выдачи") REFERENCES public.pickup_points("id_Адрес") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4962 (class 2606 OID 17366)
-- Name: products products_id_ЕдИзм_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_id_ЕдИзм_fkey" FOREIGN KEY ("id_ЕдИзм") REFERENCES public.units("id_ЕдИзм") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4963 (class 2606 OID 17381)
-- Name: products products_id_Категории_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_id_Категории_fkey" FOREIGN KEY ("id_Категории") REFERENCES public.categories("id_Категории") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4964 (class 2606 OID 17371)
-- Name: products products_id_Поставщика_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_id_Поставщика_fkey" FOREIGN KEY ("id_Поставщика") REFERENCES public.suppliers("id_Поставщика") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4965 (class 2606 OID 17376)
-- Name: products products_id_Производителя_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_id_Производителя_fkey" FOREIGN KEY ("id_Производителя") REFERENCES public.manufacturers("id_Производителя") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4961 (class 2606 OID 17269)
-- Name: users users_id_Роли_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_id_Роли_fkey" FOREIGN KEY ("id_Роли") REFERENCES public.roles("id_Роли") ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-11-19 21:09:20

--
-- PostgreSQL database dump complete
--

\unrestrict xM5heSvIqytKMFKfpEyln98XNoBfiVNPYOakLo6wjld0ILaDf4LWwQqBKCiwCxx

