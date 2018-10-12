SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addresses (
    id bigint NOT NULL,
    user_id bigint,
    name character varying,
    address character varying,
    zipp_code integer,
    city character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: admin_advertisement_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_advertisement_modules (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_advertisement_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_advertisement_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_advertisement_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_advertisement_modules_id_seq OWNED BY public.admin_advertisement_modules.id;


--
-- Name: admin_advertisements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_advertisements (
    id bigint NOT NULL,
    title character varying,
    body text,
    price_pr_view numeric DEFAULT 0.0,
    views integer DEFAULT 0,
    price_pr_click numeric DEFAULT 0.0,
    clicks integer DEFAULT 0,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    active boolean DEFAULT true,
    featured boolean DEFAULT false,
    featured_price numeric DEFAULT 0.0,
    price numeric DEFAULT 0.0,
    url character varying DEFAULT ''::character varying,
    locale character varying,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    notes text DEFAULT ''::text,
    user_id integer
);


--
-- Name: admin_advertisements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_advertisements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_advertisements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_advertisements_id_seq OWNED BY public.admin_advertisements.id;


--
-- Name: admin_blog_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_blog_modules (
    id bigint NOT NULL,
    name character varying,
    body text,
    layout character varying,
    blog_posts_count integer DEFAULT 0,
    posts_pr_page integer DEFAULT 10,
    admin_blog_id integer,
    locale character varying,
    show_all_categories boolean DEFAULT false,
    featured_posts_pr_page integer DEFAULT 0,
    show_search boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_blog_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_blog_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_blog_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_blog_modules_id_seq OWNED BY public.admin_blog_modules.id;


--
-- Name: admin_blog_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_blog_posts (
    id bigint NOT NULL,
    legacy_id integer,
    title character varying,
    layout character varying DEFAULT 'image_top'::character varying,
    subtitle text,
    teaser text,
    body text,
    "position" integer,
    blog_id integer,
    free_content boolean DEFAULT false,
    featured boolean DEFAULT false,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    user_id bigint,
    views integer DEFAULT 0,
    signature character varying DEFAULT ''::character varying,
    post_page_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone,
    video_url text DEFAULT ''::text,
    enable_comments boolean DEFAULT false
);


--
-- Name: admin_blog_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_blog_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_blog_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_blog_posts_id_seq OWNED BY public.admin_blog_posts.id;


--
-- Name: admin_blogs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_blogs (
    id bigint NOT NULL,
    title character varying,
    locale character varying,
    legacy_category_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    blog_posts_count integer DEFAULT 0
);


--
-- Name: admin_blogs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_blogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_blogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_blogs_id_seq OWNED BY public.admin_blogs.id;


--
-- Name: admin_calendar_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_calendar_events (
    id bigint NOT NULL,
    calendar_id integer,
    title character varying,
    body text,
    location text,
    gmap character varying,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_calendar_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_calendar_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_calendar_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_calendar_events_id_seq OWNED BY public.admin_calendar_events.id;


--
-- Name: admin_calendar_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_calendar_modules (
    id bigint NOT NULL,
    name character varying,
    layout character varying DEFAULT 'month_detailed'::character varying,
    admin_calendar_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_calendar_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_calendar_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_calendar_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_calendar_modules_id_seq OWNED BY public.admin_calendar_modules.id;


--
-- Name: admin_calendars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_calendars (
    id bigint NOT NULL,
    title character varying,
    calendar_events_count integer,
    locale character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_calendars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_calendars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_calendars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_calendars_id_seq OWNED BY public.admin_calendars.id;


--
-- Name: admin_carousel_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_carousel_modules (
    id bigint NOT NULL,
    name character varying,
    layout character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_carousel_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_carousel_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_carousel_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_carousel_modules_id_seq OWNED BY public.admin_carousel_modules.id;


--
-- Name: admin_carousel_slides; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_carousel_slides (
    id bigint NOT NULL,
    title character varying,
    body text,
    "position" integer DEFAULT 0,
    page_id integer,
    carousel_module_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone
);


--
-- Name: admin_carousel_slides_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_carousel_slides_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_carousel_slides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_carousel_slides_id_seq OWNED BY public.admin_carousel_slides.id;


--
-- Name: admin_csv_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_csv_imports (
    id bigint NOT NULL,
    name character varying,
    import_type character varying,
    comments text,
    summary text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    csv_file_file_name character varying,
    csv_file_content_type character varying,
    csv_file_file_size integer,
    csv_file_updated_at timestamp without time zone
);


--
-- Name: admin_csv_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_csv_imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_csv_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_csv_imports_id_seq OWNED BY public.admin_csv_imports.id;


--
-- Name: admin_dmi_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_dmi_modules (
    id bigint NOT NULL,
    forecast_duration character varying DEFAULT 'days_two_forecast'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_dmi_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_dmi_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_dmi_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_dmi_modules_id_seq OWNED BY public.admin_dmi_modules.id;


--
-- Name: admin_e_page_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_e_page_modules (
    id bigint NOT NULL,
    title character varying,
    body text,
    link character varying,
    image_link character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_e_page_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_e_page_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_e_page_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_e_page_modules_id_seq OWNED BY public.admin_e_page_modules.id;


--
-- Name: admin_featured_post_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_featured_post_modules (
    id bigint NOT NULL,
    title character varying,
    admin_blog_module_id integer,
    featured_posts_pr_page integer DEFAULT 16,
    content_type character varying DEFAULT 'featured_posts'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    blog_id integer
);


--
-- Name: admin_featured_post_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_featured_post_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_featured_post_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_featured_post_modules_id_seq OWNED BY public.admin_featured_post_modules.id;


--
-- Name: admin_footers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_footers (
    id bigint NOT NULL,
    title character varying DEFAULT ''::character varying,
    locale character varying,
    about_page_id integer,
    about_page_link_name character varying DEFAULT ''::character varying,
    copyright_page_id integer,
    "integer" integer,
    copyright_page_link_name character varying DEFAULT ''::character varying,
    term_of_usage_page_id integer,
    term_of_usage_page_link_name character varying,
    email character varying DEFAULT ''::character varying,
    company_name character varying DEFAULT ''::character varying,
    phone character varying DEFAULT ''::character varying,
    vat_nr character varying DEFAULT ''::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_footers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_footers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_footers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_footers_id_seq OWNED BY public.admin_footers.id;


--
-- Name: admin_gallery_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_gallery_images (
    id bigint NOT NULL,
    title character varying,
    body text,
    gallery_module_id integer,
    user_id bigint,
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone
);


--
-- Name: admin_gallery_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_gallery_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_gallery_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_gallery_images_id_seq OWNED BY public.admin_gallery_images.id;


--
-- Name: admin_gallery_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_gallery_modules (
    id bigint NOT NULL,
    name character varying,
    body text,
    layout character varying,
    page_id integer,
    color character varying DEFAULT '#000000'::character varying,
    background_color character varying DEFAULT '#FFFFFF'::character varying,
    gallery_images_count integer DEFAULT 0,
    images_pr_page integer DEFAULT 16,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_gallery_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_gallery_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_gallery_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_gallery_modules_id_seq OWNED BY public.admin_gallery_modules.id;


--
-- Name: admin_image_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_image_modules (
    id bigint NOT NULL,
    layout character varying,
    color character varying DEFAULT '#000000'::character varying,
    background_color character varying DEFAULT '#FFFFFF'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_image_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_image_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_image_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_image_modules_id_seq OWNED BY public.admin_image_modules.id;


--
-- Name: admin_menu_contents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_menu_contents (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_menu_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_menu_contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_menu_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_menu_contents_id_seq OWNED BY public.admin_menu_contents.id;


--
-- Name: admin_menu_links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_menu_links (
    id bigint NOT NULL,
    title character varying DEFAULT ''::character varying,
    page_id integer,
    url character varying DEFAULT ''::character varying,
    active boolean DEFAULT true,
    color character varying DEFAULT '#000'::character varying,
    background_color character varying DEFAULT '#FFF'::character varying,
    menu_content_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_menu_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_menu_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_menu_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_menu_links_id_seq OWNED BY public.admin_menu_links.id;


--
-- Name: admin_menu_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_menu_modules (
    id bigint NOT NULL,
    name character varying,
    menu_content_id integer,
    layout character varying DEFAULT 'vertical'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_menu_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_menu_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_menu_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_menu_modules_id_seq OWNED BY public.admin_menu_modules.id;


--
-- Name: admin_module_names; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_module_names (
    id bigint NOT NULL,
    name character varying,
    locale character varying,
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_module_names_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_module_names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_module_names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_module_names_id_seq OWNED BY public.admin_module_names.id;


--
-- Name: admin_post_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_post_modules (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_post_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_post_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_post_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_post_modules_id_seq OWNED BY public.admin_post_modules.id;


--
-- Name: admin_read_also_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_read_also_modules (
    id bigint NOT NULL,
    name character varying,
    blog_id integer,
    posts_pr_page integer DEFAULT 8,
    show_all_categories boolean DEFAULT true,
    image_on_top boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_read_also_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_read_also_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_read_also_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_read_also_modules_id_seq OWNED BY public.admin_read_also_modules.id;


--
-- Name: admin_subscription_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_subscription_modules (
    id bigint NOT NULL,
    title character varying,
    body text,
    layout character varying,
    expired_title character varying,
    expired_body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    locale character varying DEFAULT 'en'::character varying
);


--
-- Name: admin_subscription_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_subscription_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_subscription_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_subscription_modules_id_seq OWNED BY public.admin_subscription_modules.id;


--
-- Name: admin_subscription_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_subscription_types (
    id bigint NOT NULL,
    title character varying,
    body text,
    internet_version boolean,
    print_version boolean,
    price numeric,
    locale character varying,
    active boolean,
    duration integer,
    "position" integer DEFAULT 0,
    subscriptions_count integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    free boolean DEFAULT false,
    identifier character varying DEFAULT 'internal'::character varying
);


--
-- Name: admin_subscription_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_subscription_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_subscription_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_subscription_types_id_seq OWNED BY public.admin_subscription_types.id;


--
-- Name: admin_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_subscriptions (
    id bigint NOT NULL,
    user_id bigint,
    subscription_type_id integer,
    start_date date,
    end_date date,
    on_hold_date timestamp without time zone,
    subscription_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_subscriptions_id_seq OWNED BY public.admin_subscriptions.id;


--
-- Name: admin_system_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_system_messages (
    id bigint NOT NULL,
    title character varying,
    body text,
    identifier character varying,
    locale character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_system_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_system_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_system_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_system_messages_id_seq OWNED BY public.admin_system_messages.id;


--
-- Name: admin_system_setups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_system_setups (
    id bigint NOT NULL,
    maintenance boolean,
    landing_page_id integer,
    subscription_page_id integer,
    locale character varying,
    locale_name character varying,
    background_color character varying DEFAULT 'none'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    logo_file_name character varying,
    logo_content_type character varying,
    logo_file_size integer,
    logo_updated_at timestamp without time zone
);


--
-- Name: admin_system_setups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_system_setups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_system_setups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_system_setups_id_seq OWNED BY public.admin_system_setups.id;


--
-- Name: admin_text_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_text_modules (
    id bigint NOT NULL,
    title character varying DEFAULT ''::character varying,
    body text DEFAULT ''::text,
    url character varying,
    url_text character varying,
    page_id integer,
    color character varying DEFAULT '#000000'::character varying,
    background_color character varying DEFAULT '#FFFFFF'::character varying,
    border boolean DEFAULT false,
    image_style character varying DEFAULT 'full-width'::character varying,
    link_layout character varying DEFAULT 'text'::character varying,
    image_ratio character varying DEFAULT '2_1'::character varying,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone
);


--
-- Name: admin_text_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_text_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_text_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_text_modules_id_seq OWNED BY public.admin_text_modules.id;


--
-- Name: admin_youtube_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_youtube_modules (
    id bigint NOT NULL,
    name character varying,
    snippet text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_youtube_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_youtube_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_youtube_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_youtube_modules_id_seq OWNED BY public.admin_youtube_modules.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    comment text,
    user_id bigint,
    commentable_type character varying,
    commentable_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: e_paper_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.e_paper_tokens (
    id bigint NOT NULL,
    user_id bigint,
    secret character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: e_paper_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.e_paper_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: e_paper_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.e_paper_tokens_id_seq OWNED BY public.e_paper_tokens.id;


--
-- Name: page_col_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page_col_modules (
    id bigint NOT NULL,
    page_col_id bigint,
    moduleable_type character varying,
    moduleable_id bigint,
    "position" integer DEFAULT 0,
    margin_bottom integer DEFAULT 20,
    access_to character varying DEFAULT 'all'::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: page_col_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.page_col_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page_col_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.page_col_modules_id_seq OWNED BY public.page_col_modules.id;


--
-- Name: page_cols; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page_cols (
    id bigint NOT NULL,
    page_row_id bigint,
    layout character varying,
    index integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: page_cols_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.page_cols_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page_cols_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.page_cols_id_seq OWNED BY public.page_cols.id;


--
-- Name: page_rows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page_rows (
    id bigint NOT NULL,
    page_id bigint,
    layout character varying DEFAULT '12'::character varying,
    background_color character varying DEFAULT 'none'::character varying,
    padding_top integer DEFAULT 0,
    padding_bottom integer DEFAULT 0,
    "position" integer DEFAULT 0,
    background_image_file_name character varying,
    background_image_content_type character varying,
    background_image_file_size integer,
    background_image_updated_at timestamp without time zone,
    page_cols_count integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: page_rows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.page_rows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page_rows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.page_rows_id_seq OWNED BY public.page_rows.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pages (
    id bigint NOT NULL,
    title character varying,
    menu_title character varying,
    menu_id character varying DEFAULT 'not_in_any_menus'::character varying,
    menu_position integer DEFAULT 0,
    active boolean,
    locale character varying,
    body_background_file_name character varying,
    body_background_content_type character varying,
    body_background_file_size integer,
    body_background_updated_at timestamp without time zone,
    page_rows_count integer DEFAULT 0,
    background_color character varying DEFAULT 'none'::character varying,
    admin_footer_id bigint,
    cache_page boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id bigint NOT NULL,
    name character varying,
    address character varying,
    postal_code_and_city character varying,
    subscription_id integer,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pg_search_documents (
    id bigint NOT NULL,
    content text,
    searchable_type character varying,
    searchable_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pg_search_documents_id_seq OWNED BY public.pg_search_documents.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    user_id bigint,
    permission character varying DEFAULT 'member'::character varying,
    active boolean DEFAULT true,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying,
    signature character varying,
    email character varying DEFAULT ''::character varying NOT NULL,
    password_digest character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    avatar_file_name character varying,
    avatar_content_type character varying,
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    legacy_id integer,
    free_subscription boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    blog_posts_count integer DEFAULT 0,
    address character varying,
    postal_code_and_city character varying,
    legacy_subscription_id character varying,
    e_paper_tokens_count integer,
    gdpr_accepted boolean DEFAULT false
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: admin_advertisement_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_advertisement_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_advertisement_modules_id_seq'::regclass);


--
-- Name: admin_advertisements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_advertisements ALTER COLUMN id SET DEFAULT nextval('public.admin_advertisements_id_seq'::regclass);


--
-- Name: admin_blog_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_blog_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_blog_modules_id_seq'::regclass);


--
-- Name: admin_blog_posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_blog_posts ALTER COLUMN id SET DEFAULT nextval('public.admin_blog_posts_id_seq'::regclass);


--
-- Name: admin_blogs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_blogs ALTER COLUMN id SET DEFAULT nextval('public.admin_blogs_id_seq'::regclass);


--
-- Name: admin_calendar_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_calendar_events ALTER COLUMN id SET DEFAULT nextval('public.admin_calendar_events_id_seq'::regclass);


--
-- Name: admin_calendar_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_calendar_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_calendar_modules_id_seq'::regclass);


--
-- Name: admin_calendars id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_calendars ALTER COLUMN id SET DEFAULT nextval('public.admin_calendars_id_seq'::regclass);


--
-- Name: admin_carousel_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_carousel_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_carousel_modules_id_seq'::regclass);


--
-- Name: admin_carousel_slides id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_carousel_slides ALTER COLUMN id SET DEFAULT nextval('public.admin_carousel_slides_id_seq'::regclass);


--
-- Name: admin_csv_imports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_csv_imports ALTER COLUMN id SET DEFAULT nextval('public.admin_csv_imports_id_seq'::regclass);


--
-- Name: admin_dmi_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_dmi_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_dmi_modules_id_seq'::regclass);


--
-- Name: admin_e_page_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_e_page_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_e_page_modules_id_seq'::regclass);


--
-- Name: admin_featured_post_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_featured_post_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_featured_post_modules_id_seq'::regclass);


--
-- Name: admin_footers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_footers ALTER COLUMN id SET DEFAULT nextval('public.admin_footers_id_seq'::regclass);


--
-- Name: admin_gallery_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_gallery_images ALTER COLUMN id SET DEFAULT nextval('public.admin_gallery_images_id_seq'::regclass);


--
-- Name: admin_gallery_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_gallery_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_gallery_modules_id_seq'::regclass);


--
-- Name: admin_image_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_image_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_image_modules_id_seq'::regclass);


--
-- Name: admin_menu_contents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_menu_contents ALTER COLUMN id SET DEFAULT nextval('public.admin_menu_contents_id_seq'::regclass);


--
-- Name: admin_menu_links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_menu_links ALTER COLUMN id SET DEFAULT nextval('public.admin_menu_links_id_seq'::regclass);


--
-- Name: admin_menu_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_menu_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_menu_modules_id_seq'::regclass);


--
-- Name: admin_module_names id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_module_names ALTER COLUMN id SET DEFAULT nextval('public.admin_module_names_id_seq'::regclass);


--
-- Name: admin_post_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_post_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_post_modules_id_seq'::regclass);


--
-- Name: admin_read_also_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_read_also_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_read_also_modules_id_seq'::regclass);


--
-- Name: admin_subscription_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_subscription_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_subscription_modules_id_seq'::regclass);


--
-- Name: admin_subscription_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_subscription_types ALTER COLUMN id SET DEFAULT nextval('public.admin_subscription_types_id_seq'::regclass);


--
-- Name: admin_subscriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.admin_subscriptions_id_seq'::regclass);


--
-- Name: admin_system_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_system_messages ALTER COLUMN id SET DEFAULT nextval('public.admin_system_messages_id_seq'::regclass);


--
-- Name: admin_system_setups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_system_setups ALTER COLUMN id SET DEFAULT nextval('public.admin_system_setups_id_seq'::regclass);


--
-- Name: admin_text_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_text_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_text_modules_id_seq'::regclass);


--
-- Name: admin_youtube_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_youtube_modules ALTER COLUMN id SET DEFAULT nextval('public.admin_youtube_modules_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: e_paper_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.e_paper_tokens ALTER COLUMN id SET DEFAULT nextval('public.e_paper_tokens_id_seq'::regclass);


--
-- Name: page_col_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_col_modules ALTER COLUMN id SET DEFAULT nextval('public.page_col_modules_id_seq'::regclass);


--
-- Name: page_cols id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_cols ALTER COLUMN id SET DEFAULT nextval('public.page_cols_id_seq'::regclass);


--
-- Name: page_rows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_rows ALTER COLUMN id SET DEFAULT nextval('public.page_rows_id_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: pg_search_documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pg_search_documents ALTER COLUMN id SET DEFAULT nextval('public.pg_search_documents_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: admin_advertisement_modules admin_advertisement_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_advertisement_modules
    ADD CONSTRAINT admin_advertisement_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_advertisements admin_advertisements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_advertisements
    ADD CONSTRAINT admin_advertisements_pkey PRIMARY KEY (id);


--
-- Name: admin_blog_modules admin_blog_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_blog_modules
    ADD CONSTRAINT admin_blog_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_blog_posts admin_blog_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_blog_posts
    ADD CONSTRAINT admin_blog_posts_pkey PRIMARY KEY (id);


--
-- Name: admin_blogs admin_blogs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_blogs
    ADD CONSTRAINT admin_blogs_pkey PRIMARY KEY (id);


--
-- Name: admin_calendar_events admin_calendar_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_calendar_events
    ADD CONSTRAINT admin_calendar_events_pkey PRIMARY KEY (id);


--
-- Name: admin_calendar_modules admin_calendar_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_calendar_modules
    ADD CONSTRAINT admin_calendar_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_calendars admin_calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_calendars
    ADD CONSTRAINT admin_calendars_pkey PRIMARY KEY (id);


--
-- Name: admin_carousel_modules admin_carousel_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_carousel_modules
    ADD CONSTRAINT admin_carousel_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_carousel_slides admin_carousel_slides_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_carousel_slides
    ADD CONSTRAINT admin_carousel_slides_pkey PRIMARY KEY (id);


--
-- Name: admin_csv_imports admin_csv_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_csv_imports
    ADD CONSTRAINT admin_csv_imports_pkey PRIMARY KEY (id);


--
-- Name: admin_dmi_modules admin_dmi_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_dmi_modules
    ADD CONSTRAINT admin_dmi_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_e_page_modules admin_e_page_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_e_page_modules
    ADD CONSTRAINT admin_e_page_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_featured_post_modules admin_featured_post_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_featured_post_modules
    ADD CONSTRAINT admin_featured_post_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_footers admin_footers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_footers
    ADD CONSTRAINT admin_footers_pkey PRIMARY KEY (id);


--
-- Name: admin_gallery_images admin_gallery_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_gallery_images
    ADD CONSTRAINT admin_gallery_images_pkey PRIMARY KEY (id);


--
-- Name: admin_gallery_modules admin_gallery_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_gallery_modules
    ADD CONSTRAINT admin_gallery_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_image_modules admin_image_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_image_modules
    ADD CONSTRAINT admin_image_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_menu_contents admin_menu_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_menu_contents
    ADD CONSTRAINT admin_menu_contents_pkey PRIMARY KEY (id);


--
-- Name: admin_menu_links admin_menu_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_menu_links
    ADD CONSTRAINT admin_menu_links_pkey PRIMARY KEY (id);


--
-- Name: admin_menu_modules admin_menu_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_menu_modules
    ADD CONSTRAINT admin_menu_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_module_names admin_module_names_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_module_names
    ADD CONSTRAINT admin_module_names_pkey PRIMARY KEY (id);


--
-- Name: admin_post_modules admin_post_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_post_modules
    ADD CONSTRAINT admin_post_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_read_also_modules admin_read_also_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_read_also_modules
    ADD CONSTRAINT admin_read_also_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_subscription_modules admin_subscription_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_subscription_modules
    ADD CONSTRAINT admin_subscription_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_subscription_types admin_subscription_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_subscription_types
    ADD CONSTRAINT admin_subscription_types_pkey PRIMARY KEY (id);


--
-- Name: admin_subscriptions admin_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_subscriptions
    ADD CONSTRAINT admin_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: admin_system_messages admin_system_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_system_messages
    ADD CONSTRAINT admin_system_messages_pkey PRIMARY KEY (id);


--
-- Name: admin_system_setups admin_system_setups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_system_setups
    ADD CONSTRAINT admin_system_setups_pkey PRIMARY KEY (id);


--
-- Name: admin_text_modules admin_text_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_text_modules
    ADD CONSTRAINT admin_text_modules_pkey PRIMARY KEY (id);


--
-- Name: admin_youtube_modules admin_youtube_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_youtube_modules
    ADD CONSTRAINT admin_youtube_modules_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: e_paper_tokens e_paper_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.e_paper_tokens
    ADD CONSTRAINT e_paper_tokens_pkey PRIMARY KEY (id);


--
-- Name: page_col_modules page_col_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_col_modules
    ADD CONSTRAINT page_col_modules_pkey PRIMARY KEY (id);


--
-- Name: page_cols page_cols_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_cols
    ADD CONSTRAINT page_cols_pkey PRIMARY KEY (id);


--
-- Name: page_rows page_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_rows
    ADD CONSTRAINT page_rows_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_addresses_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_addresses_on_user_id ON public.addresses USING btree (user_id);


--
-- Name: index_admin_advertisements_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_advertisements_on_user_id ON public.admin_advertisements USING btree (user_id);


--
-- Name: index_admin_blog_modules_on_admin_blog_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_blog_modules_on_admin_blog_id ON public.admin_blog_modules USING btree (admin_blog_id);


--
-- Name: index_admin_blog_posts_on_blog_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_blog_posts_on_blog_id ON public.admin_blog_posts USING btree (blog_id);


--
-- Name: index_admin_blog_posts_on_post_page_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_blog_posts_on_post_page_id ON public.admin_blog_posts USING btree (post_page_id);


--
-- Name: index_admin_blog_posts_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_blog_posts_on_user_id ON public.admin_blog_posts USING btree (user_id);


--
-- Name: index_admin_calendar_events_on_calendar_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_calendar_events_on_calendar_id ON public.admin_calendar_events USING btree (calendar_id);


--
-- Name: index_admin_calendar_modules_on_admin_calendar_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_calendar_modules_on_admin_calendar_id ON public.admin_calendar_modules USING btree (admin_calendar_id);


--
-- Name: index_admin_carousel_slides_on_carousel_module_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_carousel_slides_on_carousel_module_id ON public.admin_carousel_slides USING btree (carousel_module_id);


--
-- Name: index_admin_carousel_slides_on_page_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_carousel_slides_on_page_id ON public.admin_carousel_slides USING btree (page_id);


--
-- Name: index_admin_featured_post_modules_on_admin_blog_module_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_featured_post_modules_on_admin_blog_module_id ON public.admin_featured_post_modules USING btree (admin_blog_module_id);


--
-- Name: index_admin_featured_post_modules_on_blog_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_featured_post_modules_on_blog_id ON public.admin_featured_post_modules USING btree (blog_id);


--
-- Name: index_admin_gallery_images_on_gallery_module_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_gallery_images_on_gallery_module_id ON public.admin_gallery_images USING btree (gallery_module_id);


--
-- Name: index_admin_gallery_images_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_gallery_images_on_user_id ON public.admin_gallery_images USING btree (user_id);


--
-- Name: index_admin_gallery_modules_on_page_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_gallery_modules_on_page_id ON public.admin_gallery_modules USING btree (page_id);


--
-- Name: index_admin_menu_links_on_menu_content_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_menu_links_on_menu_content_id ON public.admin_menu_links USING btree (menu_content_id);


--
-- Name: index_admin_menu_modules_on_menu_content_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_menu_modules_on_menu_content_id ON public.admin_menu_modules USING btree (menu_content_id);


--
-- Name: index_admin_read_also_modules_on_blog_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_read_also_modules_on_blog_id ON public.admin_read_also_modules USING btree (blog_id);


--
-- Name: index_admin_subscriptions_on_subscription_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_subscriptions_on_subscription_type_id ON public.admin_subscriptions USING btree (subscription_type_id);


--
-- Name: index_admin_subscriptions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_subscriptions_on_user_id ON public.admin_subscriptions USING btree (user_id);


--
-- Name: index_admin_text_modules_on_page_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_text_modules_on_page_id ON public.admin_text_modules USING btree (page_id);


--
-- Name: index_admin_text_modules_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_admin_text_modules_on_user_id ON public.admin_text_modules USING btree (user_id);


--
-- Name: index_comments_on_commentable_type_and_commentable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_commentable_type_and_commentable_id ON public.comments USING btree (commentable_type, commentable_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_e_paper_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_e_paper_tokens_on_user_id ON public.e_paper_tokens USING btree (user_id);


--
-- Name: index_page_col_modules_on_moduleable_type_and_moduleable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_page_col_modules_on_moduleable_type_and_moduleable_id ON public.page_col_modules USING btree (moduleable_type, moduleable_id);


--
-- Name: index_page_col_modules_on_page_col_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_page_col_modules_on_page_col_id ON public.page_col_modules USING btree (page_col_id);


--
-- Name: index_page_cols_on_page_row_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_page_cols_on_page_row_id ON public.page_cols USING btree (page_row_id);


--
-- Name: index_page_rows_on_page_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_page_rows_on_page_id ON public.page_rows USING btree (page_id);


--
-- Name: index_pages_on_admin_footer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pages_on_admin_footer_id ON public.pages USING btree (admin_footer_id);


--
-- Name: index_payments_on_subscription_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_subscription_id ON public.payments USING btree (subscription_id);


--
-- Name: index_payments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_user_id ON public.payments USING btree (user_id);


--
-- Name: index_pg_search_documents_on_searchable_type_and_searchable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pg_search_documents_on_searchable_type_and_searchable_id ON public.pg_search_documents USING btree (searchable_type, searchable_id);


--
-- Name: index_roles_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_user_id ON public.roles USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: comments fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payments fk_rails_081dc04a02; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_081dc04a02 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: page_cols fk_rails_201787f2bc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_cols
    ADD CONSTRAINT fk_rails_201787f2bc FOREIGN KEY (page_row_id) REFERENCES public.page_rows(id);


--
-- Name: pages fk_rails_3946a95689; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT fk_rails_3946a95689 FOREIGN KEY (admin_footer_id) REFERENCES public.admin_footers(id);


--
-- Name: page_rows fk_rails_4249a84b5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_rows
    ADD CONSTRAINT fk_rails_4249a84b5c FOREIGN KEY (page_id) REFERENCES public.pages(id);


--
-- Name: addresses fk_rails_48c9e0c5a2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fk_rails_48c9e0c5a2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: admin_subscriptions fk_rails_51a5739a4d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_subscriptions
    ADD CONSTRAINT fk_rails_51a5739a4d FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: e_paper_tokens fk_rails_9139f271b0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.e_paper_tokens
    ADD CONSTRAINT fk_rails_9139f271b0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: roles fk_rails_ab35d699f0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT fk_rails_ab35d699f0 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: page_col_modules fk_rails_f5beb58145; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_col_modules
    ADD CONSTRAINT fk_rails_f5beb58145 FOREIGN KEY (page_col_id) REFERENCES public.page_cols(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170930064038'),
('20170930065219'),
('20170930065619'),
('20170930065721'),
('20170930071223'),
('20170930071737'),
('20170930072304'),
('20170930072615'),
('20170930072732'),
('20170930074356'),
('20170930074912'),
('20170930075826'),
('20170930145916'),
('20170930145920'),
('20170930150242'),
('20170930150846'),
('20170930152126'),
('20170930155649'),
('20170930160211'),
('20170930164224'),
('20170930205607'),
('20171001064130'),
('20171001065140'),
('20171001070128'),
('20171001070730'),
('20171001073253'),
('20171001200008'),
('20171001200009'),
('20171001200010'),
('20171006153057'),
('20171006153058'),
('20171006161248'),
('20171011195027'),
('20171017163431'),
('20171024085909'),
('20180114183036'),
('20180114183057'),
('20180115170004'),
('20180115180019'),
('20180121190807'),
('20180209123317'),
('20180209125242'),
('20180210085551'),
('20180210123455'),
('20180228123738'),
('20180305090327'),
('20180511083726'),
('20180519085303'),
('20180519085712'),
('20180709091441'),
('20181012112027');


