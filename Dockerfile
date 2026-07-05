#FROM rasa/rasa:3.6.21-full
#
#WORKDIR /app
#COPY . .
#
#USER root
#RUN pip install psycopg2-binary python-dotenv
#
#USER 1001
#EXPOSE 5005
#
## Hapus baris ENTRYPOINT, langsung gunakan CMD teks biasa di bawah ini:
#CMD rasa run --enable-api --cors "*" --credentials credentials.yml --endpoints endpoints.yml --port $PORT

FROM rasa/rasa:3.6.15-full

WORKDIR /app
COPY . /app

# Pindah ke mode root sementara untuk mengatur izin file script
USER root

# Buat script penengah untuk menjalankan Core dan Actions bersamaan
RUN echo '#!/bin/bash \n\
rasa run actions -p 5055 & \n\
rasa run --enable-api --cors "*" -p $PORT' > /app/start.sh

RUN chmod +x /app/start.sh

# Kembalikan ke user default Rasa demi keamanan
USER 1001

CMD ["/app/start.sh"]