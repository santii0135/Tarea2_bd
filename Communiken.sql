PGDMP      /                |         
   Communiken %   14.12 (Ubuntu 14.12-0ubuntu0.22.04.1)    16.2 *               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                        0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            !           1262    41711 
   Communiken    DATABASE     t   CREATE DATABASE "Communiken" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
    DROP DATABASE "Communiken";
                postgres    false                        2615    100266    public    SCHEMA     2   -- *not* creating schema, since initdb creates it
 2   -- *not* dropping schema, since initdb creates it
                postgres    false            "           0    0    SCHEMA public    COMMENT         COMMENT ON SCHEMA public IS '';
                   postgres    false    5            #           0    0    SCHEMA public    ACL     +   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
                   postgres    false    5            �            1259    100267    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);
 &   DROP TABLE public._prisma_migrations;
       public         heap    postgres    false    5            �            1259    100359    bloquear    TABLE     w   CREATE TABLE public.bloquear (
    id integer NOT NULL,
    correo text NOT NULL,
    correo_bloquear text NOT NULL
);
    DROP TABLE public.bloquear;
       public         heap    postgres    false    5            �            1259    100358    bloquear_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bloquear_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.bloquear_id_seq;
       public          postgres    false    5    213            $           0    0    bloquear_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.bloquear_id_seq OWNED BY public.bloquear.id;
          public          postgres    false    212            �            1259    100388    correo    TABLE     �   CREATE TABLE public.correo (
    id integer NOT NULL,
    remitente_id integer NOT NULL,
    destinatario_id integer NOT NULL,
    asunto text NOT NULL,
    cuerpo text
);
    DROP TABLE public.correo;
       public         heap    postgres    false    5            �            1259    100387    correo_id_seq    SEQUENCE     �   CREATE SEQUENCE public.correo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.correo_id_seq;
       public          postgres    false    217    5            %           0    0    correo_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.correo_id_seq OWNED BY public.correo.id;
          public          postgres    false    216            �            1259    100368    favorito    TABLE     }   CREATE TABLE public.favorito (
    id integer NOT NULL,
    correo text NOT NULL,
    id_correo_favorito integer NOT NULL
);
    DROP TABLE public.favorito;
       public         heap    postgres    false    5            �            1259    100367    favorito_id_seq    SEQUENCE     �   CREATE SEQUENCE public.favorito_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.favorito_id_seq;
       public          postgres    false    5    215            &           0    0    favorito_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.favorito_id_seq OWNED BY public.favorito.id;
          public          postgres    false    214            �            1259    100350    user    TABLE     �   CREATE TABLE public."user" (
    id integer NOT NULL,
    nombre text NOT NULL,
    correo text NOT NULL,
    clave text NOT NULL,
    descripcion text
);
    DROP TABLE public."user";
       public         heap    postgres    false    5            �            1259    100349    user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public          postgres    false    5    211            '           0    0    user_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;
          public          postgres    false    210            w           2604    100362    bloquear id    DEFAULT     j   ALTER TABLE ONLY public.bloquear ALTER COLUMN id SET DEFAULT nextval('public.bloquear_id_seq'::regclass);
 :   ALTER TABLE public.bloquear ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    212    213            y           2604    100391 	   correo id    DEFAULT     f   ALTER TABLE ONLY public.correo ALTER COLUMN id SET DEFAULT nextval('public.correo_id_seq'::regclass);
 8   ALTER TABLE public.correo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            x           2604    100371    favorito id    DEFAULT     j   ALTER TABLE ONLY public.favorito ALTER COLUMN id SET DEFAULT nextval('public.favorito_id_seq'::regclass);
 :   ALTER TABLE public.favorito ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            v           2604    100353    user id    DEFAULT     d   ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);
 8   ALTER TABLE public."user" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211                      0    100267    _prisma_migrations 
   TABLE DATA           �   COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
    public          postgres    false    209   �-                 0    100359    bloquear 
   TABLE DATA           ?   COPY public.bloquear (id, correo, correo_bloquear) FROM stdin;
    public          postgres    false    213   �2                 0    100388    correo 
   TABLE DATA           S   COPY public.correo (id, remitente_id, destinatario_id, asunto, cuerpo) FROM stdin;
    public          postgres    false    217   �2                 0    100368    favorito 
   TABLE DATA           B   COPY public.favorito (id, correo, id_correo_favorito) FROM stdin;
    public          postgres    false    215   A3                 0    100350    user 
   TABLE DATA           H   COPY public."user" (id, nombre, correo, clave, descripcion) FROM stdin;
    public          postgres    false    211   o3       (           0    0    bloquear_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.bloquear_id_seq', 1, true);
          public          postgres    false    212            )           0    0    correo_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.correo_id_seq', 1, false);
          public          postgres    false    216            *           0    0    favorito_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.favorito_id_seq', 1, true);
          public          postgres    false    214            +           0    0    user_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.user_id_seq', 2, true);
          public          postgres    false    210            {           2606    100275 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public            postgres    false    209            �           2606    100366    bloquear bloquear_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.bloquear
    ADD CONSTRAINT bloquear_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.bloquear DROP CONSTRAINT bloquear_pkey;
       public            postgres    false    213            �           2606    100395    correo correo_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.correo
    ADD CONSTRAINT correo_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.correo DROP CONSTRAINT correo_pkey;
       public            postgres    false    217            �           2606    100375    favorito favorito_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.favorito
    ADD CONSTRAINT favorito_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.favorito DROP CONSTRAINT favorito_pkey;
       public            postgres    false    215            ~           2606    100357    user user_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public            postgres    false    211            |           1259    100376    user_correo_key    INDEX     K   CREATE UNIQUE INDEX user_correo_key ON public."user" USING btree (correo);
 #   DROP INDEX public.user_correo_key;
       public            postgres    false    211            �           2606    100377    bloquear bloquear_correo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.bloquear
    ADD CONSTRAINT bloquear_correo_fkey FOREIGN KEY (correo) REFERENCES public."user"(correo) ON UPDATE CASCADE ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public.bloquear DROP CONSTRAINT bloquear_correo_fkey;
       public          postgres    false    211    213    3196            �           2606    100382    favorito favorito_correo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorito
    ADD CONSTRAINT favorito_correo_fkey FOREIGN KEY (correo) REFERENCES public."user"(correo) ON UPDATE CASCADE ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public.favorito DROP CONSTRAINT favorito_correo_fkey;
       public          postgres    false    211    215    3196            �           2606    100396 )   favorito favorito_id_correo_favorito_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.favorito
    ADD CONSTRAINT favorito_id_correo_favorito_fkey FOREIGN KEY (id_correo_favorito) REFERENCES public.correo(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 S   ALTER TABLE ONLY public.favorito DROP CONSTRAINT favorito_id_correo_favorito_fkey;
       public          postgres    false    217    3204    215               �  x���k�c���W1�M�3O/bV0P�'�`��;4%pU������W�2ND��*�t��vu�Z��ZYc�+���vx�J/����V[��ۘ�w�b�Sˎo�y&��i�~�(.�_�~��p�^�j~���_
p������_���Qɺ����m��x�\V{_m��h��^v�Vå�=��|t�5���Q!!��99�����HN_��H�*_(4�|7���$T���;�,���ږ}�.hj�I�k��.a�v�o�y#�Ɛ1ynH�r�ɩnI���,�a���R���nq����D��܈�$��������_�&p��O0%Y���Ѡ�����yqb�}�[����9l����v����J�yԇ2�(=�e�٭Q��U�i�u�>���+�(I�/>-h�h�e!�j�5?�J�[[�ϔ�Q
6n�z"Z;:���mE�;v�T敭)Fc�ԟ@s�������:�<��	?�CW̭��6�~`:���y#c5K��t(`s��O��u��\� e>�	N_�+zh���R8���B��/ɑP}X� 9���1�o�HC�P�6��ʧ�����ٹ1$�LD�A�ifD�,V�}�I��񜜃�>��(�"wD1��|0�ڜ�tߗ�����,WXe��J�Wu�l�u�$��JAsR� �3��m���&Z*VM��)�a�O���k����4���/����:�p�0���r?s-9k��v����kC�#���T툀Y����#�_=�PAV>���S����������C��}��%^��,��:ign<��ћAa ZK�nsG�WO��BD�/@Deb<�w�l�_����-�\1�ݳW�e�������l+1�>��h%����|"b�D��s����-X;���3�h�)"���As����%|Sz�{-%F�`Q�e?X���%�	�}iv�����2r�0���\��l�nXM�LZ�Na����^�xN�~4;����Kգ��ui}�\z������׵:Zd����6q��[���l��m�G�m8a)�s&m$�H����ۮ����x_��y	��&�����+(.|�P�NŞ>GÑ�ba�W-s�q�9��)�Ya[Rs�����n���g�z{P`��Ʌ��4�_JqY�|�N/ ���?ΦW���b,�'פ�����(\ �='M��0t��]1
W�)��BЄ�CZv}N�'
��[E�{E>����o߾��y�         #   x�3�,N�+�t(-��K��L�ϫJ�r�b���� �J
X         F   x�%���@k{�H�a&�	&��'|����C��3-��
�1��ˤ�	f�ޤ�^��"cA�M�            x�3�,N�+�t(-��K��4����� N��         {   x�5�1�0g�z�;��/t��B!��S;��7IG�$���w��7s�b� ���m�?�vJ�'���T(���b<�U����+gc*2r�%k3����R��𥝤����p1�     