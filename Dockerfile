FROM docker.io/rasa/rasa:3.6.21-full@sha256:5d6fe923a03dd01f022e3f598f39f25eb39db418c5f49bcd250db0d93cb0003c

WORKDIR /app

# Pindah ke ROOT agar diizinkan melakukan install dan chmod
USER root

COPY . .

# Install dependencies tambahan
RUN pip install rasa rasa-sdk psycopg2-binary python-dotenv

# Beri izin eksekusi pada script start
RUN chmod +x /app/start.sh

# Kembalikan ke user default Rasa (1001) demi keamanan produksi
USER 1001

# HAPUS CMD LAMA JIKA ADA, pastikan HANYA baris ini yang ada di paling bawah file:
CMD ["/app/start.sh"]