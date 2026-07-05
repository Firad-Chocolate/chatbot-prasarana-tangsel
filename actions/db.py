"""
Modul koneksi database PostgreSQL untuk custom actions Rasa.
Konfigurasi diambil dari environment variable (lihat file .env / .env.example),
agar kredensial database tidak hardcode di kode.
"""

import os
import logging
from typing import Optional, List, Dict, Any, Tuple

import psycopg2
import psycopg2.extras
from dotenv import load_dotenv

load_dotenv()

logger = logging.getLogger(__name__)

DB_CONFIG = {
"host": os.environ.get("DB_HOST", "db.vvtxhftvgpkbsjslyrdo.supabase.co"),
    "port": os.environ.get("DB_PORT", "5432"),
    "dbname": os.environ.get("DB_NAME", "postgres"), # Supabase defaultnya adalah 'postgres'
    "user": os.environ.get("DB_USER", "postgres"),
    "password": os.environ.get("DB_PASSWORD", "W9txIcbXay1184Wm"),
    # "host": os.environ.get("DB_HOST", "localhost"),
    # "port": os.environ.get("DB_PORT", "5432"),
    # "dbname": os.environ.get("DB_NAME", "Prasarana_Olahraga_Tangsel"),
    # "user": os.environ.get("DB_USER", "postgres"),
    # "password": os.environ.get("DB_PASSWORD", "firad161002"),
}


def get_connection():
    """Membuka koneksi baru ke database PostgreSQL (pgAdmin 4)."""
    return psycopg2.connect(**DB_CONFIG)


def query_db(sql: str, params: Optional[Tuple] = None) -> Optional[List[Dict[str, Any]]]:
    """
    Menjalankan query SELECT dan mengembalikan list of dict.
    Mengembalikan None jika terjadi error koneksi/query (bukan list kosong,
    supaya action bisa membedakan 'gagal query' vs 'data tidak ditemukan').
    """
    conn = None
    try:
        conn = get_connection()
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cur:
            cur.execute(sql, params)
            rows = cur.fetchall()
            return [dict(r) for r in rows]
    except Exception as e:
        logger.error(f"Database error saat menjalankan query: {e}")
        return None
    finally:
        if conn is not None:
            conn.close()