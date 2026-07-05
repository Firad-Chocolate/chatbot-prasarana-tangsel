FROM rasa/rasa:3.6.21-full

WORKDIR /app
COPY . .

USER root
RUN pip install rasa rasa-sdk psycopg2-binary python-dotenv
#RUN pip install psycopg2-binary python-dotenv

USER 1001
EXPOSE 5005

# Hapus baris ENTRYPOINT, langsung gunakan CMD teks biasa di bawah ini:
CMD ["run", "--enable-api", "--cors", "*", "--credentials", "credentials.yml", "--endpoints", "endpoints.yml"]

# ... kode Dockerfile Anda yang sudah ada ...

# Salin script start ke dalam kontainer
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Jalankan script tersebut saat kontainer dimulai
CMD ["/app/start.sh"]