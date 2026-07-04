FROM rasa/rasa:3.6.21-full

WORKDIR /app
COPY . .

USER root
RUN pip install psycopg2-binary python-dotenv

USER 1001
EXPOSE 5005

ENTRYPOINT ["rasa"]
CMD ["run", "--enable-api", "--cors", "*", "--credentials", "credentials.yml", "--endpoints", "endpoints.yml"]
