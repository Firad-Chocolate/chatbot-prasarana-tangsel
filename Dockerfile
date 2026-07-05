FROM rasa/rasa:3.6.21-full

WORKDIR /app
COPY . .

USER root
RUN pip install --no-cache-dir -r requirements.txt
#RUN pip install psycopg2-binary python-dotenv

USER 1001
EXPOSE 5005

# Hapus baris ENTRYPOINT, langsung gunakan CMD teks biasa di bawah ini:
CMD ["run", "--enable-api", "--cors", "*", "--credentials", "credentials.yml", "--endpoints", "endpoints.yml"]